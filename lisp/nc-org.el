;;; Org Mode Configuration
(require 'ox-publish)
(require 'ox-odt)



;;; Start agenda on current day
(setq org-agenda-start-on-weekday nil)

(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)" )))


;; Diary
(setq org-agenda-include-diary t)

;; Line in agenda is selected
(add-hook 'org-agenda-mode-hook 'hl-line-mode)

(provide 'nc-org)
