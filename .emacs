;; -*- emacs-lisp -*-

;; time-stamp: <2010-11-03 17:45:59 wednesday by taoshanwen>

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

;;; ��Ҫ��ʾemacs�Ŀ�ʼ����
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;;; ��fringe����ʾһ��С����ָʾ��ǰbuffer�ı߽�
(setq-default indicate-buffer-bounderies 'left)

;;; ������ʾ��������
(setq echo-keystrokes 0.1)
(setq system-time-locale "c")

;;; ��Ҫ������
(customize-set-variable 'scroll-bar-mode nil)
;;; ��Ҫ������
(customize-set-variable 'tool-bar-mode nil)
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
(autoload 'toggle-emacs-lock "emacs-lock" "emacs lock" t)

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
;;(add-to-list 'load-path "~/lisps/git-emacs/")
;;(require 'git-emacs)





;;; ��info-mode, view-mode, grep-mode, color-theme��vi�еĹ���ƶ���ݼ�hjkl,

;; (require 'cl)
;; (require 'view)
;; (require 'info)
;; (require 'grep)
;; ;; color theme
;; (add-to-list 'load-path "~/lisps/color-theme")
;; (require 'color-theme)
;; (eval-after-load "color-theme"
;;   '(progn
;;      (color-theme-initialize)))

;; (require 'cl)
;; (defun find-loadfile-by-map (map)
;;   "find load file by map."
;;   (case map
;;     ('info-mode-map "info")
;;     ('view-mode-map "view")
;;     ('grep-mode-map "grep")
;;     ('color-theme-mode-map "color-theme")
;;    )
;; )
;; (dolist (map (list info-mode-map view-mode-map grep-mode-map color-theme-mode-map))
;;   (let ((file (find-loadfile-by-map map)))
;;     (eval-after-load file
;;       '(progn
;; 	 (define-key map "h" 'backward-char)
;; 	 (define-key map "l" 'forward-char)
;; 	 (define-key map "j" 'next-line)
;; 	 (define-key map "k" 'previous-line)
;; 	 )
;;       )
;;     )
;;   )


;;; �Զ���ȫ  auto-complete
;;(require 'auto-complete-settings)


;;; ��ݼ�
;;(global-set-key "\C-xl" 'goto-line)
;;(define-key global-map "\c-xl" 'goto-line)
;;(define-key ctl-x-map "l" 'goto-line)
;;(global-set-key (kbd "C-j") 'goto-line)
;;��ĳ���ض�ģʽ����c++-mode���п�ݼ�����
;;(define-key c++-mode-map (kbd "C-j") 'goto-line)

;;(global-set-key "\C-h" 'backward-char)
;;(define-key global-map "\C-h" 'backward-char)
(define-key global-map "\C-h" 'delete-backward-char)
;; bind the goto-line command to the function key F5
(global-set-key [f5] 'goto-line)
;; Control-Alt-F5 can be bound like this:
;;(global-set-key [C-A-f5] 'goto-line)   �޷��󶨵�alt��
;;(global-set-key [C-M-f5] 'goto-line)
;;; ѡ������
;;(define-key global-map [C-return] 'set-mark-command)
;;(define-key global-map (kbd "C-,") 'set-mark-command)
(define-key global-map (kbd "C-x C-x") 'set-mark-command)
(global-set-key "\C-x\C-a" 'mark-whole-buffer);; ȫѡ mark-whole-buffer
;;(global-set-key "\C-xw" 'copy-region-as-kill);; ����
(global-set-key "\C-xx" 'copy-region-as-kill);; ����

;;; Lisp mode
(define-key emacs-lisp-mode-map (kbd "C-;") 'comment-or-uncomment-region)
(define-key emacs-lisp-mode-map (kbd "C-x ;") 'comment-indent)

;;; Ĭ�Ͽ�ݼ�
;; C-M-j  ��ʼ��һ��ע��
;; C-s   ����
;; M-%   ���Ҳ��滻
;; 
;; C-/ ���� C-x u   ���� C-_  ����
;; C-g C-/ ����
;; C-k kill-line
;; C-z ���� C-x C-z suspend-frame
;; C-g abort-recursive-edit
;;(global-set-key "\C-g" 'abort-recursive-edit)
;; Ctrl+x Ctrl+c�˳� Emacs 

;;; ��������
;;(global-set-key "\c-x?" 'help-command)
(define-key ctl-x-map "?" 'help-command)
;; Ĭ������ C-h h view-hello-file
;;(define-key ctl-x-map "h" 'view-help-file)
;;�鿴������ֵ���ĵ�
;;C-h v (describe-variable)
(define-key ctl-x-map "v" 'describe-variable)
;; �鿴�������ĵ�
;; C-h f (describe-function)
(define-key ctl-x-map "f" 'describe-function)
;; �鿴face���ĵ�
;; M-x describe-face
;; �鿴ĳ��mode���ĵ�
;; C-h m (describe-mode)
;; �տ�ʼѧϰĳ��mode��ʱ��, ������C-h m������ǰbuffer��Ӧ����mode�͸�mode���ĵ�, ����ĵ�һ�㶼�����mode�е�����Ϳ�ݼ��б�.
(define-key ctl-x-map "m" 'describe-mode)
;; �鿴ĳ����ݼ���Ӧ������
;; C-h k (describe-key)
;;(global-set-key [C-f5] 'describe-key)
(define-key ctl-x-map "k" 'describe-key)
;; �鿴ĳ�������Ӧ�Ŀ�ݼ�
;; C-h w (where-is)
;;(global-set-key [C-M-f5] 'where-is)
;;(define-key ctl-x-map "w" 'where-is)
;; �鿴��ǰbuffer���еĿ�ݼ��б�
;; C-h b (describe-bindings)
;;(global-set-key [C-f6] 'describe-bindings)
(define-key ctl-x-map "b" 'describe-bindings)
;; �鿴��ǰbuffer����ĳ����ݼ����п�ͷ�Ŀ�ݼ��б�
;; <���鿴�Ŀ�ݼ�����> C-h����������鿴��ǰbuffer��������C-c��ͷ�Ŀ�ݼ��б���C-c C-h�Ϳ����ˡ�
;; �鿴�����Ĵ���
;; find-function
;; �鿴�����Ĵ���
;; find-variable
;; �鿴face�Ĵ���
;; find-face-definition
;; M-x apropos
;; �鿴����ĳ���ؼ��ʵĺ���,����,face

;;; ִ��Elisp����
;; ��ĳ�������水C-x C-e (eval-last-sexp)����ִ���������
;; M-x eval-buffer ����ִ�е�ǰbuffer�ڵ�Elisp����
;; ѡ��һ��region��, M-x eval-region����ִ�����region�ڵĴ���


;; ��ɫ����
(set-background-color "black") ;; ʹ�ú�ɫ����
(set-foreground-color "white") ;; ʹ�ð�ɫǰ��
(set-face-foreground 'region "red")  ;; ����ǰ����ɫ��Ϊ��ɫ
(set-face-background 'region "blue") ;; ���򱳾�ɫ��Ϊ��ɫ

(global-set-key "\C-x\C-a" 'mark-whole-buffer);; ȫѡ mark-whole-buffer
(global-set-key "\C-xx" 'copy-region-as-kill);; ����
(global-set-key "\C-x\C-k" 'kill-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Ĭ�Ͽ�ݼ�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-M-j  ��ʼ��һ��ע��
;; C-s   ����
;; M-%   ���Ҳ��滻
;; 
;; C-/ ���� C-x u   ���� C-_  ����
;; C-g C-/ ����
;; C-k kill-line
;; C-z ���� C-x C-z suspend-frame
;; C-g abort-recursive-edit
;;(global-set-key "\C-g" 'abort-recursive-edit)
;; Ctrl+x Ctrl+c�˳� Emacs 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ��������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(global-set-key "\c-x?" 'help-command)
(define-key ctl-x-map "?" 'help-command)
;; Ĭ������ C-h h view-hello-file
;;(define-key ctl-x-map "h" 'view-help-file)
;;�鿴������ֵ���ĵ�
;;C-h v (describe-variable)
(define-key ctl-x-map "v" 'describe-variable)
;; �鿴�������ĵ�
;; C-h f (describe-function)
(define-key ctl-x-map "f" 'describe-function)
;; �鿴face���ĵ�
;; M-x describe-face
;; �鿴ĳ��mode���ĵ�
;; C-h m (describe-mode)
;; �տ�ʼѧϰĳ��mode��ʱ��, ������C-h m������ǰbuffer��Ӧ����mode�͸�mode���ĵ�, ����ĵ�һ�㶼�����mode�е�����Ϳ�ݼ��б�.
(define-key ctl-x-map "m" 'describe-mode)
;; �鿴ĳ����ݼ���Ӧ������
;; C-h k (describe-key)
;;(global-set-key [C-f5] 'describe-key)
(define-key ctl-x-map "k" 'describe-key)
;; �鿴ĳ�������Ӧ�Ŀ�ݼ�
;; C-h w (where-is)
;;(global-set-key [C-M-f5] 'where-is)
;;(define-key ctl-x-map "w" 'where-is)
;; �鿴��ǰbuffer���еĿ�ݼ��б�
;; C-h b (describe-bindings)
;;(global-set-key [C-f6] 'describe-bindings)
;;(define-key ctl-x-map "b" 'describe-bindings)
;; �鿴��ǰbuffer����ĳ����ݼ����п�ͷ�Ŀ�ݼ��б�
;; <���鿴�Ŀ�ݼ�����> C-h����������鿴��ǰbuffer��������C-c��ͷ�Ŀ�ݼ��б���C-c C-h�Ϳ����ˡ�
;; �鿴�����Ĵ���
;; find-function
;; �鿴�����Ĵ���
;; find-variable
;; �鿴face�Ĵ���
;; find-face-definition
;; M-x apropos
;; �鿴����ĳ���ؼ��ʵĺ���,����,face
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; ִ��Elisp����
;; ��ĳ�������水C-x C-e (eval-last-sexp)����ִ���������
;; M-x eval-buffer ����ִ�е�ǰbuffer�ڵ�Elisp����
;; ѡ��һ��region��, M-x eval-region����ִ�����region�ڵĴ���


;; ��ɫ����
(set-background-color "black") ;; ʹ�ú�ɫ����
(set-foreground-color "white") ;; ʹ�ð�ɫǰ��
(set-face-foreground 'region "red")  ;; ����ǰ����ɫ��Ϊ��ɫ
(set-face-background 'region "blue") ;; ���򱳾�ɫ��Ϊ��ɫ

;;; Chrome plugin : Edit with Emacs					
;; (add-to-list 'load-path "~/.emacs.d")
;; (require 'edit-server)
;; (edit-server-start)


;;; w3m-settings
;; (setq browse-url-browser-function 'w3m-browse-url)
;; (autoload 'w3m-browse-url
;;   "w3m" "Ask a WWW browser to show a URL."
;;   t)
(require 'w3m-settings)
