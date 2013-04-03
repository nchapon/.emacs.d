

(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)


;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name backups-dir))))

(provide 'backup-conf)
