;;; Org Mode Configuration
(require 'ox-publish)
(require 'ox-odt)

;; Automatically resetting the check boxes to unchecked when marking the repeated task DONE
(require 'org-checklist)

(require 'org-install)
(require 'org-habit)
(add-to-list 'org-modules "org-habit")
(setq org-habit-preceding-days 7
      org-habit-following-days 1
      org-habit-graph-column 80
      org-habit-show-habits-only-for-today t
      org-habit-show-all-today t)


;;; Start agenda on current day
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)

;; Display deadlines 10
(setq org-deadline-warning-days 10)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "SOMEDAY(s)" "|" "DONE(d!)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")
              (sequence "MEETING(m)" "RDV(r)" "FORMATION(f)" "|" "DONE(d)"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("SOMEDAY" :foreground "dark gray" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("MEETING" :foreground "cyan" :weight bold)
              ("RDV" :foreground "cyan" :weight bold)
              ("FORMATION" :foreground "khaki" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold))))


(setq org-log-into-drawer "LOGBOOK")
(setq org-clock-into-drawer 1)

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

;;; Clocking and estimating tasks
;; Agenda clock report parameters

(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

(setq org-global-properties (quote (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00"))))

(require 'org-helpers)

;; Agenda on two days
(setq org-agenda-span 2)

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

;; Edit work GTD page
(defun nc/gtd-office-page ()
  "Edit my todo list page"
  (interactive)
  (find-file-other-window (nc/expand-org-notes-path "cnp/GTD/gtd.org")))

;; Binding todo file
(global-set-key "\C-cW" 'nc/gtd-office-page)

(defun nc/make-org-scratch ()
  (interactive)
  (find-file (nc/expand-org-notes-path "scratch.org")))


;; Capture mode
(setq org-capture-templates
      '(("t" "todo" entry (file (nc/expand-org-notes-path "GTD/refile.org"))
         "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
        ("f" "FishLog" plain (file+datetree+prompt (nc/expand-org-notes-path "GTD/fishlog.org"))
         "%[~/notes/templates/fishlog.org]")
        ("n" "Note" entry (file (nc/expand-org-notes-path "GTD/refile.org"))
         "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
        ("m" "Meeting" entry (file (nc/expand-org-notes-path "GTD/refile.org"))
         "* MEETING %? :MEETING:\n%U\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
        ("a" "RendezVous" entry (file (nc/expand-org-notes-path "GTD/refile.org"))
               "* RDV %? :APPT:\n%U\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")
        ("j" "Journal" entry (file+datetree (nc/expand-org-notes-path "GTD/journal.org"))
         "* %?\nEntered on %U\n  %i\n  %a")
        ("w" "WeeklyReview" entry (file+datetree+prompt (nc/expand-org-notes-path "GTD/journal.org"))
         "* Summary of the week :REVIEW:\n%[~/notes/templates/review.org]")
        ))

(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))

(setq org-clock-into-drawer t)

;;; Org time report day by day
(defun org-dblock-write:rangereport (params)
  "Display day-by-day time reports."
  (let* ((ts (plist-get params :tstart))
         (te (plist-get params :tend))
         (start (time-to-seconds
                 (apply 'encode-time (org-parse-time-string ts))))
         (end (time-to-seconds
               (apply 'encode-time (org-parse-time-string te))))
         day-numbers)
    (setq params (plist-put params :tstart nil))
    (setq params (plist-put params :end nil))
    (while (< start end)
      (save-excursion
        (insert "\n\n***"
                (format-time-string (car org-time-stamp-formats)
                                    (seconds-to-time start))
                "----------------\n")
        (org-dblock-write:clocktable
         (plist-put
          (plist-put
           params
           :tstart
           (format-time-string (car org-time-stamp-formats)
                               (seconds-to-time start)))
          :tend
          (format-time-string (car org-time-stamp-formats)
                              (seconds-to-time end))))
        (setq start (+ 86400 start))))))



;; Refile
;; Targets include this file and any file contributing to the agenda - up to 2 levels deep
(setq org-reverse-note-order t)

(setq org-refile-targets (quote ((nil :maxlevel . 2)
                                 (org-agenda-files :maxlevel . 2))))

(setq org-blank-before-new-entry nil)

;;; Org crypt
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)

(provide 'nc-org)
