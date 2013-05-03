(require 'compile)





(defun mvn-test ()
  "Runs mvn test"
  (interactive)
  (setenv "JAVA_HOME" "/home/nchapon/opt/jdk1.6.0_37")
  (setenv "PATH"
          (concat "~/opt/bin:" (getenv "PATH")))
  (compile
        (format
         "cd %s; mvn clean -Dtest=%s test"
         (locate-dominating-file (buffer-file-name) "pom.xml")
         (car(split-string (buffer-name) "\\.")))))


;; (compile (format
;;          "cd %s; mvn -Dtest=%s test"
;;          (locate-dominating-file (buffer-file-name) "pom.xml")
;;          (car(split-string (buffer-name) "\\."))) )

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

(provide 'mvn-help)

;;; mvn-help.el ends here
