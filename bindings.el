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

;;set help shortcut by default
(global-set-key (kbd "C-h") 'help-command)

;; Navigation betweeen buffers with ALT+ARROWS
(windmove-default-keybindings 'meta)

;; Prefer backward-kill-word over Backspace
;; https://sites.google.com/site/steveyegge2/effective-emacs
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)


;; Find Recent File
(global-set-key (kbd "C-x C-r")   'ido-recentf-open)

;; Occurences in a file
(global-set-key "\C-co" 'occur)


;; Move line up or down
(global-set-key [(control shift up)]  'move-line-up)
(global-set-key [(control shift down)]  'move-line-down)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Find file in project configuration
(global-set-key (kbd "C-x f") 'find-file-in-project)

;; Find file in project, with specific patterns
(global-unset-key (kbd "C-x C-o")) ;; which used to be delete-blank-lines (also bound to C-c C-<return>)
(global-set-key (kbd "C-x C-o java") (ffip-create-pattern-file-finder "*.java"))
(global-set-key (kbd "C-x C-o js") (ffip-create-pattern-file-finder "*.js" "*.jsp" "*.json"))
;;(global-set-key (kbd "C-x C-o jsp") (ffip-create-pattern-file-finder "*.jsp"))
(global-set-key (kbd "C-x C-o css") (ffip-create-pattern-file-finder "*.css"))
(global-set-key (kbd "C-x C-o clj") (ffip-create-pattern-file-finder "*.clj"))
(global-set-key (kbd "C-x C-o el") (ffip-create-pattern-file-finder "*.el"))
(global-set-key (kbd "C-x C-o md") (ffip-create-pattern-file-finder "*.md"))
(global-set-key (kbd "C-x C-o org") (ffip-create-pattern-file-finder "*.org"))
(global-set-key (kbd "C-x C-o txt") (ffip-create-pattern-file-finder "*.txt"))
(global-set-key (kbd "C-x C-o ftl") (ffip-create-pattern-file-finder "*.ftl"))
(global-set-key (kbd "C-x C-o xml") (ffip-create-pattern-file-finder "*.xml"))

;; ELisp

;;(global-set-key (kbd "C-h e f") 'find-function)
;;(global-set-key (kbd "C-c e s") 'scratch)

;; program shortcuts
(global-set-key (kbd "C-c E") ;; .emacs
  (lambda()(interactive)(find-file "~/.emacs.d/init.el")))





(provide 'bindings)
