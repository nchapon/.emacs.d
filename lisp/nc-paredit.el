;; My keybindings for paredit
(require 'paredit)
(require 'dash)

;; paredit for all lisps
(add-hook 'clojure-mode-hook (lambda () (paredit-mode 1)))
(add-hook 'nrepl-mode-hook (lambda () (paredit-mode 1)))
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode 1)))


;; Smart parens for others
;; https://gitlab.com/bodil/emacs-d/blob/master/bodil/bodil-smartparens.el
(require 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode t)

(setq-default sp-hybrid-kill-entire-symbol nil)

;; I hate sp-highlight-pair-overlay so much


(setq sp-highlight-pair-overlay nil)

(define-key sp-keymap (kbd "<delete>") 'sp-delete-char)
(define-key sp-keymap (kbd "C-<right>") 'sp-forward-slurp-sexp)
(define-key sp-keymap (kbd "C-<left>") 'sp-forward-barf-sexp)
(define-key sp-keymap (kbd "C-S-<right>") 'sp-backward-barf-sexp)
(define-key sp-keymap (kbd "C-S-<left>") 'sp-backward-slurp-sexp)
(define-key sp-keymap (kbd "M-s") 'sp-unwrap-sexp)
(define-key sp-keymap (kbd "M-S-s") 'sp-raise-sexp)
(define-key sp-keymap (kbd "M-i") 'sp-split-sexp)
(define-key sp-keymap (kbd "M-S-i") 'sp-join-sexp)
(define-key sp-keymap (kbd "M-t") 'sp-transpose-sexp)
(define-key sp-keymap (kbd "M-S-<left>") 'sp-backward-sexp)
(define-key sp-keymap (kbd "M-S-<right>") 'sp-forward-sexp)



(defun sp--my-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

(sp-with-modes '(c-mode c++-mode js-mode js2-mode java-mode
                        typescript-mode perl-mode)
  (sp-local-pair "{" nil :post-handlers
                 '((sp--my-create-newline-and-enter-sexp "RET"))))

(provide 'nc-paredit)
