;;(setq debug-on-error t)

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(setq
 tmp-dir      (file-name-as-directory (concat user-emacs-directory "tmp"))
 autosaves-dir(file-name-as-directory (concat tmp-dir  "autosaves"))
 backups-dir  (file-name-as-directory (concat tmp-dir  "backups")))

;; create tmp dirs if necessary
(make-directory tmp-dir t)
(make-directory autosaves-dir t)
(make-directory backups-dir t)

;; Set up load path
(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path site-lisp-dir)

;;; Add user specific config
(setq user-settings-dir (concat user-emacs-directory "custom/" user-login-name))
(add-to-list 'load-path user-settings-dir)


;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;;;
;;; Setup packages
;;;
(require 'package)

(defvar marmalade '("marmalade" . "http://marmalade-repo.org/packages/"))
(defvar gnu '("gnu" . "http://elpa.gnu.org/packages/"))
(defvar melpa '("melpa" . "http://melpa.milkbox.net/packages/"))

;; Add marmalade to package repos
(add-to-list 'package-archives marmalade)
(add-to-list 'package-archives melpa t)

(package-initialize)

(unless (and (file-exists-p "~/.emacs.d/elpa/archives/marmalade")
             (file-exists-p "~/.emacs.d/elpa/archives/gnu")
             (file-exists-p "~/.emacs.d/elpa/archives/melpa"))
  (package-refresh-contents))

(defun packages-install (&rest packages)
  (mapc (lambda (package)
          (let ((name (car package))
                (repo (cdr package)))
            (when (not (package-installed-p name))
              (let ((package-archives (list repo)))
                (package-initialize)
                (package-install name)))))
        packages)
  (package-initialize)
  (delete-other-windows))


;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   (cons 'magit melpa)
   (cons 'auto-complete melpa)
   (cons 'loccur melpa)
   (cons 'fuzzy melpa)
   (cons 'popup melpa)
   (cons 'paredit melpa)
   (cons 'tagedit melpa)
   (cons 'ido-ubiquitous marmalade)
   (cons 'move-text melpa)
   (cons 'gist melpa)
   (cons 'htmlize melpa)
   (cons 'smartparens melpa)
   (cons 'git-commit-mode melpa)
   (cons 'gitconfig-mode melpa)
   (cons 'gitignore-mode melpa)
   (cons 'clojure-mode melpa)
   (cons 'clojure-test-mode melpa)
   (cons 'browse-kill-ring melpa)
   (cons 'ace-jump-mode melpa)
   (cons 'midje-mode melpa)
   (cons 'popwin melpa)
   (cons 'markdown-mode melpa)
   (cons 'pomodoro melpa)
   (cons 'undo-tree melpa)
   (cons 'find-file-in-project marmalade)
   (cons 'smex melpa)
   (cons 'yasnippet melpa)
   (cons 'expand-region melpa)
   (cons 'color-theme-solarized melpa)
   (cons 'zenburn-theme melpa)
   (cons 'pkg-info melpa)
   (cons 'cider melpa)
   (cons 'ac-nrepl melpa)
   (cons 'feature-mode melpa)
   (cons 'multiple-cursors melpa)))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))


;;;
;;; custom configuration
;;;

(require 'nc-appearence)
(require 'nc-preferences)
(require 'nc-ac)
(require 'nc-clojure)
(require 'nc-functions)
(require 'nc-ffip)
(require 'nc-html)
(require 'nc-ido)
(require 'nc-magit)
(require 'nc-markdown)
(require 'nc-java)
(require 'nc-org)
(require 'nc-paredit)
(require 'nc-yasnippet)
(require 'nc-bindings)


;;; From https://github.com/magnars/.emacs.d/blob/master/init.el
;;; Conclude init by setting up specifics for the current user
(when (file-exists-p user-settings-dir)
  (mapc 'load (directory-files user-settings-dir t "^[^#].*el$")))
