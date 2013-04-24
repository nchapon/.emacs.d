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
