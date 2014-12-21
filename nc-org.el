;;; Org Mode Configuration
(defvar emacs-with-org8 (string-match "^8" org-version))
(defvar emacs-with-org7 (string-match "^7" org-version))

(cond (emacs-with-org8
       (require 'ox-publish)
       (require 'ox-odt)))

(cond (emacs-with-org7 (require 'org-publish)))

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
