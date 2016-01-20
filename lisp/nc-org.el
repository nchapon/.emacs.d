;;; Org Mode Configuration
(require 'ox-publish)
(require 'ox-odt)

;; Automatically resetting the check boxes to unchecked when marking the repeated task DONE
(require 'org-checklist)

;;; Start agenda on current day
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)

;; Display deadlines 10
(setq org-deadline-warning-days 10)


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "SOMEDAY(s)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")
              (sequence "MEETING(m)" "RDV(r)" "|" "DONE(d)"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("SOMEDAY" :foreground "dark gray" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("MEETING" :foreground "cyan" :weight bold)
              ("RDV" :foreground "cyan" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold))))

;; Triggers that automatically assign tags to tasks based on
;; state changes.
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

(setq org-tags-exclude-from-inheritance '("PROJECT"))

(setq org-priority-faces
      '((65 :foreground "#ff7000" :weight bold)
        (66 :foreground "#ffa060" :weight bold)
        (67 :foreground "#ffcca8" :weight bold)))

;; Diary
(setq org-agenda-include-diary t)

;; Handling blank lines
(setq org-cycle-separator-lines 0)

(setq org-blank-before-new-entry (quote ((heading)
                                         (plain-list-item . auto))))

;; Line in agenda is selected
(add-hook 'org-agenda-mode-hook 'hl-line-mode)


;;; Archiving
(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archived Tasks")

(require 'org-helpers)

(setq org-agenda-span 'day)

(setq org-agenda-time-grid
      '((daily today require-timed)
       "----------------"
       (800 1000 1200 1400 1600 1800)))

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      '((" " "Agenda"
         ((agenda "" ((org-agenda-sorting-strategy '(timestamp-up time-up priority-down category-keep user-defined-up))))
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
        ("Z" "Weekly review" agenda ""
           ((org-agenda-span 7)
            (org-agenda-log-mode 1)))))


;; Some keybindings that should be activated in org-mode
(defun custom-org-agenda-mode-defaults ()
  "Executed as org-agenda-mode-hook."
  (org-defkey org-agenda-mode-map "W" 'oh/agenda-remove-restriction)
  (org-defkey org-agenda-mode-map "N" 'oh/agenda-restrict-to-subtree)
  (org-defkey org-agenda-mode-map "P" 'oh/agenda-restrict-to-project)
  (org-defkey org-agenda-mode-map "q" 'bury-buffer))

(add-hook 'org-agenda-mode-hook 'custom-org-agenda-mode-defaults 'append)


;;; Customize org notes directory
;;; customize this variable if necessary (M-x customize-variable)
(defcustom nc/org-notes-directory "~/notes"
  "Org notes directory. By defaut in user Home directory"
  :group 'nc-emacs
  :type 'string
  :safe 'stringp)

(defun nc/helm-do-grep-notes ()
  "Search in all my org notes."
  (interactive)
  (helm-do-grep-1 (list nc/org-notes-directory) t nil (list "*.org")))

(defun nc/expand-org-notes-path (path)
    "Expand org-notes-directory with PATH"
    (expand-file-name (concat nc/org-notes-directory "/" path)))

(setq diary-file (nc/expand-org-notes-path "diary"))

;; Edit my GTD page
(defun nc/todo-page ()
  "Edit my todo list page"
  (interactive)
  (find-file-other-window (nc/expand-org-notes-path "GTD/todo.org")))

;; Binding todo file
(global-set-key "\C-cT" 'nc/todo-page)


;; Edit my journal file
(defun nc/journal ()
  "Edit my journal"
  (interactive)
  (find-file-other-window (nc/expand-org-notes-path "GTD/journal.org")))

;; Binding journal file
(global-set-key "\C-cj" 'nc/journal)


(defun nc/make-org-scratch ()
  (interactive)
  (find-file (nc/expand-org-notes-path "scratch.org")))


;; Capture mode
(setq org-capture-templates
      '(("t" "todo" entry (file (nc/expand-org-notes-path "GTD/refile.org"))
         "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
        ("r" "respond" entry (file (nc/expand-org-notes-path "GTD/refile.org"))
               "* NEXT Repondre mail %? :MAIL:\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
        ("f" "FishLog" plain (file+datetree+prompt (nc/expand-org-notes-path "private/fishlog.org"))
         "%[~/notes/templates/fishlog.org]"
         )
        ("n" "note" entry (file (nc/expand-org-notes-path "GTD/refile.org"))
         "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
        ("m" "Meeting" entry (file (nc/expand-org-notes-path "GTD/refile.org"))
         "* MEETING %? :MEETING:\n%U" :clock-in t :clock-resume t)
        ("a" "RendezVous" entry (file (nc/expand-org-notes-path "GTD/refile.org"))
               "* RDV %? :APPT:\n%U\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
        ("j" "Journal" entry (file+datetree (nc/expand-org-notes-path "GTD/journal.org"))
         "* %?\nEntered on %U\n  %i\n  %a")))


;; Refile
;; Targets include this file and any file contributing to the agenda - up to 2 levels deep
(setq org-reverse-note-order t)
(setq nc/someday-file (nc/expand-org-notes-path "GTD/someday.org"))
(setq org-refile-targets (quote ((nil :maxlevel . 2)
                                 (org-agenda-files :maxlevel . 2)
                                 (nc/someday-file :maxlevel . 1))))

(setq org-blank-before-new-entry nil)

;;; Org crypt
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)

(provide 'nc-org)
