;;; Org Mode Configuration
(require 'org-publish)

;;; Start agenda on current day
(setq org-agenda-start-on-weekday nil)

(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)" )))


;; Diary
(setq org-agenda-include-diary t)

(provide 'nc-org)
