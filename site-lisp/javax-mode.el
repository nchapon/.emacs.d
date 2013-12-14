;;; javax-mode.el --- Minor mode to improve java experience in Emacs
(require 'cc-mode)
(require 'compile)

(defun java-mvn-build ()
  "Builds current maven project"
  (interactive)
  (let* ((dir (file-name-as-directory (expand-file-name default-directory)))
         (found (file-exists-p (concat dir "pom.xml"))))
    (while (and (not found) (not (equal dir "/")))
      (setq dir (file-name-as-directory (expand-file-name (concat dir "..")))
            found (file-exists-p (concat dir "pom.xml"))))
    (if (not found)
        (message "No pom.xml found")
      (compile (read-from-minibuffer "Command: "
                                     (concat "mvn -f " dir "pom.xml clean install") nil nil 'compile-history)))))


(defun java-mvn-test ()
  "Runs mvn test from a buffer file"
  (interactive)
  (compile
        (format
         "cd %s; mvn -Dtest=%s test"
         (locate-dominating-file (buffer-file-name) "pom.xml")
         (car(split-string (buffer-name) "\\.")))))

;;; For maven 2/3 output
(add-to-list 'compilation-error-regexp-alist
             '("^.*?\\(/.*\\):\\[\\([0-9]*\\),\\([0-9]*\\)\\]" 1 2 3))


(defun java-path-for (package)
  "Convert PACKAGE name to real path."
  (interactive)
  (let ((segments (split-string package "\\." t)))
    (mapconcat 'identity segments "/")))


(defun java-find-package ()
  "Find current buffer package"
  (interactive)
  (save-excursion
    (goto-char (point-min))
       (when (re-search-forward "\\(^package \\(.*\\);$\\)" nil t))
          (match-string-no-properties 2)))


(defun java-find-symbol-package (symbol)
  "Find the package for the current SYMBOL"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((case-fold-search t))
      (if (re-search-forward (format "\\(^import \\(.*\\)%s;$\\)" symbol) nil t)
        (match-string-no-properties 2)
      (java-find-package)))))

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
  (let ((package (java-find-symbol-package symbol)))
    (shell-command-to-string
    (format "find %s -iname %s.java -print0 | grep -FzZ %s"
            (java-project-dir) symbol (java-path-for package)))))

(defun java-src-handler (symbol)
  "Create a handler to lookup java source code for SYMBOL"
  (let ((results (java-find-file symbol)))
    (cond
     ((string= "" results) (message "No source file for symbol %s" symbol))
     (t (find-file (first (split-string results)))))))

(defun java-src (query)
  "Open java source file for the given QUERY.
Defaults to the symbol at point. With prefix arg or no symbol under
point, prompts for a var"
  (interactive "P")
  (java-read-symbol-name "Class :" 'java-src-handler query))

(defun java-in-tests-p ()
  "Check whether the current file is a test file."
  (string-match-p "src/test/java" (buffer-file-name)))

(defun java-test-for (package)
  "Returns the path of the the test file for a given PACKAGE."
  (format
   "%ssrc/test/java/%s/%sTest.java"
   (locate-dominating-file (buffer-file-name) "pom.xml")
   (java-path-for package)
   (car (split-string (buffer-name) "\\.java"))))

(defun java-implementation-for (package)
  "Returns the path of the the implementaion file for a given PACKAGE."
  (format
   "%ssrc/main/java/%s/%s.java"
   (locate-dominating-file (buffer-file-name) "pom.xml")
   (java-path-for package)
   (car (split-string (buffer-name) "Test\\.java"))))

(defun java-jump-to-test ()
  "Jump from implementation file to test."
  (interactive)
    (find-file (java-test-for (java-find-package))))

(defun java-jump-to-implementation ()
  "Jump from test file to implementation."
  (find-file (java-implementation-for (java-find-package))))

(defun java-jump-between-tests-and-code ()
  "Jump between tests and code"
  (interactive)
  (if (java-in-tests-p)
       (java-jump-to-implementation)
    (java-jump-to-test)))


(defvar javax-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key java-mode-map (kbd "{") 'java-electric-brace)
    (define-key java-mode-map (kbd "C-c C-b") 'java-mvn-build)
    (define-key java-mode-map (kbd "C-c C-r") 'java-mvn-test)
    (define-key java-mode-map (kbd "C-c C-t") 'java-jump-between-tests-and-code)
    (define-key java-mode-map (kbd "C-c C-s") 'java-src)
    map)
  "Keymap for Javax mode.")


;;;###autoload
(define-minor-mode javax-mode
  "A minor mode to improve java experience."
  :lighter " jX"
  :keymap 'javax-mode-map)

;;;###autoload
(add-hook 'java-mode-hook 'javax-mode)

(provide 'javax-mode)
;;; javax.el ends here
