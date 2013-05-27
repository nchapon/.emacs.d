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


(defun find-user-bindings-file ()
  "Find User Bindings file : bindings.el"
  (interactive)
  (find-user-config-file "bindings.el"))





(provide 'functions)
