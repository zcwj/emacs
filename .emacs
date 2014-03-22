;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-11-03 17:45:59 Wednesday by taoshanwen>

;;;;;;;;;;;;;;;;; 基本设置 ;;;;;;;;;;;;;;;

(defconst my-emacs-path "~/emacs-24.3/" "我的emacs相关配置文件路径")
(defconst my-emacs-my-lisps-path (concat my-emacs-path "my-lisps/")
"我自己写的emacs lisp包的路径")
(defconst my-emacs-lisps-path (concat my-emacs-path "lisps/")
"我下载的emacs lisp包的路径")
(defconst my-emacs-templates-path (concat my-emacs-path "templates/")
"path for templates")


;; 把"my-emacs-lisps-path"的所有子目录都加到`load-path`里面
(load (concat my-emacs-my-lisps-path "my-subdirs"))
(my-add-subdirs-to-load-path my-emacs-lisps-path)
(my-add-subdirs-toload-path my-emacs-my-lisps-path)
