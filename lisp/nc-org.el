;;; Org Mode Configuration
(require 'ox-publish)
(require 'ox-odt)

;; Automatically resetting the check boxes to unchecked when marking the repeated task DONE
(require 'org-checklist)

(require 'org-install)




;; Display deadlines 5
(setq org-deadline-warning-days 5)






(setq org-tags-exclude-from-inheritance '("PROJECT"))

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

(require 'org-helpers)

(setq org-agenda-time-grid
      '((daily today require-timed)
       "----------------"
       (800 1000 1200 1400 1600 1800)))

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      '((" " "Agenda"
         ((agenda "" ((org-agenda-sorting-strategy '(timestamp-up time-up priority-down category-keep user-defined-up))))
          (tags "REFILE"
                      ((org-agenda-overriding-header "Tasks to Refile")
                       (org-tags-match-list-sublevels nil)))
          (tags-todo "-CANCELLED/!-HOLD-WAITING"
                     ((org-agenda-overriding-header "Stuck Projects")
                      (org-agenda-skip-function
                       '(oh/agenda-skip :headline-if '(non-project)
                                        :subtree-if '(non-stuck-project inactive-project scheduled deadline)))
                      (org-tags-match-list-sublevels 'intended)))
          (tags-todo "-@watching-@reading-WAITING-CANCELLED/!NEXT"
                     ((org-agenda-overriding-header "Next Tasks")
                      (org-agenda-skip-function
                       '(oh/agenda-skip :subtree-if '(inactive project scheduled deadline)))
                      (org-tags-match-list-sublevels t)
                      (org-agenda-sorting-strategy '(priority-down todo-state-down effort-up category-keep))))
          (tags-todo "-CANCELLED/!-NEXT-HOLD-WAITING"
                     ((org-agenda-overriding-header "Available Tasks")
                      (org-agenda-skip-function
                       '(oh/agenda-skip :headline-if '(project)
                                        :subtree-if '(inactive scheduled deadline)
                                        :subtree-if-unrestricted-and '(subtask)
                                        :subtree-if-restricted-and '(single-task)))

                      (org-agenda-sorting-strategy '(priority-down category-keep))
                      (org-tags-match-list-sublevels nil)))
          (tags-todo "-CANCELLED/!WAITING|HOLD"
                     ((org-agenda-overriding-header "Waiting and Postponed Tasks")
                      (org-agenda-skip-function
                       '(oh/agenda-skip :subtree-if '(project)))
                      (org-tags-match-list-sublevels nil)))
          (tags-todo "-CANCELLED/!"
                     ((org-agenda-overriding-header "Currently Active Projects")
                      (org-agenda-skip-function
                       '(oh/agenda-skip :subtree-if '(non-project stuck-project inactive-project)
                                        :headline-if-unrestricted-and '(subproject)
                                        :headline-if-restricted-and '(top-project)))
                      (org-tags-match-list-sublevels 'indented)
                      (org-agenda-sorting-strategy '(priority-down category-keep)))))
         nil)
        ("r" "Tasks to Refile" tags "REFILE"
         ((org-agenda-overriding-header "Tasks to Refile")
          (org-tags-match-list-sublevels nil)))
        ("W" "To See" tags "@watching"
         ((org-agenda-overriding-header "To See")
          (org-tags-match-list-sublevels 'indented)))
        ("R" "To Read" tags "@reading"
         ((org-agenda-overriding-header "To Read")
          (org-tags-match-list-sublevels 'indented)))
        ("#" "Stuck Projects" tags-todo "-CANCELLED/!-HOLD-WAITING"
         ((org-agenda-overriding-header "Stuck Projects")
          (org-agenda-skip-function
           '(oh/agenda-skip :subtree-if '(inactive non-project non-stuck-project
                                          scheduled deadline)))))
        ("n" "Next Tasks" tags-todo "-WAITING-CANCELLED/!NEXT"
         ((org-agenda-overriding-header "Next Tasks")
          (org-agenda-skip-function
           '(oh/agenda-skip :subtree-if '(inactive project scheduled deadline)))
          (org-tags-match-list-sublevels t)
          (org-agenda-sorting-strategy '(priority-down todo-state-down effort-up category-keep))))
        ("+" "Tasks" tags-todo "-CANCELLED/!-NEXT-HOLD-WAITING"
         ((org-agenda-overriding-header "Available Tasks")
          (org-agenda-skip-function
           '(oh/agenda-skip :headline-if '(project)
                            :subtree-if '(inactive scheduled deadline)
                            :subtree-if-unrestricted-and '(subtask)
                            :subtree-if-restricted-and '(single-task)))
          (org-agenda-sorting-strategy '(priority-down category-keep))))
        ("p" "Projects" tags-todo "-@watching-@reading-CANCELLED/!"
         ((org-agenda-overriding-header "Currently Active Projects")
          (org-agenda-skip-function
           '(oh/agenda-skip :subtree-if '(non-project inactive)))
          (org-agenda-sorting-strategy '(priority-down category-keep))
          (org-tags-match-list-sublevels 'indented)))
        ("w" "Waiting Tasks" tags-todo "-CANCELLED/!WAITING|HOLD"
         ((org-agenda-overriding-header "Waiting and Postponed Tasks")
          (org-agenda-skip-function '(oh/agenda-skip :subtree-if '(project)))))
        ("S" tags-todo "TODO=\"STARTED\"")
        ("Z" "Weekly review" agenda ""

         ((org-agenda-span 7)
            (org-agenda-log-mode 1)))))

;;; Org crypt
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)

(provide 'nc-org)
