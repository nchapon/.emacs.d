(projectile-global-mode)

;; Custom modeline indicator
(setq projectile-mode-line '(:eval (format " Proj[%s]" (projectile-project-name))))

(setq projectile-cache-file "~/.emacs.d/data/projectile.cache")
(setq projectile-known-projects-file "~/.emacs.d/data/projectile-bookmarks.eld")
(setq projectile-switch-project-action (quote helm-projectile))


(add-to-list 'projectile-globally-ignored-directories "elpa")
(add-to-list 'projectile-globally-ignored-directories ".cache")
(add-to-list 'projectile-globally-ignored-directories "node_modules")
(add-to-list 'projectile-globally-ignored-directories "image-dired")


(provide 'nc-projectile)
