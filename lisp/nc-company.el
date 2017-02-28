(require 'company)





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
