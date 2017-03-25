;;; Working with eshell
(add-hook 'eshell-mode-hook
   (lambda ()
      (add-to-list 'eshell-visual-commands "ssh")
      (add-to-list 'eshell-visual-commands "tail")))

(setq eshell-aliases-file (concat user-emacs-directory ".eshell-aliases"))
(setq eshell-scroll-to-bottom-on-input 'this)
(setq eshell-buffer-shorthand t)





(defun eshell/clear ()
  "Clears the buffer."
  (let ((inhibit-read-only t))
    (erase-buffer)))

(defun eshell/ff (&rest args)
  "Opens a file in emacs."
  (when (not (null args))
    (mapc #'find-file (mapcar #'expand-file-name (eshell-flatten-list (reverse args))))))

(defun eshell/j ()
  "Quickly jump to previous directories."
  (eshell/cd (completing-read
              "Jump to directory: "
              (cl-remove-if-not
               (lambda (dir)
                 (file-exists-p dir))
               (delete-dups (ring-elements eshell-last-dir-ring))))))

(defun eshell/h ()
  "Quickly run a previous command."
  (insert (completing-read
           "Run previous command: "
           (delete-dups (ring-elements eshell-history-ring)))))


(defun my-eshell-color-filter (string)
  (let ((case-fold-search nil)
        (lines (split-string string "\n")))
    (cl-loop for line in lines
             do (progn
                  (cond ((string-match "\\[DEBUG\\]" line)
                         (put-text-property 0 (length line) 'font-lock-face font-lock-comment-face line))
                        ((string-match "\\[INFO\\]" line)
                         (put-text-property 0 (length line) 'font-lock-face compilation-info-face line))
                        ((string-match "\\[WARN\\]" line)
                         (put-text-property 0 (length line) 'font-lock-face compilation-warning-face line))
                        ((string-match "\\[ERROR\\]" line)
                         (put-text-property 0 (length line) 'font-lock-face compilation-error-face line)))))
    (mapconcat 'identity lines "\n")))


;;(add-to-list 'eshell-preoutput-filter-functions #'my-eshell-color-filter)







(provide 'nc-eshell)
