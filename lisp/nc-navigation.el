;;; -*- lexical-binding: t -*-
;;; nc-navigation.el

;; Enhance C-x o when more than two windows are open.
(require-package 'ace-window)


(global-set-key (kbd "C-x o") 'ace-window)
(setq aw-keys '(?q ?s ?d ?f ?g ?h ?j ?k ?l))


(provide 'nc-navigation)
