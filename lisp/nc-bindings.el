;; Bindings here.

;; Increase or decrease text scale:
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Global key bindings
;;(global-set-key (kbd "RET")         'newline-and-indent)
(global-set-key (kbd "C-<f4>")      'kill-buffer-and-window)
(global-set-key (kbd "<delete>")    'delete-char)  ; delete == delete
(global-set-key (kbd "M-g")         'goto-line)

(when (fboundp 'ibuffer)
  (global-set-key (kbd "C-x C-b") 'ibuffer))   ;; prefer ibuffer

;; Set help shortcut by default
(global-set-key (kbd "C-h") 'help-command)

;; Navigation betweeen buffers with ALT+ARROWS
(windmove-default-keybindings 'meta)

;; Prefer backward-kill-word over Backspace
;; https://sites.google.com/site/steveyegge2/effective-emacs
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(global-set-key (kbd "M-y") 'browse-kill-ring)


;; Find Recent File
(global-set-key (kbd "C-x C-r")   'helm-recentf)

;; Occurences in a file
(global-set-key "\C-co" 'occur)

;; loccur key bindings
;; defines shortcut for loccur of the current word
(require 'loccur)
(define-key global-map [(control o)] 'loccur-current)
;; defines shortcut for the interactive loccur command
(define-key global-map [(control meta o)] 'loccur)
;; defines shortcut for the loccur of the previously found word
(define-key global-map [(control shift o)] 'loccur-previous-match)

;;; Hippie expand
(global-set-key "\M- " 'hippie-expand)

;;; Rotate Window
(global-set-key (kbd "C-c w r") 'rotate-windows)

;; Move line up or down
(global-set-key [(control shift up)]  'move-line-up)
(global-set-key [(control shift down)]  'move-line-down)

;;; Ace Jump Mode key binding
(define-key global-map (kbd "C-c /") 'ace-jump-mode)
(define-key global-map (kbd "C-c k") 'ace-jump-mode-pop-mark)

;;; Expand Region
(global-set-key (kbd "C-=") 'er/expand-region)

;; Binding for custom functions

;;; Emacs Configuration File Shortcuts
(global-set-key (kbd "C-c I") 'my-init-file)
(global-set-key (kbd "C-c P") 'my-prefs-file)
(global-set-key (kbd "C-c B") 'my-bindings-file)
(global-set-key (kbd "C-c |") 'nc/split-window-right-and-move-there-dammit)
(global-set-key (kbd "C-c -") 'nc/toggle-window-split)

;; Duplicate current line or region
(global-set-key (kbd "C-c d") 'nc/duplicate-current-line-or-region)

;;; Join lines
(global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1)))


;;; Multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-$") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-S-b") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C-<") 'mc/mark-previous-word-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-word-like-this)
(global-set-key (kbd "C-*") 'mc/mark-next-like-this)
(global-set-key (kbd "C-%") 'mc/mark-all-dwim)



;; Gobal keys for usefuls functions

(global-set-key (kbd "<f1>") 'shell)
(global-set-key (kbd "<f2>") 'rgrep)
(global-set-key (kbd "C-<f2>") 'helm-do-ag)

(global-set-key (kbd "<f6>") 'magit-status)
(global-set-key (kbd "C-<f6>") 'speedbar)

;; Org mode keys
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
(global-set-key (kbd "<f9>") 'calendar)
(global-set-key (kbd "<f11>") 'org-clock-goto)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)


(require 'key-chord)


(key-chord-define-global "jj" 'ace-jump-word-mode)
(key-chord-define-global "jl" 'ace-jump-line-mode)
(key-chord-define-global "jk" 'ace-jump-char-mode)
(key-chord-define-global "FF" 'projectile-find-file)
(key-chord-define-global "GG" 'helm-projectile-ag)
(key-chord-define-global "HH" 'helm-git-grep)
(key-chord-define-global "JJ" 'nc/switch-to-previous-buffer)
(key-chord-define-global "DD" 'delete-region)
(key-chord-define-global "OO" 'helm-occur)
(key-chord-define-global "??" 'nc/helm-do-grep-notes)
(key-chord-define-global "BB" 'beginning-of-buffer)
(key-chord-define-global "$$" 'end-of-buffer)
(key-chord-define-global "uu" 'undo-tree-visualize)
(key-chord-define-global "xx" 'execute-extended-command)
(key-chord-define-global "qq" 'nc/cleanup-buffer-or-region)
(key-chord-define-global "yy" 'browse-kill-ring)

(key-chord-mode +1)



(provide 'nc-bindings)
