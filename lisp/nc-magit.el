;;; magit

(require 'magit)

;; To eliminate warning
(setq magit-last-seen-setup-instructions "1.4.0")

(global-set-key (kbd "C-x g") 'magit-status)

(setq magit-file-mode t)

(add-hook 'magit-log-edit-mode-hook
          (lambda ()
             (set-fill-column 72)
             (auto-fill-mode 1)))
(provide 'nc-magit)
