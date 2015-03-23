(require 'compile)


(setq jx/mvn-repo-path "/home/nchapon/opt/m2_repo")
;;(setq jx/ecj-path "/home/nchapon/opt/bin/ecj-4.4M6.jar")
(setq jx/ecj-path "/home/nchapon/opt/bin/ecj-P20140317-1600.jar")


;; Set up ENV variables to have the same as bash
(when (file-exists-p "~/.bash_profile")
  (setenv "JAVA_HOME" (shell-command-to-string "source ~/.bash_profile; echo -n $JAVA_HOME"))
  (setenv "PATH" (shell-command-to-string "source ~/.bash_profile; echo -n $PATH")))


(defun java-package ()
  "Returns java package name for the current buffer."
  (interactive)
  (--reduce
   (format "%s.%s" acc it)
   (split-string
    (-last-item (s-split "src/main/java/\\|src/test/java/" default-directory))
    "/" t)))

(defun java-class-name ()
  "Returns java class name for the current buffer."
  (interactive)
  (file-name-sans-extension (buffer-name)))


(require 'javax-mode)

(provide 'nc-java)
