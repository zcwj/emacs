;; -*- emacs-lisp -*-

;; time-stamp: <2010-11-03 17:45:59 wednesday by taoshanwen>

;;;;;;;;;;;;;;;;; 基本设置 ;;;;;;;;;;;;;;;

(defconst my-emacs-path "~/emacs/" "我的emacs相关配置文件路径")
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

(require 'ahei-misc)
;;; 个人信息
(setq user-mail-address "ldw5258@gmail.com")
(setq user-fill-name "左次")

;;; 不要显示emacs的开始画面
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;;; 在fringe上显示一个小乘着指示当前buffer的边界
(setq-default indicate-buffer-bounderies 'left)

;;; 尽快显示按键序列
(setq echo-keystrokes 0.1)
(setq system-time-locale "c")

;;; 不要流动条
(customize-set-variable 'scroll-bar-mode nil)
;;; 不要工具栏
(customize-set-variable 'tool-bar-mode nil)
;;; 支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t)

;;; 显示列号
(setq column-number-mode t)


;;; 不要总是没完没了地问yes or no,为什么不用y/n
(fset 'yes-or-no-p 'y-or-n-p)

;;; 不要闪烁光标
(blink-cursor-mode -1)

;;; 防止页面滚动时跳动，scroll-margin 3可以在靠近屏幕边沿3行时就开始滚动，可以很好的看到上下文
(setq scroll-margin 3
      scroll-conservatively 10000)

;;; 光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线
(mouse-avoidance-mode 'animate)

;;; 不保持连续的重复的kill
(setq kill-do-not-save-duplicates t)

;;; 没有提示音，也不要闪屏
(setq ring-bell-function 'ignire)

;;; 可以递归的使用minibuffer
(setq enable-recursive-minibuffers t)

;;; 可以保存上次光标所在的位置
(require 'saveplace)
(setq-default svae-place t)

;;; emacs lock
(autoload 'toggle-emacs-lock "emacs-lock" "emacs lock" t)

;;; 先格式化再补全
(setq tab-always-indent 'complete)

;;; 启用以下功能
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;;; 当你在shell、telnet、w3m等模式下时，必然碰到过要输入密码的情况,此时加密显出你的密码
(add-hook 'comint-output-filter-functions
	  'comint-watch-for-password-prompt)
(server-start)
;;; 利用`eval-after-load'加快启动速度的库
;; 用eval-after-load避免不必要的elisp包的加载
;; http://emacser.com/eval-after-load.htm
(require 'eval-after-load)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; org-mode-setting
;;(setq load-path (cons "lisps/org/lisp" load-path))
;;(require 'org-install)
;;(require 'org-settings)
;; 让扩展名为.org的文件打开后默认进入 org mode
;;(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(require 'org-settings)
(setq org-publish-project-alist
     '(("org"
        :base-directory "~/emacs/org/"
        :publishing-directory "~/public_html"
        :section-numbers nil
        :table-of-contents nil
        :style "<link rel=\"stylesheet\"
               href=\"../other/mystyle.css\"
               type=\"text/css\"/>")))
;; (setq org-todo-keywords
;;        '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))
;; (setq org-todo-keywords
;;            '((sequence "TODO(t)" "|" "DONE(d)")
;;              (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
;;              (sequence "|" "CANCELED(c)")))
(setq org-todo-keywords
      '((sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
	(sequence "TODO(T!)" "|" "DONE(D@)3" "CANCELED(C@/!)")
	(sequence "TODO(t!)" "NEXT(n)" "WAITTING(w)" "SOMEDAY(s)" "|" "DONE(d@/!)" "ABORT(a@/!)")
	))
(setq org-agenda-files (list "~/org/gtd.org.gpg"
                             "~/org/journal.org.gpg"
                             "~/org/tech.org"
                             "~/org/"
			     ))
'(org-refile-targets (quote (("newgtd.org" :maxlevel . 1)                                                                                             
			     ("someday.org" :level . 2))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; org2blog
;; (require 'org2blog-autoloads)
;; (setq org2blog/wp-blog-alist
;;       `(("zcwj"
;;          :url "http://upload.move.blog.sina.com.cn/blog_rebuild/blog/xmlrpc.php"
;;          :username "ldw5258@163.com"
;;          :password "l1625d8521w"
;;          :keep-new-lines t
;;          :confirm t
;;          :wp-code nil
;;          :tags-as-categories nil)
;;         ))
;;; easypg
(require 'epa-file)
(epa-file-enable)
(setenv "GPG_AGENT_INFO" nil)
(setq epa-file-cache-passphrase-for-symmetric-encryption t)
(setq epa-file-inhibit-auto-save nil)
;; (setq org2blog/wp-buffer-template
;;       "#+DATE: %s
;; #+OPTIONS: toc:nil num:nil todo:nil pri:nil tags:nil ^:nil TeX:nil
;; #+CATEGORY: Heart
;; #+TAGS:
;; #+PERMALINK:
;; #+TITLE:
;; \n")

;;; git-emacs
;;
;;(add-to-list 'load-path "~/lisps/git-emacs/")
;;(require 'git-emacs)





;;; 对info-mode, view-mode, grep-mode, color-theme绑定vi中的光标移动快捷键hjkl,

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


;;; 自动补全  auto-complete
;;(require 'auto-complete-settings)


;;; 快捷键
;;(global-set-key "\C-xl" 'goto-line)
;;(define-key global-map "\c-xl" 'goto-line)
;;(define-key ctl-x-map "l" 'goto-line)
;;(global-set-key (kbd "C-j") 'goto-line)
;;对某个特定模式比如c++-mode进行快捷键定制
;;(define-key c++-mode-map (kbd "C-j") 'goto-line)

;;(global-set-key "\C-h" 'backward-char)
;;(define-key global-map "\C-h" 'backward-char)
(define-key global-map "\C-h" 'delete-backward-char)
;; bind the goto-line command to the function key F5
(global-set-key [f5] 'goto-line)
;; Control-Alt-F5 can be bound like this:
;;(global-set-key [C-A-f5] 'goto-line)   无法绑定到alt键
;;(global-set-key [C-M-f5] 'goto-line)
;;; 选择命令
;;(define-key global-map [C-return] 'set-mark-command)
;;(define-key global-map (kbd "C-,") 'set-mark-command)
(define-key global-map (kbd "C-x C-h") 'set-mark-command)
(global-set-key "\C-x\C-a" 'mark-whole-buffer);; 全选 mark-whole-buffer
;;(global-set-key "\C-xw" 'copy-region-as-kill);; 复制
(global-set-key "\C-xx" 'copy-region-as-kill);; 复制

;;; Lisp mode
(define-key emacs-lisp-mode-map (kbd "C-;") 'comment-or-uncomment-region)
(define-key emacs-lisp-mode-map (kbd "C-x ;") 'comment-indent)

;;; 默认快捷键
;; C-M-j  开始新一行注释
;; C-s   查找
;; M-%   查找并替换
;; 
;; C-/ 或者 C-x u   或者 C-_  撤销
;; C-g C-/ 重做
;; C-k kill-line
;; C-z 或者 C-x C-z suspend-frame
;; C-g abort-recursive-edit
;;(global-set-key "\C-g" 'abort-recursive-edit)
;; Ctrl+x Ctrl+c退出 Emacs 

;;; 帮助命令
;;(global-set-key "\c-x?" 'help-command)
;;(define-key ctl-x-map "?" 'help-command)
;; 默认命令 C-h h view-hello-file
;;(define-key ctl-x-map "h" 'view-help-file)
;;查看变量的值和文档
;;C-h v (describe-variable)
;;(define-key ctl-x-map "v" 'describe-variable)
;; 查看函数的文档
;; C-h f (describe-function)
;;(define-key ctl-x-map "f" 'describe-function)
;; 查看face的文档
;; M-x describe-face
;; 查看某个mode的文档
;; C-h m (describe-mode)
;; 刚开始学习某个mode的时候, 可以用C-h m看看当前buffer对应的主mode和副mode的文档, 这个文档一般都会包括mode中的命令和快捷键列表.
;;(define-key ctl-x-map "m" 'describe-mode)
;; 查看某个快捷键对应的命令
;; C-h k (describe-key)
;;(global-set-key [C-f5] 'describe-key)
;;(define-key ctl-x-map "k" 'describe-key)
;; 查看某个命令对应的快捷键
;; C-h w (where-is)
;;(global-set-key [C-M-f5] 'where-is)
;;(define-key ctl-x-map "w" 'where-is)
;; 查看当前buffer所有的快捷键列表
;; C-h b (describe-bindings)
;;(global-set-key [C-f6] 'describe-bindings)
;;(define-key ctl-x-map "b" 'describe-bindings)
;; 查看当前buffer中以某个快捷键序列开头的快捷键列表
;; <待查看的快捷键序列> C-h，比如你想查看当前buffer中所有以C-c开头的快捷键列表，按C-c C-h就可以了。
;; 查看函数的代码
;; find-function
;; 查看变量的代码
;; find-variable
;; 查看face的代码
;; find-face-definition
;; M-x apropos
;; 查看包含某个关键词的函数,变量,face

;;; 执行Elisp代码
;; 在某条语句后面按C-x C-e (eval-last-sexp)可以执行那条语句
;; M-x eval-buffer 可以执行当前buffer内的Elisp代码
;; 选中一个region后, M-x eval-region可以执行这个region内的代码


;; 颜色定制
(set-background-color "black") ;; 使用黑色背景
(set-foreground-color "white") ;; 使用白色前景
(set-face-foreground 'region "red")  ;; 区域前景颜色设为红色
(set-face-background 'region "blue") ;; 区域背景色设为蓝色

(global-set-key "\C-x\C-a" 'mark-whole-buffer);; 全选 mark-whole-buffer
(global-set-key "\C-xx" 'copy-region-as-kill);; 复制
(global-set-key "\C-x\C-k" 'kill-buffer)

;; 自定义快捷键
(defun my-list-buffer()
  (interactive)
  (list-buffers)
;;  (other-window 1)
  (switch-to-buffer-other-window "*Buffer List*")
;;  (delete-other-windows)
)
(global-set-key (kbd "C-x C-b") 'my-list-buffer)
(global-set-key [f11] 'my-fullscreen) ;; 启动全屏的快捷键
;全屏
(defun my-fullscreen ()
(interactive)
(x-send-client-message
nil 0 nil "_NET_WM_STATE" 32
'(2 "_NET_WM_STATE_FULLSCREEN" 0))
)
;最大化
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  )
(my-maximized) ;; 启动emacs时窗口最大化
(global-set-key [f11] 'my-maximized) ;; 启动全屏的快捷键

;; count-word  统计字符
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 默认快捷键
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-M-j  开始新一行注释
;; C-s   查找
;; M-%   查找并替换
;; 
;; C-/ 或者 C-x u   或者 C-_  撤销
;; C-g C-/ 重做
;; C-k kill-line
;; C-z 或者 C-x C-z suspend-frame
;; C-g abort-recursive-edit
;;(global-set-key "\C-g" 'abort-recursive-edit)
;; Ctrl+x Ctrl+c退出 Emacs 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 帮助命令
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(global-set-key "\c-x?" 'help-command)
(define-key ctl-x-map "?" 'help-command)
;; 默认命令 C-h h view-hello-file
;;(define-key ctl-x-map "h" 'view-help-file)
;;查看变量的值和文档
;;C-h v (describe-variable)
;;(define-key ctl-x-map "v" 'describe-variable)
;; 查看函数的文档
;; C-h f (describe-function)
;;(define-key ctl-x-map "f" 'describe-function)
;; 查看face的文档
;; M-x describe-face
;; 查看某个mode的文档
;; C-h m (describe-mode)
;; 刚开始学习某个mode的时候, 可以用C-h m看看当前buffer对应的主mode和副mode的文档, 这个文档一般都会包括mode中的命令和快捷键列表.
;;(define-key ctl-x-map "m" 'describe-mode)
;; 查看某个快捷键对应的命令
;; C-h k (describe-key)
;;(global-set-key [C-f5] 'describe-key)
;;(define-key ctl-x-map "k" 'describe-key)
;; 查看某个命令对应的快捷键
;; C-h w (where-is)
;;(global-set-key [C-M-f5] 'where-is)
;;(define-key ctl-x-map "w" 'where-is)
;; 查看当前buffer所有的快捷键列表
;; C-h b (describe-bindings)
;;(global-set-key [C-f6] 'describe-bindings)
;;(define-key ctl-x-map "b" 'describe-bindings)
;; 查看当前buffer中以某个快捷键序列开头的快捷键列表
;; <待查看的快捷键序列> C-h，比如你想查看当前buffer中所有以C-c开头的快捷键列表，按C-c C-h就可以了。
;; 查看函数的代码
;; find-function
;; 查看变量的代码
;; find-variable
;; 查看face的代码
;; find-face-definition
;; M-x apropos
;; 查看包含某个关键词的函数,变量,face
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; 执行Elisp代码
;; 在某条语句后面按C-x C-e (eval-last-sexp)可以执行那条语句
;; M-x eval-buffer 可以执行当前buffer内的Elisp代码
;; 选中一个region后, M-x eval-region可以执行这个region内的代码


;; 颜色定制
;; (set-background-color "black") ;; 使用黑色背景
;; (set-foreground-color "white") ;; 使用白色前景
;; (set-face-foreground 'region "red")  ;; 区域前景颜色设为红色
;; (set-face-background 'region "blue") ;; 区域背景色设为蓝色
;; color theme Emacs主题
(require 'color-theme-settings)

(require 'ahei-face)
(require 'color-theme-ahei)
(require 'face-settings)

;;; Chrome plugin : Edit with Emacs					
;; (add-to-list 'load-path "~/.emacs.d")
;; (require 'edit-server)
;; (edit-server-start)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 自动补全
(require 'all-auto-complete-settings)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; w3m-settings
;; (setq browse-url-browser-function 'w3m-browse-url)
;; (autoload 'w3m-browse-url
;;   "w3m" "Ask a WWW browser to show a URL."
;;   t)
(require 'w3m-settings)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'cedet-settings)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Dired settings
(require 'dired)
(require 'dired-tar)
;(GNULinux ; gnome-open
(defvar *open-with-wine* '("wine" "start" "/Unix"))
(setq *dired-extention-open-list*
      `(("pdf$" "evince"); org acroread
	("htm$" "google-chrome")
	("html$" "google-chrome")
	("doc$" "wps")
	("docx$" "wps")
	("exe$" ,@*open-with-wine*)
	("ps$" "gv"))); gsview
(require 'dired-extension)
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map [C-return] 'my-dired-open-file)
     (define-key dired-mode-map [menu-bar immediate dired-run-associated-program]
       '("Open Associated Application" . dired-gnome-open-file))))

;;;###autoload
(defun my-dired-open-file ()  "Dired find file function. Open file use another tool"
  (interactive)
  (dolist (file (dired-get-marked-files))
    (my-dired-open-file-internal file)))

(defvar *use-doc-view* nil)
(defvar *dired-extention-open-list* nil)
;;;###autoload
(defun my-dired-open-file-internal (file)  "Open diversified format FILE."
  (interactive "fFile: ")
  (require 'emms)
  (let ((file-extension (file-name-extension file)))
    (if file-extension
        (cond ((string-match "\\(s?html?\\)$" file-extension)
               (require 'w3m)
               (w3m-copy-buffer)
               (message "%s" file)
               (w3m-find-file file))
              ((string-match "\\(chm\\)$" file-extension)
               (shell-command
                  (concat "chmsee " file " &")))
              ((string-match "\\(org\\|tex\\)$" file-extension)
               (find-file  file))
              ((string-match "\\(bmp\\|ico\\|png\\|jpg\\|jpeg\\|tiff\\|gif\\)$" file-extension)
               (shell-command
                (concat "eog " file " &")))
	      ((string-match "\\(pdf\\|ps\\|dvi\\)$" file-extension)
	       (shell-command
		(concat "evince " file " &")))
	      ((string-match "\\(xls\\|xlsx\\)$" file-extension)
	       (shell-command
		(concat "et " file " &")))
	      ((string-match "\\(ppt\\|pptx\\)$" file-extension)
	       (shell-command
		(concat "wpp " file " &")))
	      ((string-match "\\(doc\\|docx\\)$" file-extension)
	       (shell-command
		(concat "wps " file " &")))))))
(defun my-open-external-progam-in-emacs ()
  (shell-command )
)

(defun ergoemacs-open-in-external-app ()
  "Open the current file or dired marked files in external app."
  (interactive)
  (let ( doIt
         (myFileList
          (cond
           ((string-equal major-mode "dired-mode") (dired-get-marked-files))
           (t (list (buffer-file-name))) ) ) )

    (setq doIt (if (<= (length myFileList) 5)
                   t
                 (y-or-n-p "Open more than 5 files?") ) )

    (when doIt
      (cond
       ((string-equal system-type "windows-nt")
        (mapc (lambda (fPath) (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t)) ) myFileList)
        )
       ((string-equal system-type "darwin")
        (mapc (lambda (fPath) (shell-command (format "open \"%s\"" fPath)) )  myFileList) )
       ((string-equal system-type "gnu/linux")
        (mapc (lambda (fPath) (let ((process-connection-type nil)) (start-process "" nil "xdg-open" fPath)) ) myFileList) ) ) ) ) )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;------------------------------
;;; EMMS
(require 'emms-setup)
(emms-standard) 
 (setq emms-player-list '(emms-player-mplayer)
        emms-player-mplayer-command-name "mplayer"
        emms-player-mplayer-parameters '("-slave")) 
 (setq emms-repeat-playlist nil
        emms-source-file-default-directory "/data/music/"
        emms-lyrics-dir "/data/music/"
        emms-lyrics-coding-system nil
        emms-playlist-buffer-name "*EMMS*")   
(global-set-key (kbd "C-c e g") 'emms-play-directory) 
(global-set-key (kbd "C-c e d") 'emms-play-dired) 
(global-set-key (kbd "C-c e v") 'emms-playlist-mode-go) 
(global-set-key (kbd "C-c e x") 'emms-start) 
(global-set-key (kbd "C-c e SPC") 'emms-pause) 
(global-set-key (kbd "C-c e s") 'emms-stop) 
(global-set-key (kbd "C-c e n") 'emms-next) 
(global-set-key (kbd "C-c e p") 'emms-previous)
;-------------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; webkit
;;
;;(require 'webkit)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; mew
;; (autoload 'mew "mew" nil t)
;; (autoload 'mew-send "mew" nil t)
 
;; ;; Optional setup (Read Mail menu for Emacs 21):
;; (if (boundp 'read-mail-command)
;;     (setq read-mail-command 'mew))
 
;; ;; Optional setup (e.g. C-xm for sending a message):
;; (autoload 'mew-user-agent-compose "mew" nil t)
;; (if (boundp 'mail-user-agent)
;;     (setq mail-user-agent 'mew-user-agent))
;; (if (fboundp 'define-mail-user-agent)
;;     (define-mail-user-agent
;;       'mew-user-agent
;;       'mew-user-agent-compose
;;       'mew-draft-send-message
;;       'mew-draft-kill
;;       'mew-send-hook))
;; (setq mew-name "dwl")
;; (setq mew-pop-user "ldw5258@gmail")
;; (setq mew-pop-server "pop.gmail.com")
;; (setq mew-smtp-user "ldw5258@gmail.com")
;; (setq mew-smtp-server "smtp.gmail.com")
;; (setq mew-config-alist
;;       '(
;;         ;; Default fetch mailbox is IMAP
;;         (default
;;          (mailbox-type          imap)
;;          (proto                 "%")
;;          (imap-server           "imap.gmail.com")
;;          (imap-user             "ldw5258@gmail.com")
;;          (name                  "dwyang")
;;          (user                  "ldw5258")
;;          (mail-domain           "gmail.com")
;;          (imap-size             0)
;;          (imap-delete           t)
;;          (imap-queue-folder     "%queue")
;;          (imap-trash-folder     "%Trash") ;; This must be in concile with your IMAP box setup
;;          (smtp-auth-list        ("PLAIN" "LOGIN" "CRAM-MD5")) 
;;          (smtp-user             "ldw5258@gmail.com")
;;          (smtp-server           "smtp.gmail.com"))
 
;;          ;; news group comp.lang.c
;;        (usenet
;;         (mailbox-type         . mbox)
;;         (proto                . -)
;;         (nntp-server           "news.aioe.org")
;;         (nntp-user             nil) ;; should be nil defaulty
;;         (nntp-header-only      nil)
;;         (nntp-newsgroup        "-comp.lang.c") ;; little '-'
;;         (nntp-size             0)
;;         (nntp-msgid-user       "dwyang")
;;         (smtp-auth-list        ("PLAIN" "LOGIN" "CRAM-MD5"))
;;         (smtp-user             "ldw5258@gmail.com")
;;         (smtp-server           "smtp.gmail.com"))
 
;;         (mailinglist
;;          (mailbox-type          pop)
;;          (proto                 +)
;;          (pop-server            "pop.gmail.com")
;;          (name                  "User Mew")
;;          (user                  "user")
;;          (mail-domain           "gmail.com")
;;          (pop-auth              pass)
;;          (pop-user              "popuser@gmail.com")
;;          (smtp-user             "smtpuser@gmail.com")
;;          (smtp-server           "smtp.gmail.com")
;;         )))
;;;octave(matlab)的使用，M文件脚本，M函数编程，数据转换，画图。.emacs文件中写入：
;;for octave
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
	  (lambda ()
	    (abbrev-mode 1)
	    (auto-fill-mode 1)
	    (if (eq window-system 'x)
		(font-lock-mode 1))))
(add-hook 'inferior-octave-mode-hook ;up and down arrow in the shell
	  (lambda ()
	    (turn-on-font-lock)
	    (define-key inferior-octave-mode-map [up]
	      'comint-previous-input)
	    (define-key inferior-octave-mode-map [down]
	      'comint-next-input)))
;;auctex
(load "auctex.el" nil t t)
(load "preview.el" nil t t)
(mapc (lambda (mode)
	(add-hook 'LaTeX-mode-hook mode))
      (list 'auto-fill-mode
	    'LaTeX-math-mode
	    'turn-on-reftex
	    'linum-mode)) 
(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (setq TeX-auto-untabify t ; remove all tabs before saving
		  TeX-engine 'xetex ; use xelatex default
		  TeX-show-compilation t) ; display compilation windows
	    (TeX-global-PDF-mode t) ; PDF mode enable, not plain
	    (setq TeX-save-query nil)
	    (flyspell-mode t)
	    (imenu-add-menubar-index)
	    (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol))) 
(setq TeX-view-program-list '("Evince" "evince %o")) 
(setq TeX-view-program-selection '((output-pdf "Evince") (output-dvi "Evince")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(epg-gpg-program "gpg")
 '(org-agenda-file (quote ("~/org/gtd.org.gpg")))
 '(org-agenda-files (quote ("~/org/tech.org" "~/org/gtd.org.gpg" "~/org/journal.org.gpg" "/home/dwliang/org/czsc.org" "/home/dwliang/org/gtd.org" "/home/dwliang/org/journal.org" "/home/dwliang/org/org-google-sync.org" "/home/dwliang/org/wtzc.org" "/home/dwliang/org/盐铁论.org"))))
;;; 在你每次修改该文件后存盘时自动编译
(add-hook 'after-save-hook 
	  (lambda () 
	    (mapcar 
	     (lambda (file) 
	       (setq file (expand-file-name file)) 
	       (when (string= file (buffer-file-name)) 
		 (save-excursion (byte-compile-file file)))) 
	     '("~/.emacs" "~/.gnus.el" "~/.wl"))))
;; 报错：symbol value  as variable is void: file
;;;
(require 'time-stamp-settings)
;; (add-hook 'write-file-hooks 
;; 	  (function (lambda () (set-lastmodified-tag) ))) 
;; (defun set-lastmodified-tag () 
;;   "Insert current date after Last Modified: "
;;         (interactive) 
;;         (let ((tostr (concat "Last Modified: " (current-time-string) "."))) 
;;         (save-excursion 
;;         (goto-char (point-min)) 
;;         (while (re-search-forward 
;;         "\\Last Modified:\\([A-Za-z0-9: ]*\\)?\\." nil t) 
;;         (replace-match tostr nil t)))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(region ((((class color) (min-colors 88) (background dark)) :background "#4CAA4CAA4CAA") (((class color) (min-colors 88) (background light)) :background "lightgoldenrod2") (((class color) (min-colors 16) (background dark)) :background "wheat") (((class color) (min-colors 16) (background light)) :background "lightgoldenrod2") (((class color) (min-colors 8)) :background "blue" :foreground "red") (((type tty) (class mono)) :inverse-video t) (t :background "gray"))))
