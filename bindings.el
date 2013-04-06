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


;; Find Recent File
(global-set-key (kbd "C-x C-r")   'ido-recentf-open)

;; Occurences in a file
(global-set-key "\C-co" 'occur)


;; Move line up or down
(global-set-key [(control shift up)]  'move-line-up)
(global-set-key [(control shift down)]  'move-line-down)





(provide 'bindings)
