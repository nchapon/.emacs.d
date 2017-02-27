
(setq user-full-name "Nicolas Chapon"
      user-mail-address "nchapon@gmail.com")

(setq use-package-verbose t)
(setq use-package-always-ensure t)
(require 'use-package)
(use-package auto-compile
  :config (auto-compile-on-load-mode))

(cond
 ((find-font (font-spec :name "Source Code Pro"))
   (set-frame-font "Source Code Pro-14" nil t)))

(use-package smart-mode-line)

(defalias 'yes-or-no-p 'y-or-n-p)

(auto-compression-mode t)

(setq line-number-mode t)
(setq column-number-mode t)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq  inhibit-startup-message t)

(use-package which-key
    :config
    (which-key-mode))

(setq
tmp-dir      (file-name-as-directory (concat user-emacs-directory "tmp"))
autosaves-dir(file-name-as-directory (concat tmp-dir  "autosaves"))
backups-dir  (file-name-as-directory (concat tmp-dir  "backups")))

(setq backup-directory-alist
      `(("." . ,(expand-file-name backups-dir))))

(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(setq initial-major-mode 'lisp-interaction-mode
      redisplay-dont-pause t
      column-number-mode t
      echo-keystrokes 0.02
      transient-mark-mode t
      shift-select-mode nil
      require-final-newline t
      truncate-partial-width-windows nil
      delete-by-moving-to-trash t
      confirm-nonexistent-file-or-buffer nil
      query-replace-highlight t)

(setq dired-recursive-delete 'always)
(setq dired-recursive-copy 'always)

(add-hook 'dired-load-hook
            (function (lambda () (load "dired-x"))))

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

(prefer-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(setq locale-coding-system 'utf-8-unix)
(setq coding-system-for-write 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8-unix)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
(setq file-name-coding-system  'utf-8)
(add-to-list 'auto-coding-alist '("." . utf-8))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(define-key global-map (kbd "RET") 'newline-and-indent)

(add-hook 'before-save-hook 'whitespace-cleanup)

(setq fill-column 80)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

(global-auto-revert-mode 1)

(setq global-auto-revert-non-file-buffers t)

(use-package projectile
  :diminish projectile-mode
  :config
  (progn
    (setq projectile-keymap-prefix (kbd "C-c p"))
    (setq projectile-enable-caching t)
    (add-to-list 'projectile-globally-ignored-directories "elpa")
    (add-to-list 'projectile-globally-ignored-directories ".cache")
    (add-to-list 'projectile-globally-ignored-directories "image-dired")
    (add-to-list 'projectile-globally-ignored-files "node_modules"))
  :config
  (projectile-global-mode))

(setq projectile-mode-line '(:eval (format " Proj[%s]" (projectile-project-name))))

(use-package helm
  :diminish helm-mode

  :config (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
                helm-input-idle-delay 0.01  ; this actually updates things
                                        ; reeeelatively quickly.
                helm-yas-display-key-on-candidate t
                helm-quick-update t
                helm-split-window-in-side-p t
                helm-buffers-fuzzy-matching t
                helm-move-to-line-cycle-in-source t
                helm-ff-search-library-in-sexp t
                helm-ff-file-name-history-use-recentf t
                helm-M-x-requires-pattern nil
                helm-ff-skip-boring-files t)

  :init (progn
          (require 'helm-config)
          (helm-mode t)
          (use-package helm-ag)

          (use-package helm-projectile))

  :bind (("C-x b" . helm-mini)
         ("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-h f" . helm-apropos)
         ("C-x C-b" . helm-buffers-list)
         ("M-y" . helm-show-kill-ring)
         ("M-x" . helm-M-x)
         ("C-x c o" . helm-occur)
         ("C-x c s" . helm-swoop)
         ("C-x C-r" . helm-recentf)
         ("C-x c y" . helm-yas-complete)
         ("C-x c Y" . helm-yas-create-snippet-on-region)
         ("C-x c SPC" . helm-all-mark-rings)))

(setq hippie-expand-try-functions-list
  '(try-complete-file-name-partially
    try-complete-file-name
    try-expand-all-abbrevs
    try-expand-dabbrev
    try-expand-dabbrev-visible
    try-expand-dabbrev-all-buffers
    try-expand-dabbrev-from-kill
    try-complete-lisp-symbol-partially
    try-complete-lisp-symbol))

(bind-key "M-/" 'hippie-expand)

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

(use-package ace-jump-mode
  :bind
  (("C-c /" . ace-jump-mode)
   ("C-c k". ace-jump-mode-pop-mark)))

(bind-key "\C-cl" 'org-store-link)
(bind-key "\C-cc" 'org-capture)
(bind-key "\C-ca" 'org-agenda)
(bind-key "\C-cb" 'org-iswitchb)

(use-package org-bullets
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-todo-keywords
      (quote ((sequence "TODO(t)"
                        "NEXT(n)"
                        "STARTED(s)"
                        "WAITING(w@/!)"
                        "SOMEDAY(.)" "|" "DONE(d!)" "CANCELLED(c@/!)")
              (sequence "MEETING(m)" "RDV(r)" "FORMATION(f)" "PHONE(p)" "|" "DONE(d)"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("STARTED" :foreground "orange" :weight bold)
              ("SOMEDAY" :foreground "dark gray" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "magenta" :weight bold)
              ("MEETING" :foreground "cyan" :weight bold)
              ("RDV" :foreground "cyan" :weight bold)
              ("FORMATION" :foreground "khaki" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold))))

(setq org-agenda-files (list "~/notes/GTD"))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(setq ediff-diff-options "-w")

(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(use-package lua-mode
  :ensure t
  :mode "\\.lua\\'")

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package markdown-mode
  :mode ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode)
  :config)

(use-package multiple-cursors
  :bind
  (("C-S-c C-S-c" .  mc/edit-lines)
   ("C-$" .  mc/edit-ends-of-lines)
   ("C-S-b" .  mc/edit-beginnings-of-lines)
   ("C-<" .  mc/mark-previous-word-like-this)
   ("C->" .  mc/mark-next-word-like-this)
   ("C-S-n" .  mc/mark-next-like-this)
   ("C-S-p" .  mc/mark-previous-like-this)
   ("C-*" .  mc/mark-all-dwim)))

(global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1)))

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)

(global-set-key (kbd "<f2>") 'rgrep)
(global-set-key (kbd "C-<f2>") 'helm-do-ag)

(global-set-key (kbd "<f6>") 'magit-status)
(global-set-key (kbd "C-<f6>") 'magit-log-buffer-file)

;; Org mode keys
(global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
(global-set-key (kbd "<f11>") 'org-clock-goto)
(global-set-key (kbd "<f12>") 'org-agenda)

(global-set-key (kbd "M-<f12>") 'shell)
(global-set-key (kbd "C-<f12>") 'helm-semantic-or-imenu)

(global-set-key (kbd "M-g")         'goto-line)


