(require 'company)

(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 2)
(setq company-show-numbers t)
(setq company-tooltip-limit 20)

(setq company-dabbrev-downcase nil)
(setq company-dabbrev-ignore-case t)

(setq company-dabbrev-code-ignore-case t)
(setq company-dabbrev-code-everywhere t)

(setq company-etags-ignore-case t)



(unless (face-attribute 'company-tooltip :background)
  (set-face-attribute 'company-tooltip nil :background "black" :foreground "gray40")
  (set-face-attribute 'company-tooltip-selection nil :inherit 'company-tooltip :background "gray15")
  (set-face-attribute 'company-preview nil :background "black")
  (set-face-attribute 'company-preview-common nil :inherit 'company-preview :foreground "gray40")
  (set-face-attribute 'company-scrollbar-bg nil :inherit 'company-tooltip :background "gray20")
  (set-face-attribute 'company-scrollbar-fg nil :background "gray40"))

;; Yasnippet is only accessible with ALT INSERT
(nc/after-load 'company
  (global-set-key (kbd "M-=") 'company-yasnippet))

(global-company-mode)

(provide 'nc-company)
