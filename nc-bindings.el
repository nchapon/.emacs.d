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

;; Orgmode keys
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

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
(global-set-key (kbd "C-x C-r")   'ido-recentf-open)

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

;; Hippie expand
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

;; Duplicate current line
(global-set-key (kbd "C-c d") 'my-duplicate-current-line-or-region)

;;; Join lines
(global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1)))

;;; Start playing with multiple cursors
;;; Multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-$") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-^") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C-<") 'mc/mark-previous-word-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-word-like-this)
(global-set-key (kbd "C-*") 'mc/mark-next-like-this)
(global-set-key (kbd "C-%") 'mc/mark-all-dwim)

;; (global-set-key (kbd "M-å") 'mc/mark-all-in-region)



;; Gobal keys for usefuls functions

(global-set-key (kbd "<f1>") 'shell)
(global-set-key (kbd "<f2>") 'rgrep)
(global-set-key (kbd "<f6>") 'magit-status)


(require 'key-chord)

(key-chord-define-global "jj" 'ace-jump-word-mode)
(key-chord-define-global "jl" 'ace-jump-line-mode)
(key-chord-define-global "jk" 'ace-jump-char-mode)
(key-chord-define-global "jf" 'projectile-find-file)
(key-chord-define-global "js" 'projectile-grep)
(key-chord-define-global "JJ" 'nc/switch-to-previous-buffer)
(key-chord-define-global "uu" 'undo-tree-visualize)
(key-chord-define-global "xx" 'execute-extended-command)
(key-chord-define-global "yy" 'browse-kill-ring)

(key-chord-mode +1)



(provide 'nc-bindings)
