(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

;;; Edit the user Init File
(defun find-user-init-file ()
  "Edit the user init file in another window"
  (interactive)
  (find-file-other-window user-init-file))

;;; Edit user configuration file
(defun find-user-config-file (f)
  "Edit user emacs configuration file"
    (find-file-other-window (concat user-emacs-directory f)))


(defun find-user-prefs-file ()
  "Find User preferences : preferences.el"
  (interactive)
  (find-user-config-file "preferences.el"))

;;; User Bindings File
(defun find-user-bindings-file ()
  "Find User Bindings file : bindings.el"
  (interactive)
  (find-user-config-file "bindings.el"))

;;; Rotate windows : from emacs live
(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond
   ((not (> (count-windows) 1)) (message "You can't rotate a single window!"))
   (t
    (let ((i 1)
          (num-windows (count-windows)))
      (while  (< i num-windows)
        (let* (
               (w1 (elt (window-list) i))
               (w2 (elt (window-list) (+ (% i num-windows) 1)))
               (b1 (window-buffer w1))
               (b2 (window-buffer w2))
               (s1 (window-start w1))
               (s2 (window-start w2))
               )
          (set-window-buffer w1  b2)
          (set-window-buffer w2 b1)
          (set-window-start w1 s2)
          (set-window-start w2 s1)
          (setq i (1+ i))))))))


(provide 'functions)
