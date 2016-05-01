;;; Working with eshell
(add-hook 'eshell-mode-hook
   (lambda ()
      (add-to-list 'eshell-visual-commands "ssh")
      (add-to-list 'eshell-visual-commands "tail")))

(setq eshell-aliases-file (concat user-emacs-directory ".eshell-aliases"))
(setq eshell-scroll-to-bottom-on-input 'this)
(setq eshell-buffer-shorthand t)

(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (name   (car (last (split-string parent "/" t)))))
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))


(global-set-key (kbd "C-!") 'eshell-here)

(setq eshell-prompt-function
      (lambda ()
        (concat (propertize (abbreviate-file-name (eshell/pwd)) 'face 'eshell-prompt)
                (when (fboundp #'vc-git-branches)
                  (let ((branch (car (vc-git-branches))))
                    (when branch
                      (concat
                       (propertize " [" 'face 'font-lock-keyword-face)
                       (propertize branch 'face 'font-lock-function-name-face)
                       (let* ((status (shell-command-to-string "git status --porcelain"))
                              (parts (split-string status "\n" t " "))
                              (states (mapcar #'string-to-char parts))
                              (added (count-if (lambda (char) (= char ?A)) states))
                              (modified (count-if (lambda (char) (= char ?M)) states))
                              (deleted (count-if (lambda (char) (= char ?D)) states)))
                         (when (> (+ added modified deleted) 0)
                           (propertize (format " +%d ~%d -%d" added modified deleted) 'face 'font-lock-comment-face)))
                       (propertize "]" 'face 'font-lock-keyword-face)))))
                (propertize " $ " 'face 'font-lock-constant-face))))



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
