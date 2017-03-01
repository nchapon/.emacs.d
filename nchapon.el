
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

(defun nc/rename-file-and-buffer ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defun nc/delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (when (y-or-n-p (format "Are you sure you want to delete %s? " filename))
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))

(use-package projectile
  :diminish projectile-mode
  :init (progn
          (setq projectile-keymap-prefix (kbd "C-c p"))
          (setq projectile-enable-caching t))

  :config
  (add-to-list 'projectile-globally-ignored-directories "elpa")
  (add-to-list 'projectile-globally-ignored-directories "target")
  (add-to-list 'projectile-globally-ignored-directories ".cache")
  (add-to-list 'projectile-globally-ignored-directories "image-dired")
  (add-to-list 'projectile-globally-ignored-files "node_modules")
  (projectile-global-mode))

(setq projectile-mode-line '(:eval (format " Proj[%s]" (projectile-project-name))))

(use-package company
  :defer t
  :diminish ""
  :bind ("C-." . company-complete)
  :init (global-company-mode)
  :config
  (progn
    (setq company-idle-delay 0.1
          ;; min prefix of 1 chars
          company-minimum-prefix-length 1
          company-selection-wrap-around t
          company-show-numbers t
          company-dabbrev-downcase nil
          company-dabbrev-code-everywhere t
          company-transformers '(company-sort-by-occurrence))
    (bind-keys :map company-active-map
               ("C-n" . company-select-next)
               ("C-p" . company-select-previous)
               ("C-d" . company-show-doc-buffer)
               ("<tab>" . company-complete))))

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
                helm-ff-skip-boring-files t
                helm-for-files-preferred-list (quote (helm-source-files-in-current-dir helm-source-recentf helm-source-bookmarks helm-source-file-cache helm-source-buffers-list helm-source-locate helm-source-ls-git)))

  :init (progn
          (require 'helm-config)
          (helm-mode t)

          (use-package helm-projectile)
          (helm-projectile-on))

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

(use-package helm-ag)

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

(use-package ace-window
  :bind (([remap other-window] . ace-window))
  :config
  (setq aw-keys '(?q ?s ?d ?f ?g ?h ?j ?k ?l))
  ;; increase size face
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-foreground :height 3.0))))))

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

(use-package smartparens
  :defer t
  :diminish ""
  :init
  (progn
    (add-hook 'prog-mode-hook #'turn-on-smartparens-mode)
    ;; turn on showing the match for clojure and elisp
    (add-hook 'clojure-mode-hook #'turn-on-show-smartparens-mode)
    (add-hook 'emacs-lisp-mode-hook #'turn-on-show-smartparens-mode)
    (add-hook 'java-mode-hook #'turn-on-show-smartparens-mode)
    (add-hook 'c-mode-hook #'turn-on-show-smartparens-mode))
  :config
  (setq-default sp-hybrid-kill-entire-symbol nil)

  (setq sp-highlight-pair-overlay nil)

  (define-key sp-keymap (kbd "<delete>") 'sp-delete-char)
  (define-key sp-keymap (kbd "C-<right>") 'sp-forward-slurp-sexp)
  (define-key sp-keymap (kbd "C-<left>") 'sp-forward-barf-sexp)
  (define-key sp-keymap (kbd "C-S-<right>") 'sp-backward-barf-sexp)
  (define-key sp-keymap (kbd "C-S-<left>") 'sp-backward-slurp-sexp)
  (define-key sp-keymap (kbd "M-s") 'sp-unwrap-sexp)
  (define-key sp-keymap (kbd "M-S-s") 'sp-raise-sexp)
  (define-key sp-keymap (kbd "M-i") 'sp-split-sexp)
  (define-key sp-keymap (kbd "M-S-i") 'sp-join-sexp)
  (define-key sp-keymap (kbd "M-t") 'sp-transpose-sexp)
  (define-key sp-keymap (kbd "M-S-<left>") 'sp-backward-sexp)
  (define-key sp-keymap (kbd "M-S-<right>") 'sp-forward-sexp)



  (defun sp--my-create-newline-and-enter-sexp (&rest _ignored)
    "Open a new brace or bracket expression, with relevant newlines and indent. "
    (newline)
    (indent-according-to-mode)
    (forward-line -1)
    (indent-according-to-mode))

  (sp-with-modes '(c-mode c++-mode js-mode js2-mode java-mode
                          typescript-mode perl-mode)
    (sp-local-pair "{" nil :post-handlers
                   '((sp--my-create-newline-and-enter-sexp "RET")))))

(use-package yasnippet
  :defer t
  :diminish yas-minor-mode
  :init (progn
          (yas-global-mode 1)
          (yas-reload-all)))

(use-package helm-c-yasnippet
  :ensure t
  :after yasnippet
  :init (bind-key "M-=" #'helm-yas-complete)
  :config (setq helm-yas-space-match-any-greedy t))

(defun nc/duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated.  However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (-dotimes arg
                (lambda (n)
                  (goto-char end)
                  (newline)
                  (insert region)
                  (setq end (point))))
      (goto-char (+ origin (* (length region) arg) arg)))))

(bind-key "C-c d" 'nc/duplicate-current-line-or-region)

(defun nc/move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(global-set-key [(control shift up)]  'nc/move-line-up)

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(control shift down)]  'move-line-down)

(global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1)))

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(defun nc/copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

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

(defun nc/toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(bind-key "C-c -" 'nc/toggle-window-split)

(defun nc/split-window-right-and-move-there-dammit ()
  (interactive)
  (split-window-right)
  (windmove-right))

(bind-key "C-c |" 'nc/split-window-right-and-move-there-dammit)

(use-package key-chord
  :init
  (key-chord-mode 1)
  (key-chord-define-global "jj" 'ace-jump-word-mode)
  (key-chord-define-global "jl" 'ace-jump-line-mode)
  (key-chord-define-global "jk" 'ace-jump-char-mode)
  (key-chord-define-global "FF" 'projectile-find-file)
  (key-chord-define-global "GG" 'helm-projectile-ag)
  (key-chord-define-global "KK" 'kill-whole-line)
  (key-chord-define-global "JJ" 'jump-to-register)
  (key-chord-define-global "DD" 'delete-region)
  (key-chord-define-global "OO" 'helm-occur)
  (key-chord-define-global "??" 'nc/helm-do-grep-notes)
  (key-chord-define-global "BB" 'beginning-of-buffer)
  (key-chord-define-global "$$" 'end-of-buffer)
  (key-chord-define-global "xx" 'execute-extended-command)
  (key-chord-define-global "qq" 'nc/cleanup-buffer-or-region)
  (key-chord-define-global "yy" 'browse-kill-ring)
  )
