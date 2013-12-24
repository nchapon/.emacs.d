(defun az-settings ()
  "AZ Settings"
  (interactive)
  (setq nxml-child-indent 4)
  (setq javax-mvn-build-command "az-mvn -f %spom.xml clean install -Ptheme.skip,jrebel")
  (setq javax-mvn-compile-command "cd %s;az-mvn -o compile"))



;;; Org crypt to use GPG
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)
