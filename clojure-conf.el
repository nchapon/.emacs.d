;; Clojure configuration mode
(require 'clojure-mode)
(require 'clojure-test-mode)

;; Enable Midje Mode
(require 'midje-mode)

(define-key clojure-mode-map (kbd "RET") 'newline-and-indent)

;; nrepl
(require 'nrepl)

;; Configure nrepl.el
(setq nrepl-hide-special-buffers t)
(setq nrepl-popup-stacktraces-in-repl t)
(setq nrepl-history-file "~/.emacs.d/nrepl-history")

(defadvice nrepl-default-err-handler (after select-nrepl-error-buffer activate)
  "Focus the error buffer after errors, like Emacs normally does."
  (select-window (get-buffer-window "*nrepl-error*")))




;; Repl mode hook
(add-hook 'nrepl-mode-hook 'subword-mode)


;; Auto completion for NREPL
(require 'ac-nrepl)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)




(provide 'clojure-conf)
