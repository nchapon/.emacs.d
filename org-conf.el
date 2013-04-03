;; Org Mode Configuration

;; Org agenda config
(setq org-agenda-files (list "~/notes/GTD/perso.org"
                             "~/notes/GTD/valtech.org"
                             "~/notes/GTD/toread.org"
                             "~/notes/GTD/tolearn.org"
                             "~/notes/GTD/tosee.org"
                          ))


(setq org-agenda-start-on-weekday nil) ;Start agenda on current day

(setq org-todo-keywords
       '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)" )))

(setq org-todo-keyword-faces
           '(("TODO" . "red")
             ("INPROGRESS" . "orange")
             ("GET_SUBS" . "grey")
             ("TO_SEE" . "orange")
             ("WAITING" . "cyan")
             ("CANCELED" . (:foreground "grey" :weight bold))))


;; Capture mode
;; (setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/notes/GTD/perso.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("v" "Todo Valtech" entry (file+headline "~/notes/GTD/valtech.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("l" "To learn" entry (file+headline "~/notes/GTD/tolearn.org" "To Learn")
         "* TO_LEARN %?\n  %i\n  %a")
        ("r" "To read" entry (file+headline "~/notes/GTD/toread.org" "To Read")
         "* TO_READ %?\n  %i\n  %a")
        ("f" "FishLog" plain (file+datetree+prompt "~/notes/private/fishlog.org")
         "%[~/notes/templates/fishlog.org]"
         )
        ("j" "Journal" entry (file+datetree "~/notes/GTD/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a"))
)
;; Diary
(setq org-agenda-include-diary t)

;; Publish
;; Force publish
;; (setq org-publish-use-timestamps-flag nil)

(require 'org-publish)
(setq org-publish-project-alist
      '(

       ;; ... add all the components here (see below)...

        ("org-notes"
         :base-directory "~/notes/"
         :base-extension "org"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         :style "<link rel=\"stylesheet\" title=\"Standard\" href=\"/home/nchapon/public_html/style/style.css\" type=\"text/css\" />"
         :section-numbers nil
         :table-of-contents nil
         )

         ;; These are static files (images, pdf, etc)
         ("org-static"
                :base-directory "~/notes/" ;; Change this to your local dir
                :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|txt\\|asc\\|svg"
                :publishing-directory "~/public_html/"
                :recursive t
                :publishing-function org-publish-attachment
         )

            ("org" :components ("org-notes" "org-static"))
         )
 )


(provide 'org-conf)
