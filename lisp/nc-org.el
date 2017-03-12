;;; Org Mode Configuration
(require 'ox-publish)
(require 'ox-odt)

;; Automatically resetting the check boxes to unchecked when marking the repeated task DONE
(require 'org-checklist)

(require 'org-install)






(setq org-priority-faces
      '((65 :foreground "#ff7000" :weight bold)
        (66 :foreground "#ffa060" :weight bold)
        (67 :foreground "#ffcca8" :weight bold)))

;; Agenda files



;; Handling blank lines
(setq org-cycle-separator-lines 0)



;; Line in agenda is selected
(add-hook 'org-agenda-mode-hook 'hl-line-mode)


;;; Archiving
(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archived Tasks")

;;; Clocking and estimating tasks
;; Agenda clock report parameters

(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

(setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00"))))


;;; Org crypt
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)

(provide 'nc-org)
