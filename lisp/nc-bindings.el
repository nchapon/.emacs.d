;; Bindings here.


;; Global key bindings
;;(global-set-key (kbd "RET")         'newline-and-indent)
(global-set-key (kbd "<delete>")    'delete-char)  ; delete == delete


(when (fboundp 'ibuffer)
  (global-set-key (kbd "C-x C-b") 'ibuffer))   ;; prefer ibuffer

;; Set help shortcut by default
(global-set-key (kbd "C-h") 'help-command)

;; Navigation betweeen buffers with ALT+ARROWS
(windmove-default-keybindings 'meta)





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


;;; Rotate Window
(global-set-key (kbd "C-c w r") 'rotate-windows)

;; Move line up or down
(global-set-key [(control shift up)]  'move-line-up)
(global-set-key [(control shift down)]  'move-line-down)



;;; Emacs Configuration File Shortcuts
(global-set-key (kbd "C-c I") 'my-init-file)
(global-set-key (kbd "C-c P") 'my-prefs-file)
(global-set-key (kbd "C-c B") 'my-bindings-file)
(global-set-key (kbd "C-c |") 'nc/split-window-right-and-move-there-dammit)
(global-set-key (kbd "C-c -") 'nc/toggle-window-split)



;;; Join lines



(require 'key-chord)


(key-chord-define-global "jj" 'ace-jump-word-mode)
(key-chord-define-global "jl" 'ace-jump-line-mode)
(key-chord-define-global "jk" 'ace-jump-char-mode)
(key-chord-define-global "FF" 'projectile-find-file)
(key-chord-define-global "GG" 'helm-projectile-ag)
(key-chord-define-global "HH" 'helm-git-grep)
(key-chord-define-global "KK" 'kill-whole-line)
(key-chord-define-global "JJ" 'jump-to-register)
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
