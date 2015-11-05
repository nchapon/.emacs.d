;;; Org Mode Configuration
(require 'ox-publish)
(require 'ox-odt)



;;; Start agenda on current day
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)



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




(provide 'nc-org)
