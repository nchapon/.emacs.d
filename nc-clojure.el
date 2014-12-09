;; Clojure configuration mode
(require 'clojure-mode)


;; Enable Midje Mode
(require 'midje-mode)


;;; ClojureScript
(add-to-list 'auto-mode-alist '("\\.cljs$" . clojure-mode))

(define-key clojure-mode-map (kbd "RET") 'newline-and-indent)

;; cider
(require 'cider)

;; Configure cider
(setq cider-hide-special-buffers t)
(setq cider-popup-stacktraces nil)
(setq cider-repl-popup-stacktraces t)
(setq cider-auto-select-error-buffer t)
(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 1000)
(setq cider-repl-history-file "~/.emacs.d/nrepl-history")


;; Cider mode hook
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)


;; Auto completion for NREPL
(add-hook 'cider-repl-mode-hook 'company-mode)
(add-hook 'cider-mode-hook 'company-mode)



(provide 'nc-clojure)
