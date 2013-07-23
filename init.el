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


;; Setup packages
(require 'setup-package)


;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   (cons 'magit melpa)
   (cons 'auto-complete melpa)
   (cons 'fuzzy melpa)
   (cons 'popup melpa)
   (cons 'paredit melpa)
   (cons 'csv-mode melpa)
   (cons 'cl-lib gnu)
   (cons 'ido-ubiquitous marmalade)
   (cons 'move-text melpa)
   (cons 'gist melpa)
   (cons 'htmlize melpa)
   (cons 'smartparens melpa)
   (cons 'slime-js marmalade)
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
   (cons 'color-theme-solarized melpa)
   (cons 'nrepl melpa)
   (cons 'ac-nrepl melpa)))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))



;; configuration
(require 'appearence)
(require 'preferences)
(require 'mode-mappings)

(require 'ac-conf)
(require 'backup-conf)
(require 'clojure-conf)
(require 'functions)
(require 'ffip-conf)
(require 'ido-conf)
(require 'magit-conf)
(require 'markdown-conf)
(require 'mvn-help)
(require 'org-conf)
(require 'paredit-conf)
(require 'popwin-conf)
(require 'smex-conf)
(require 'yasnippet-conf)
(require 'init-csv-mode)

;;SetUp key bindings
(require 'bindings)


(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)
