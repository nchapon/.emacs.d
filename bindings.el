;; Bindings here.

;; Increase or decrease text scale:
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Global key bindings
;;(global-set-key (kbd "RET")         'newline-and-indent)
(global-set-key (kbd "C-<f4>")      'kill-buffer-and-window)
(global-set-key (kbd "<delete>")    'delete-char)  ; delete == delete
(global-set-key (kbd "M-g")         'goto-line)

(when (fboundp 'ibuffer)
  (global-set-key (kbd "C-x C-b") 'ibuffer))   ;; prefer ibuffer

;; Orgmode keys
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; Set help shortcut by default
(global-set-key (kbd "C-h") 'help-command)

;; Navigation betweeen buffers with ALT+ARROWS
(windmove-default-keybindings 'meta)

;; Prefer backward-kill-word over Backspace
;; https://sites.google.com/site/steveyegge2/effective-emacs
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(global-set-key (kbd "M-y") 'browse-kill-ring)


;; Find Recent File
(global-set-key (kbd "C-x C-r")   'ido-recentf-open)

;; Occurences in a file
(global-set-key "\C-co" 'occur)


;; loccur key bindings
;; defines shortcut for loccur of the current word
(require 'loccur)
(define-key global-map [(control o)] 'loccur-current)
;; defines shortcut for the interactive loccur command
(define-key global-map [(control meta o)] 'loccur)
;; defines shortcut for the loccur of the previously found word
(define-key global-map [(control shift o)] 'loccur-previous-match)



;;; Rotate Window
(global-set-key (kbd "C-c w r") 'rotate-windows)

;; Move line up or down
(global-set-key [(control shift up)]  'move-line-up)
(global-set-key [(control shift down)]  'move-line-down)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Find file in project configuration
(global-set-key (kbd "C-x f") 'find-file-in-project)

;; Find file in project, with specific patterns
(global-unset-key (kbd "C-x C-o")) ;; which used to be delete-blank-lines (also bound to C-c C-<return>)
(global-set-key (kbd "C-x C-o java") (ffip-create-pattern-file-finder "*.java"))
(global-set-key (kbd "C-x C-o js") (ffip-create-pattern-file-finder "*.js" "*.jsp" "*.json"))
(global-set-key (kbd "C-x C-o css") (ffip-create-pattern-file-finder "*.css"))
(global-set-key (kbd "C-x C-o clj") (ffip-create-pattern-file-finder "*.clj"))
(global-set-key (kbd "C-x C-o el") (ffip-create-pattern-file-finder "*.el"))
(global-set-key (kbd "C-x C-o md") (ffip-create-pattern-file-finder "*.md"))
(global-set-key (kbd "C-x C-o org") (ffip-create-pattern-file-finder "*.org"))
(global-set-key (kbd "C-x C-o txt") (ffip-create-pattern-file-finder "*.txt"))
(global-set-key (kbd "C-x C-o ftl") (ffip-create-pattern-file-finder "*.ftl"))
(global-set-key (kbd "C-x C-o xml") (ffip-create-pattern-file-finder "*.xml"))
(global-set-key (kbd "C-x C-o vm") (ffip-create-pattern-file-finder "*.vm"))
(global-set-key (kbd "C-x C-o pom") (ffip-create-pattern-file-finder "pom.xml"))


;;; Ace Jump Mode key binding
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;;; Expand Region
(global-set-key (kbd "C-=") 'er/expand-region)

;; Binding for custom functions
;; Duplicate current line

;;; Emacs Configuration File Shortcuts
(global-set-key (kbd "C-c I") 'find-user-init-file)
(global-set-key (kbd "C-c P") 'find-user-prefs-file)
(global-set-key (kbd "C-c B") 'find-user-bindings-file )

(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)



(provide 'bindings)
