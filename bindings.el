;; Bindings here.

;; Increase or decrease text scale:
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)


;; Orgmode keys
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;set help shortcut by default
(global-set-key (kbd "C-h") 'help-command)

;; Navigation betweeen buffers with ALT+ARROWS
(windmove-default-keybindings 'meta)

;; Prefer backward-kill-word over Backspace
;; https://sites.google.com/site/steveyegge2/effective-emacs
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)


(provide 'bindings)
