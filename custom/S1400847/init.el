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
(setq org-agenda-files (list (nc/expand-org-notes-path "cnp/GTD")
                             (nc/expand-org-notes-path "GTD")))

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
   (ditaa . t)
   (sh . t)))

(setq org-plantuml-jar-path
      (expand-file-name "~/opt/lib/plantuml.jar"))

(setq org-ditaa-jar-path
      (expand-file-name "~/opt/lib/ditaa0_9.jar"))


; Do not prompt to confirm evaluation
; This may be dangerous - make sure you understand the consequences
; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

; Use fundamental mode when editing plantuml blocks with C-c '
(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))

;;;;;;;;;;;;;;;;;;;;;
;; Which key mode  ;;
;;;;;;;;;;;;;;;;;;;;;

(use-package which-key-mode
  :load-path "C:/PROGRAMJAVA/nchapon/lisp/emacs-which-key")

(require 'which-key)
(which-key-mode)



;;

(setq org-html-head "<link rel='stylesheet' type='text/css' href='styles/readtheorg/css/htmlize.css'/>
 <link rel='stylesheet' type='text/css' href='styles/readtheorg/css/readtheorg.css'/>
 <script src='https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
 <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js'></script>
 <script type='text/javascript' src='styles/lib/js/jquery.stickytableheaders.min.js'></script>
 <script type='text/javascript' src='styles/readtheorg/js/readtheorg.js'></script>")


(setq org-publish-project-alist
      '(

        ;; ... add all the components here (see below)...

        ("org-notes"
         :base-directory "c:/PROGRAMJAVA/nchapon/notes/cnp"
         :base-extension "org"
         :publishing-directory "c:/PROGRAMJAVA/nchapon/public_html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4       ; Just the default for this project.
         :auto-preamble t
         :section-numbers nil
         :table-of-contents nil
         )

        ;; These are static files (images, pdf, etc)
        ("org-static"
         :base-directory "c:/PROGRAMJAVA/nchapon/notes" ;; Change this to your local dir
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|txt\\|asc\\|svg"
         :publishing-directory "c:/PROGRAMJAVA/nchapon/public_html/"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("org" :components ("org-notes" "org-static"))))
