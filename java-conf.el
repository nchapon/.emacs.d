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



(defun my-electric-brace ()
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

(eval-after-load 'cc-mode
  '(define-key java-mode-map (kbd "{") 'my-electric-brace))

(provide 'java-conf)

;;; java-conf.el ends here
