;; HTML configuration mode




(eval-after-load "sgml-mode"
  '(progn
     (define-key html-mode-map (kbd "RET") 'newline-and-indent)
     (define-key html-mode-map (kbd "C->") 'sgml-close-tag)

     (require 'tagedit)
     (tagedit-add-paredit-like-keybindings)
     (add-hook 'html-mode-hook (lambda () (tagedit-mode 1)))))




(provide 'html-conf)
