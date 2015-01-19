;;; Org Mode Configuration
(require 'ox-publish)
(require 'ox-odt)



;;; Start agenda on current day
(setq org-agenda-start-on-weekday nil)

(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)" )))


;; Diary
(setq org-agenda-include-diary t)

;;; Experimental org-grep
(defun org-grep (regexp)
  "Find in org files "
  (interactive (list (read-regexp "Enter a regexp to grep:")))
  (find-grep
   (format "find ~/notes -name '*.org' -print0 | xargs -0 grep -i -n -- %s" regexp)))



(provide 'nc-org)
