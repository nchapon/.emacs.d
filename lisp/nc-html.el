;; JS / HTML configuration mode
(require 'js2-refactor)


(eval-after-load "sgml-mode"
  '(progn
     (define-key html-mode-map (kbd "RET") 'newline-and-indent)
     (define-key html-mode-map (kbd "C-/") 'sgml-close-tag)

     (require 'tagedit)
     (tagedit-add-paredit-like-keybindings)
     (add-hook 'html-mode-hook (lambda () (tagedit-mode 1)))))


;; Don't override global M-j keybinding (join lines)
(eval-after-load "js2-mode"
  '(define-key js2-mode-map (kbd "M-j") nil))


(provide 'nc-html)
