;; My keybindings for paredit
(require 'paredit)
(require 'dash)

(add-hook 'clojure-mode-hook (lambda () (paredit-mode 1)))
(add-hook 'nrepl-mode-hook (lambda () (paredit-mode 1)))
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode 1)))


(provide 'paredit-conf)

