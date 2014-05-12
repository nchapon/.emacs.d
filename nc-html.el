;; JS / HTML configuration mode
(require 'js2-refactor)

(add-to-list 'auto-mode-alist '("\\.html\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.tag$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.ftl$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))


(eval-after-load "sgml-mode"
  '(progn
     (define-key html-mode-map (kbd "RET") 'newline-and-indent)
     (define-key html-mode-map (kbd "C-/") 'sgml-close-tag)

     (require 'tagedit)
     (tagedit-add-paredit-like-keybindings)
     (add-hook 'html-mode-hook (lambda () (tagedit-mode 1)))))


(provide 'nc-html)
