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

;;; ������Ϣ
(setq user-mail-address "261008760@qq.com")
(setq user-fill-name "���")

;;; ��Ҫ��ʾEmacs�Ŀ�ʼ����
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;;; ��fringe����ʾһ��С����ָʾ��ǰbuffer�ı߽�
(setq-default indicate-buffer-bounderies 'left)

;;; ������ʾ��������
(setq echo-keystrokes 0.1)
(setq system-time-locale "C")

;;; ��Ҫ������
(customize-set-variable 'scroll-bar-mode nil)

;;; ֧��emacs���ⲿ�����ճ��
(setq x-select-enable-clipboard t)

;;; ��ʾ�к�
(setq column-number-mode t)


;;; ��Ҫ����û��û�˵���yes or no,Ϊʲô����y/n
(fset 'yes-or-no-p 'y-or-n-p)

;;; ��Ҫ��˸���
(blink-cursor-mode -1)

;;; ��ֹҳ�����ʱ������scroll-margin 3�����ڿ�����Ļ����3��ʱ�Ϳ�ʼ���������ԺܺõĿ���������
(setq scroll-margin 3
      scroll-conservatively 10000
)

;;; ��꿿�����ָ��ʱ�������ָ���Զ��ÿ�����ס����
(mouse-avoidance-mode 'animate)

;;; �������������ظ���kill
(setq kill-do-not-save-duplicates t)

;;; û����ʾ����Ҳ��Ҫ����
(setq ring-bell-function 'ignire)

;;; ���Եݹ��ʹ��minibuffer
(setq enable-recursive-minibuffers t)

;;; ���Ա����ϴι�����ڵ�λ��
(require 'saveplace)
(setq-default svae-place t)

;;; emacs lock
(autoload 'toggle-emacs-lock "emacs-lock" "Emacs lock" t)

;;; �ȸ�ʽ���ٲ�ȫ
(setq tab-always-indent 'complete)

;;; �������¹���
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;;; ������shell��telnet��w3m��ģʽ��ʱ����Ȼ������Ҫ������������,��ʱ�����Գ��������
(add-hook 'comint-output-filter-functions
	   'comint-watch-for-password-prompt)

;;; ����`eval-after-load'�ӿ������ٶȵĿ�
;; ��eval-after-load���ⲻ��Ҫ��elisp���ļ���
;; http://emacser.com/eval-after-load.htm
(require 'eval-after-load)

;;; org-mode-setting
;;(setq load-path (cons "lisps/org/lisp" load-path))
;;(require 'org-install)
(require 'org-settings)
;; ����չ��Ϊ.org���ļ��򿪺�Ĭ�Ͻ��� org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;;; git-emacs
;;
(add-to-list 'load-path "~/lisps/git-emacs/")
(require 'git-emacs)





;;; ��Info-mode, view-mode, grep-mode, color-theme��vi�еĹ���ƶ���ݼ�hjkl,

(require 'cl)
(require 'view)
(require 'info)
(require 'grep)
;; color theme
(add-to-list 'load-path "~/lisps/color-theme")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)))

(require 'cl)
(defun find-loadfile-by-map (map)
  "Find load file by MAP."
  (case map
    ('Info-mode-map "info")
    ('view-mode-map "view")
    ('grep-mode-map "grep")
    ('color-theme-mode-map "color-theme")
   )
)
(dolist (map (list Info-mode-map view-mode-map grep-mode-map color-theme-mode-map))
  (let ((file (find-loadfile-by-map map)))
    (eval-after-load file
      '(progn
	 (define-key map "h" 'backward-char)
	 (define-key map "l" 'forward-char)
	 (define-key map "j" 'next-line)
	 (define-key map "k" 'previous-line)
	 )
      )
    )
  )
