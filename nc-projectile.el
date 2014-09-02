(projectile-global-mode)

;; Custom modeline indicator
(setq projectile-mode-line '(:eval (format " Proj[%s]" (projectile-project-name))))


(provide 'nc-projectile)
