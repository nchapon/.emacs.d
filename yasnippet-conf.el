(require 'yasnippet)

;; Use only own snippets, do not use bundled ones
(setq yas/snippet-dirs '("~/.emacs.d/snippets"))
(yas/global-mode 1)


; No dropdowns please, yas
;;(setq yas/prompt-functions '(yas/ido-prompt yas/completing-prompt))

;; Wrap around region
(setq yas/wrap-around-region t)


;; fix org mode conflict
;; http://orgmode.org/manual/Conflicts.html
(defun yas/org-very-safe-expand ()
            (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
                    (lambda ()
                      (make-variable-buffer-local 'yas/trigger-key)
                      (setq yas/trigger-key [tab])
                      (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
                      (define-key yas/keymap [tab] 'yas/next-field)))


(provide 'yasnippet-conf)
