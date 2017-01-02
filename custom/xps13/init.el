(require 'use-package)

(setq org-agenda-files (list (nc/expand-org-notes-path "GTD")
                             (nc/expand-org-notes-path "cnp/GTD")))

;;; Org crypt to use GPG
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)


;;; Publishing notes
(setq org-publish-project-alist
      '(

        ;; ... add all the components here (see below)...

        ("org-notes"
         :base-directory "~/notes/"
         :base-extension "org"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4       ; Just the default for this project.
         :auto-preamble t
         :style "<link rel=\"stylesheet\" title=\"Standard\" href=\"/home/nchapon/public_html/style/style.css\" type=\"text/css\" />"
         :section-numbers nil
         :table-of-contents nil
         )

        ;; These are static files (images, pdf, etc)
        ("org-static"
         :base-directory "~/notes/" ;; Change this to your local dir
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|txt\\|asc\\|svg"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("org" :components ("org-notes" "org-static"))))

;;; Active org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)
   (sql . t)
   (python .t)
   (sh . t)))


; Do not prompt to confirm evaluation
; This may be dangerous - make sure you understand the consequences
; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

(setq org-plantuml-jar-path
      (expand-file-name "~/opt/lib/plantuml.jar"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; javax-mode configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(use-package javax-mode
  :load-path "/home/nchapon/work/emacs-lisp/javax-mode.el/"
  :init
  (setq jx/mvn-repo-path "/home/nchapon/opt/m2_repo")
  (setq jx/ecj-path "/home/nchapon/opt/bin/ecj-4.4.2.jar"))

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

(add-hook 'java-mode-hook
          (lambda ()
            (c-set-offset 'substatement-open 0
                          (if (assoc 'inexpr-class c-offsets-alist)
                              (c-set-offset 'inexpr-class 0)))))
