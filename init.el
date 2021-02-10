(require 'package)
(package-initialize)
;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 800 1000 1000))

(org-babel-load-file (expand-file-name "~/.emacs.d/nchapon.org"))

(put 'upcase-region 'disabled nil)
