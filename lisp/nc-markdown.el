(require 'markdown-mode)


(add-hook 'markdown-mode-hook (lambda () (define-key markdown-mode-map (kbd "<tab>") 'yas/expand)))



(provide 'nc-markdown)
