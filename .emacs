;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-11-03 17:45:59 Wednesday by taoshanwen>

;;;;;;;;;;;;;;;;; �������� ;;;;;;;;;;;;;;;

(defconst my-emacs-path "~/emacs-24.3/" "�ҵ�emacs��������ļ�·��")
(defconst my-emacs-my-lisps-path (concat my-emacs-path "my-lisps/")
"���Լ�д��emacs lisp����·��")
(defconst my-emacs-lisps-path (concat my-emacs-path "lisps/")
"�����ص�emacs lisp����·��")
(defconst my-emacs-templates-path (concat my-emacs-path "templates/")
"path for templates")


;; ��"my-emacs-lisps-path"��������Ŀ¼���ӵ�`load-path`����
(load (concat my-emacs-my-lisps-path "my-subdirs"))
(my-add-subdirs-to-load-path my-emacs-lisps-path)
(my-add-subdirs-toload-path my-emacs-my-lisps-path)
