;;; magit

(require 'magit)

;; To eliminate warning
(setq magit-last-seen-setup-instructions "1.4.0")

(global-set-key (kbd "C-x g") 'magit-status)


;; Subtler highlight
;;(set-face-background 'magit-item-highlight "#121212")
;;(set-face-foreground 'diff-context "#666666")
;;(set-face-foreground 'diff-added "#00cc33")
;;(set-face-foreground 'diff-removed "#ff0000")



(add-hook 'magit-log-edit-mode-hook
          (lambda ()
             (set-fill-column 72)
             (auto-fill-mode 1)))




(provide 'nc-magit)
