;;; Org Mode Configuration
(require 'ox-publish)
(require 'ox-odt)



;;; Start agenda on current day
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)


;; TODO keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)" )))


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold))))

;; Diary
(setq org-agenda-include-diary t)

;; Handling blank lines
(setq org-cycle-separator-lines 0)

(setq org-blank-before-new-entry (quote ((heading)
                                         (plain-list-item . auto))))

;; Line in agenda is selected
(add-hook 'org-agenda-mode-hook 'hl-line-mode)


(setq org-agenda-custom-commands
      '(("P" "Projects"
         ((tags "PROJECT")))

        ("H" "Home and Office lists"
         ((agenda)
          (tags-todo "CNP")
          (tags-todo "HOME")
          (tags-todo "COMPUTER")
          (tags-todo "READING")))

        ("D" "Daily Action List"
         ((agenda "" ((org-agenda-ndays 1)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-deadline-warning-days 0)
                      ))))
        )
      )



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
   (concat nc/org-notes-directory "/" path))

(setq diary-file (nc/expand-org-notes-path "diary"))

;;; Edit my todo page
(defun nc/todo-page ()
  "Edit my todo list page"
  (interactive)
  (find-file-other-window (nc/expand-org-notes-path "GTD/todo.org")))

;; Binding todo file
(global-set-key "\C-cT" 'nc/todo-page)

;; Capture mode
(setq org-capture-templates
      '(("t" "todo" entry (file (nc/expand-org-notes-path "GTD/refile.org"))
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
        ("f" "FishLog" plain (file+datetree+prompt (nc/expand-org-notes-path "private/fishlog.org"))
         "%[~/notes/templates/fishlog.org]"
         )
        ("j" "Journal" entry (file+datetree (nc/expand-org-notes-path "GTD/journal.org"))
         "* %?\nEntered on %U\n  %i\n  %a")))


;; Refile
; Targets include this file and any file contributing to the agenda - up to 3 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 3)
                                 (org-agenda-files :maxlevel . 3))))

(provide 'nc-org)
