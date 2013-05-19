;; Clojure configuration mode

;; Enable Midje Mode
(require 'midje-mode)


;; nrepl
(require 'nrepl)

;; Configure nrepl.el
(setq nrepl-hide-special-buffers t)
(setq nrepl-popup-stacktraces-in-repl t)
(setq nrepl-history-file "~/.emacs.d/nrepl-history")

;; Repl mode hook
(add-hook 'nrepl-mode-hook 'subword-mode)


;; Auto completion for NREPL
(require 'ac-nrepl)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)



(provide 'clojure-conf)
