;;use file path to ensure buffer name uniqueness
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; Copy Paste
;; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)

;; Enable CUA mode
(cua-mode t)
(setq cua-enable-cua-keys t)

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)


;; Move files to trash when deleting
(setq delete-by-moving-to-trash t)

;; Real emacs knights don't use shift to mark things
(setq shift-select-mode nil)

;; Transparently open compressed files
(auto-compression-mode t)

;; Enable syntax highlighting for older Emacsen that have it off
(global-font-lock-mode t)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

(setq initial-major-mode 'lisp-interaction-mode
      redisplay-dont-pause t
      column-number-mode t
      echo-keystrokes 0.02
      inhibit-startup-message t
      transient-mark-mode t
      shift-select-mode nil
      require-final-newline t
      truncate-partial-width-windows nil
      delete-by-moving-to-trash nil
      confirm-nonexistent-file-or-buffer nil
      query-replace-highlight t)


;; Set all coding systems to utf-8
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Default indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;;(setq indent-line-function 'insert-tab)


;; Always display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

;;; Enable recent files mode.
;;; get rid of `find-file-read-only' and replace it with something
;;; more useful.
(require 'recentf)
(setq recentf-save-file (concat tmp-dir "recentf")
      recentf-max-saved-items 200)
(recentf-mode t)

;;; IDO recent file
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))


;;; Browse Kill Ring
(require 'browse-kill-ring)

(setq browse-kill-ring-highlight-current-entry t)
(setq browse-kill-ring-no-duplicates t)
(setq browse-kill-ring-display-duplicates nil)
(setq browse-kill-ring-highlight-inserted-item nil)


;;; Enable winner mode for C-c-(<left>|<right>) to navigate the history
;;; of buffer changes i.e. undo a split screen
(when (fboundp 'winner-mode)
      (winner-mode 1))


;;; Remove all trailing whitespace and trailing blank lines before
;;; saving the file
(add-hook 'before-save-hook 'whitespace-cleanup)


;;; Always delete and copy recursively
(setq dired-recursive-delete 'always)
(setq dired-recursive-copy 'always)

;;; Enable C-x C-j
(require 'dired-x)

;;; Undo Tree Mode
(global-undo-tree-mode)

;;; Ace Jump Mode
(require 'ace-jump-mode)


;;; Expand Region
(require 'expand-region)


(provide 'preferences)
