;; Bindings here.

;; Navigation betweeen buffers with ALT+ARROWS
(windmove-default-keybindings 'meta)

;;; Rotate Window
(global-set-key (kbd "C-c w r") 'rotate-windows)

;;; Emacs Configuration File Shortcuts
(global-set-key (kbd "C-c I") 'my-init-file)
(global-set-key (kbd "C-c P") 'my-prefs-file)
(global-set-key (kbd "C-c B") 'my-bindings-file)


(provide 'nc-bindings)
