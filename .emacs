;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-11-03 17:45:59 Wednesday by taoshanwen>

;;;;;;;;;;;;;;;;; 基本设置 ;;;;;;;;;;;;;;;

(defconst my-emacs-path "~/" "我的emacs相关配置文件路径")
(defconst my-emacs-my-lisps-path (concat my-emacs-path "my-lisps/")
"我自己写的emacs lisp包的路径")
(defconst my-emacs-lisps-path (concat my-emacs-path "lisps/")
"我下载的emacs lisp包的路径")
(defconst my-emacs-templates-path (concat my-emacs-path "templates/")
"path for templates")

;;; 把"my-emacs-lisps-path"的所有子目录都加到`load-path`里面
(load (concat my-emacs-my-lisps-path "my-subdirs"))
(my-add-subdirs-to-load-path my-emacs-lisps-path)
(my-add-subdirs-to-load-path my-emacs-my-lisps-path)

;;; org-mode-setting
;;(setq load-path (cons "lisps/org/lisp" load-path))
(require 'org-install)
;; 让扩展名为.org的文件打开后默认进入 org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
