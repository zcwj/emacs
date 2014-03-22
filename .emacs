;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-11-03 17:45:59 Wednesday by taoshanwen>

;;;;;;;;;;;;;;;;; �������� ;;;;;;;;;;;;;;;

(defconst my-emacs-path "~/" "�ҵ�emacs��������ļ�·��")
(defconst my-emacs-my-lisps-path (concat my-emacs-path "my-lisps/")
"���Լ�д��emacs lisp����·��")
(defconst my-emacs-lisps-path (concat my-emacs-path "lisps/")
"�����ص�emacs lisp����·��")
(defconst my-emacs-templates-path (concat my-emacs-path "templates/")
"path for templates")

;;; ��"my-emacs-lisps-path"��������Ŀ¼���ӵ�`load-path`����
(load (concat my-emacs-my-lisps-path "my-subdirs"))
(my-add-subdirs-to-load-path my-emacs-lisps-path)
(my-add-subdirs-to-load-path my-emacs-my-lisps-path)

;;; org-mode-setting
;;(setq load-path (cons "lisps/org/lisp" load-path))
(require 'org-install)
;; ����չ��Ϊ.org���ļ��򿪺�Ĭ�Ͻ��� org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
