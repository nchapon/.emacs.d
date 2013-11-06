(require 'compile)



;; Set up ENV variables to have the same as bash
(when (file-exists-p "~/.bash_profile")
  (setenv "JAVA_HOME" (shell-command-to-string "source ~/.bash_profile; echo -n $JAVA_HOME"))
  (setenv "PATH" (shell-command-to-string "source ~/.bash_profile; echo -n $PATH")))


(defun mvn(&optional args)
  "Searches up the path for a pom.xml"
  (interactive)
  (let* ((dir (file-name-as-directory (expand-file-name default-directory)))
(found (file-exists-p (concat dir "pom.xml"))))
    (while (and (not found) (not (equal dir "/")))
      (setq dir (file-name-as-directory (expand-file-name (concat dir "..")))
            found (file-exists-p (concat dir "pom.xml"))))
    (if (not found)
        (message "No pom.xml found")
      (compile (read-from-minibuffer "Command: "
                                     (concat "mvn -f " dir "pom.xml install") nil nil 'compile-history)))))

;;; For maven 2/3 output
(add-to-list 'compilation-error-regexp-alist
             '("^.*?\\(/.*\\):\\[\\([0-9]*\\),\\([0-9]*\\)\\]" 1 2 3))

(global-set-key (kbd "C-c m") 'mvn)




(defun mvn-test ()
  "Runs mvn test"
  (interactive)
  (compile
        (format
         "cd %s; mvn clean -Dtest=%s test"
         (locate-dominating-file (buffer-file-name) "pom.xml")
         (car(split-string (buffer-name) "\\.")))))



;;;###autoload
(defun mvn-buffer-init ()
  "Initialize a buffer.
   Use this as a hook function in java-mode."
  (make-variable-buffer-local 'compile-command)
  (setq compile-command
        (format
         "cd %s ; mvn -Dtest=%s test"
         (locate-dominating-file (buffer-file-name) "pom.xml") (buffer-name))))

;;;###autoload
(defun mvn-init ()
  "Initialize this package."
  (interactive)
  (add-hook 'java-mode-hook 'mvn-buffer-init))

(defun java-electric-brace ()
  "Insert automatically close brace after 2 new lines."
  (interactive)
  (insert " {")
  (backward-char)
  (fixup-whitespace)
  (move-end-of-line 1)
  (indent-for-tab-command)
  (insert "\n\n")
  (insert "}")
  (indent-for-tab-command)
  (previous-line)
  (indent-for-tab-command))

(defun java-symbol-at-point ()
  "Read symbol at point"
  (interactive)
  (let ((str (thing-at-point 'symbol)))
    str))

(defun java-read-symbol-name (prompt callback &optional query)
  "Read symbol name."
  (let ((symbol-name (java-symbol-at-point)))
    (cond
     ((not (or current-prefix-arg query (not symbol-name)))
      (funcall callback symbol-name))
     (t (funcall callback (read-from-minibuffer prompt))))))

(defun java-project-dir ()
  "Returns java project dir for current buffer"
  (locate-dominating-file (buffer-file-name) ".git"))

(defun java-find-file (symbol)
  "Find java file from project root"
  (shell-command-to-string
    (format "find %s -iname %s.java"
            (java-project-dir) symbol)))

(defun java-src-handler (symbol)
  "Create a handler to lookup java source code for SYMBOL"
  (let ((results (java-find-file symbol)))
    (cond
     ((string= "" results) (message "No source file for symbol %s" symbol))
     (t (find-file (first (split-string results)))))))

(defun java-src (query)
  "Open java source file for the given QUERY.
Defaults to the symbol ayt point. With prefix arg or no symbol under
point, prompts for a var"
  (interactive "P")
  (java-read-symbol-name "Class :" 'java-src-handler query))

;; Override key bindings
(eval-after-load 'cc-mode
'(progn
   (define-key java-mode-map (kbd "{") 'java-electric-brace)
   (define-key java-mode-map (kbd "C-c C-s") 'java-src)))


(provide 'java-conf)
;;; java-conf.el ends here
