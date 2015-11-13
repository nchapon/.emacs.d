(require 'use-package)
;;; Windows with cygwin config
(let* ((cygwin-root "C:\\PROGRAMJAVA\\tools\\.babun\\cygwin")
         (cygwin-bin (concat cygwin-root "\\bin")))
    (when (and (eq 'windows-nt system-type)
         (file-readable-p cygwin-root))

      (setq exec-path (cons cygwin-bin exec-path))
      (setenv "PATH" (concat cygwin-bin ";" (getenv "PATH")))

      ;; By default use the Windows HOME.
      ;; Otherwise, uncomment below to set a HOME
      ;;      (setenv "HOME" (concat cygwin-root "/home/eric"))

      ;; NT-emacs assumes a Windows shell. Change to bash.
      (setq shell-file-name "zsh")
      (setenv "SHELL" shell-file-name)
      (setq explicit-shell-file-name shell-file-name)

      ;; This removes unsightly ^M characters that would otherwise
      ;; appear in the output of java applications.
      (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)))


;;; Force projectile to use of external indexing in Windows
(setq projectile-indexing-method 'alien)


(defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
  "Use cygwin's /dev/null as the null-device."
  (let ((null-device "/dev/null"))
    ad-do-it))

(ad-activate 'grep-compute-defaults)

;;; Change fonts
(if (eq window-system 'w32)
    (set-default-font "-outline-Consolas-normal-r-normal-normal-14-97-96-96-c-*-iso8859-1"))

(use-package cygwin-mount
             :ensure t
             :config (cygwin-mount-activate))


;;; Agenda configuration
(setq org-agenda-files (list (nc/expand-org-notes-path "GTD/cnp.org")
                             (nc/expand-org-notes-path "GTD/refile.org")
                             (nc/expand-org-notes-path "GTD/todo.org")
                             (nc/expand-org-notes-path "GTD/journal.org")
                             (nc/expand-org-notes-path "GTD/someday.org")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org day page configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org-daypage
  :load-path "C:/PROGRAMJAVA/nchapon/lisp/org-daypage"
  :config
  (setq daypage-path (nc/expand-org-notes-path "GTD/days/")))


;;;;;;;;;;;;;;;;;;;;;;;;;
;; Password management ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package passthword
  :load-path "C:/PROGRAMJAVA/nchapon/lisp/passthword"
  :config
  (setq passthword-password-file "C:/PROGRAMJAVA/nchapon/passthword.gpg"))



;; (use-package ox-reveal
;;   :ensure t
;;   :config
;;   (setq org-reveal-root "C:/PROGRAMJAVA/nchapon/reveal.js-3.1.0/js/reveal.js"))

(require 'ox-reveal)
(setq org-reveal-root ".")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; javax-mode configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'compile)

(use-package javax-mode
  :load-path "C:/PROGRAMJAVA/nchapon/lisp/javax-mode"
  :config
  (setq jx/mvn-repo-path "C:/PROGRAMJAVA/m2_repo")
  (setq jx/ecj-path "C:PROGRAMJAVA/nchapon/opt/bin/ecj-4.4.2.jar"))


;; Set up ENV variables to have the same as bash
(when (file-exists-p "~/.bash_profile")
  (setenv "JAVA_HOME" (shell-command-to-string "source ~/.bash_profile; echo -n $JAVA_HOME"))
  (setenv "PATH" (shell-command-to-string "source ~/.bash_profile; echo -n $PATH")))


(defun java-package ()
  "Returns java package name for the current buffer."
  (interactive)
  (--reduce
   (format "%s.%s" acc it)
   (split-string
    (-last-item (s-split "src/main/java/\\|src/test/java/" default-directory))
    "/" t)))

(defun java-class-name ()
  "Returns java class name for the current buffer."
  (interactive)
  (file-name-sans-extension (buffer-name)))

(setq nxml-child-indent 4)


;;; Fix magit problem
(defun magit-git-insert-quote-curlies (args)
  (mapcar (lambda (arg)
            (if (stringp arg)
                (replace-regexp-in-string "{\\(commit\\|tree\\)}"
                                          "\\\\{\\1\\\\}"
                                          arg)
              arg))
          args))

(advice-add 'magit-git-insert
            :filter-args
            #'magit-git-insert-quote-curlies)
