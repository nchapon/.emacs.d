(projectile-global-mode)

;; Custom modeline indicator
(setq projectile-mode-line '(:eval (format " Proj[%s]" (projectile-project-name))))

(setq projectile-cache-file "~/.emacs.d/data/projectile.cache")
(setq projectile-known-projects-file "~/.emacs.d/data/projectile-bookmarks.eld")
(setq projectile-switch-project-action (quote helm-projectile))



(provide 'nc-projectile)
