(require 'use-package)

;;; Force projectile to use of external indexing in Windows
(setq projectile-indexing-method 'alien)

(custom-set-variables
 '(helm-ag-base-command "C:/PROGRAMJAVA/tools/pt -e --nocolor --nogroup"))


(defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
  "Use cygwin's /dev/null as the null-device."
  (let ((null-device "/dev/null"))
    ad-do-it))

(ad-activate 'grep-compute-defaults)

;;; Change fonts
(if (eq window-system 'w32)
    (set-default-font "-outline-Consolas-normal-r-normal-normal-14-97-96-96-c-*-iso8859-1"))

(use-package cygwin-mount
             :ensure t
             :config (cygwin-mount-activate))


;;; Agenda configuration
(setq org-agenda-files (list (nc/expand-org-notes-path "cnp/gtd.org")
                             (nc/expand-org-notes-path "GTD/todo.org")
                             (nc/expand-org-notes-path "GTD/learning.org")
                             (nc/expand-org-notes-path "GTD/journal.org")
                             (nc/expand-org-notes-path "GTD/books.org")
                             (nc/expand-org-notes-path "GTD/watching.org")
                             (nc/expand-org-notes-path "GTD/refile.org")
                             (nc/expand-org-notes-path "GTD/weekly-review.org")))

;;;;;;;;;;;;;;;;;;;;;;;;;
;; Password management ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package passthword
  :load-path "C:/PROGRAMJAVA/nchapon/lisp/passthword"
  :config
  (setq passthword-password-file "C:/PROGRAMJAVA/nchapon/passthword.gpg"))

(require 'ox-reveal)
(setq org-reveal-root ".")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; javax-mode configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'compile)

(use-package javax-mode
  :load-path "C:/PROGRAMJAVA/nchapon/lisp/javax-mode"
  :config
  (setq jx/mvn-repo-path "C:/PROGRAMJAVA/m2_repo")
  (setq jx/ecj-path "C:PROGRAMJAVA/nchapon/opt/bin/ecj-4.4.2.jar"))


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

(setq nxml-child-indent 4)


;;; Active org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)
   (sql . t)
   (sh . t)))

(setq org-plantuml-jar-path
      (expand-file-name "~/opt/lib/plantuml.jar"))

; Do not prompt to confirm evaluation
; This may be dangerous - make sure you understand the consequences
; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

; Use fundamental mode when editing plantuml blocks with C-c '
(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))
