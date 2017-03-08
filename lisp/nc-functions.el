;;; Edit the user Init File
(defun my-init-file ()
  "Edit the user init file in another window"
  (interactive)
  (find-file-other-window user-init-file))

;;; Edit user configuration file
(defun my-config-file (f)
  "Edit user emacs configuration file"
    (find-file-other-window (concat user-emacs-directory "lisp/" f)))


(defun my-prefs-file ()
  "Find User preferences : nc-preferences.el"
  (interactive)
  (my-config-file "nc-preferences.el"))

;;; User Bindings File
(defun my-bindings-file ()
  "Find User Bindings file : nc-bindings.el"
  (interactive)
  (my-config-file "nc-bindings.el"))

;;; Rotate windows : from emacs live



;; TODO: Remove code duplication by extracting something more generic
(defun nc/duplicate-and-comment-current-line-or-region (arg)
  "Duplicates and comments the current line or region ARG times.
If there's no region, the current line will be duplicated.  However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (comment-or-uncomment-region beg end)
      (setq end (line-end-position))
      (-dotimes arg
                (lambda (n)
                  (goto-char end)
                  (newline)
                  (insert region)
                  (setq end (point))))
      (goto-char (+ origin (* (length region) arg) arg)))))





(defun nc/view-url ()
  "Open a new buffer containing the contents of URL."
  (interactive)
  (let* ((default (thing-at-point-url-at-point))
         (url (read-from-minibuffer "URL: " default)))
    (switch-to-buffer (url-retrieve-synchronously url))
    (rename-buffer url t)
    (cond ((search-forward "<?xml" nil t) (nxml-mode))
          ((search-forward "<html" nil t) (html-mode)))))

(defun nc/clean-up-buffer-or-region ()
  "Untabifies, indents and deletes trailing whitespace from buffer or region."
  (interactive)
  (save-excursion
    (unless (region-active-p)
      (mark-whole-buffer))
    (untabify (region-beginning) (region-end))
    (indent-region (region-beginning) (region-end))
    (save-restriction
      (narrow-to-region (region-beginning) (region-end))
      (delete-trailing-whitespace))))

;;; From prelude https://github.com/bbatsov/prelude/blob/master/core/prelude-core.el
(defun nc/switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))


(defmacro nc/after-load (feature &rest body)
  "After FEATURE is loaded, evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,feature
     '(progn ,@body)))


(defun nc/markdown-code-block (beg end)
  "Wrap the current region into a code block."
  (interactive "r")
  (save-excursion
    (goto-char end)
    (when (not (bolp))
      (insert "\n"))
    (insert "```\n")
    (goto-char beg)
    (forward-line 0)
    (insert "```\n")))




;; From emacs wiki
(defun nc/insert-todays-date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%Y-%m-%d")
            (format-time-string "%d/%m/%Y"))))


(provide 'nc-functions)
