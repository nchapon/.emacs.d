(require 'use-package)


;;; AZ Settings
(defun az-settings ()
  "AZ Settings"
  (interactive)
  (setq nxml-child-indent 4)
  (setq javax-mvn-build-command "az-mvn -f %spom.xml clean install -Ptheme.skip,jrebel")
  (setq javax-mvn-compile-command "cd %s;az-mvn -o compile"))

;;; Org crypt to use GPG
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)



(setq org-agenda-files (list "~/notes/GTD/todo.org"
                             "~/notes/GTD/toread.org"
                             "~/notes/GTD/meetings.org"
                             "~/notes/GTD/tolearn.org"
                             "~/notes/GTD/tosee.org"))


;;; Edit my todo page
(defun nc/todo-page ()
  "Edit my todo list page"
  (interactive)
  (find-file-other-window "~/notes/GTD/todo.org"))

;;; Edit my meetings page
(defun nc/meetings-page ()
  "Edit my meetings page"
  (interactive)
  (find-file-other-window "~/notes/GTD/meetings.org"))

;;; Binding
(global-set-key "\C-cT" 'nc/todo-page)
(global-set-key "\C-cM" 'nc/meetings-page)



;; Capture mode
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/notes/GTD/todo.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("l" "To learn" entry (file+headline "~/notes/GTD/tolearn.org" "To Learn")
         "* TO_LEARN %?\n  %i\n  %a")
        ("r" "To read" entry (file+headline "~/notes/GTD/toread.org" "To Read")
         "* TO_READ %?\n  %i\n  %a")
        ("f" "FishLog" plain (file+datetree+prompt "~/notes/private/fishlog.org")
         "%[~/notes/templates/fishlog.org]"
         )
        ("j" "Journal" entry (file+datetree "~/notes/GTD/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))


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
   (sql . t)))

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


(use-package org-daypage
  :load-path "/home/nchapon/work/emacs-lisp/org-daypage/"
  :bind (("\C-cn" . todays-daypage)
         ("\C-c." . daypage-time-stamp)
         ("\C-ci" . daypage-new-item)
         ("\C-cN" . find-daypage))
  :init
  (setq daypage-path "/home/nchapon/notes/GTD/days/"))
