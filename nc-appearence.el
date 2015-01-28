;;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;; By default solorized dark
(load-theme 'zenburn t) ;;; Switch to zenburn because solarized is broken

(setq visible-bell t
       font-lock-maximum-decoration t
       color-theme-is-global t
       truncate-partial-width-windows nil)

(set-face-background 'region "#585953")

;;; Org Mode Faces
(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "red" :weight bold))
    ("INPROGRESS" . (:foreground  "orange" :weight bold))
    ("GET_SUBS" . (:foreground  "grey" :weight bold))
    ("TO_SEE" . (:foreground "orange" :weight bold))
    ("WAITING" . (:foreground  "cyan" :weight bold))
    ("CANCELED" . (:foreground "grey" :weight bold))))

;;; make fringe smaller
(if (fboundp 'fringe-mode)
    (fringe-mode 4))


;; Smart mode line
(require 'smart-mode-line)

(setq sml/theme 'automatic)
;;(setq sml/confirm-load-theme t)
(sml/setup)
;;(sml/apply-theme 'respectful)

(provide 'nc-appearence)
