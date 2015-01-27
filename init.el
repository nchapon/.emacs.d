(setq debug-on-error t)

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
(setq user-settings-dir (concat user-emacs-directory "custom/" (car (split-string system-name "\\."))))
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
(add-to-list 'package-archives gnu t)



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
   (cons 'ace-jump-mode melpa)
   (cons 'auto-complete melpa)
   (cons 'browse-kill-ring melpa)
   (cons 'cider melpa)
   (cons 'clojure-mode melpa)
   (cons 'color-theme-solarized melpa)
   (cons 'company melpa)
   (cons 'exec-path-from-shell melpa)
   (cons 'expand-region melpa)
   (cons 'feature-mode melpa)
   (cons 'flycheck melpa)
   (cons 'fuzzy melpa)
   (cons 'gist melpa)
   (cons 'git-commit-mode melpa)
   (cons 'gitconfig-mode melpa)
   (cons 'gitignore-mode melpa)
   (cons 'htmlize melpa)
   (cons 'ido-ubiquitous marmalade)
   (cons 'js2-mode melpa)
   (cons 'js2-refactor melpa)
   (cons 'key-chord melpa)
   (cons 'loccur melpa)
   (cons 'magit melpa)
   (cons 'magit-gh-pulls melpa)
   (cons 'markdown-mode melpa)
   (cons 'midje-mode melpa)
   (cons 'move-text melpa)
   (cons 'multiple-cursors melpa)
   (cons 'paredit melpa)
   (cons 'pkg-info melpa)
   (cons 'pomodoro melpa)
   (cons 'popup melpa)
   (cons 'popwin melpa)
   (cons 'projectile melpa)
   (cons 'restclient melpa)
   (cons 'smartparens melpa)
   (cons 'smart-mode-line melpa)
   (cons 'smex melpa)
   (cons 'tagedit melpa)
   (cons 'undo-tree melpa)
   (cons 'web-mode melpa)
   (cons 'yasnippet melpa)
   (cons 'yaml-mode melpa)
   (cons 'zenburn-theme melpa)))

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
(require 'nc-projectile)
(require 'nc-html)
(require 'nc-ido)
(require 'nc-magit)
(require 'nc-markdown)
(require 'nc-org)
(require 'nc-paredit)
(require 'nc-yasnippet)
(require 'nc-bindings)

;;; Be sure path is correctly initialized : need by cider and javax !
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;;; From https://github.com/magnars/.emacs.d/blob/master/init.el
;;; Conclude init by setting up specifics for the current system
(when (file-exists-p user-settings-dir)
  (mapc 'load (directory-files user-settings-dir t "^[^#].*el$")))
