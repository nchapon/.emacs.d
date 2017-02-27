;; Bindings here.






;; Navigation betweeen buffers with ALT+ARROWS
(windmove-default-keybindings 'meta)




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



(provide 'nc-bindings)
