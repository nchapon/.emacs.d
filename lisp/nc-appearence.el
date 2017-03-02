;;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))



;; Two appearance themes light or dark
;; By defaut fark theme
;; Light theme can be persisted for future sessions with customize menu (M-x customize)
(defcustom nc/style 'dark
  "Light or dark colour scheme?"
  :group 'nc-emacs
  :type '(choice (const :tag "Light" light)
                 (const :tag "Dark" dark)))

(defun nc-appearance/light ()
  (interactive)
  (load-theme 'leuven t)
  (set-face-attribute 'mode-line nil
                      :foreground "#cccccc"
                      :background "#000000"
                      :weight 'bold)
  (set-face-attribute 'mode-line-buffer-id nil
                      :foreground "white"
                      :weight 'bold))

(require 'magit)
(defun nc-appearance/dark ()
  (interactive)
  (load-theme 'zenburn t)
  (set-face-background 'region "#585953")
  ;; Subtler highlight
  (set-face-background 'magit-section-highlight "#121212")

  (set-face-foreground 'diff-context "#666666")
  (set-face-foreground 'diff-added "#00cc33")
  (set-face-foreground 'diff-removed "#ff0000"))


;; Install the colour scheme according to personal style.
(defun nc-appearance/apply-style ()
  (interactive)
  (cond
   ((equal nc/style 'dark)
    (nc-appearance/dark))
   ((equal nc/style 'light)
    (nc-appearance/light))))

;; Apply theme style
(nc-appearance/apply-style)


(setq visible-bell t
       font-lock-maximum-decoration t
       color-theme-is-global t
       truncate-partial-width-windows nil)

;;; Install source code pro before.
(cond
 ((find-font (font-spec :name "Source Code Pro"))
   (set-frame-font "Source Code Pro-14" nil t)))

;; Smart mode line
(require 'smart-mode-line)

(sml/setup)
(sml/apply-theme 'respectful)

(provide 'nc-appearence)
