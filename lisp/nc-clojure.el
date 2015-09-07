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

;;(setq cider-popup-stacktraces nil)
;;(setq cider-repl-popup-stacktraces t)
;;(setq cider-auto-select-error-buffer t)

;; nice pretty printing
(setq cider-repl-use-pretty-printing t)
;; nicer font lock in REPL
(setq cider-repl-use-clojure-font-lock t)

;; result prefix for the REPL
(setq cider-repl-result-prefix ";; => ")

(setq cider-repl-wrap-history t)

;; looong history
(setq cider-repl-history-size 3000)

;; REPL history file
(setq cider-repl-history-file "~/.emacs.d/cider-history")

;; error buffer not popping up
(setq cider-show-error-buffer nil)


;; Cider mode hook
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)


;; Auto completion for NREPL
(add-hook 'cider-repl-mode-hook 'company-mode)
(add-hook 'cider-mode-hook 'company-mode)


;; Refactor
(add-hook 'clojure-mode-hook
      (lambda ()
        (clj-refactor-mode 1)
        ;; insert keybinding setup here
        (cljr-add-keybindings-with-prefix "C-c RET")))

(add-hook 'clojure-mode-hook #'yas-minor-mode)

;; no auto sort
(setq cljr-auto-sort-ns nil)

;; do not prefer prefixes when using clean-ns
(setq cljr-favor-prefix-notation nil)



(provide 'nc-clojure)
