;; -*- emacs-lisp -*-

;; time-stamp: <2010-11-03 17:45:59 wednesday by taoshanwen>

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

;;; 个人信息
(setq user-mail-address "261008760@qq.com")
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
      scroll-conservatively 10000
      )

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

;;; 利用`eval-after-load'加快启动速度的库
;; 用eval-after-load避免不必要的elisp包的加载
;; http://emacser.com/eval-after-load.htm
(require 'eval-after-load)

;;; org-mode-setting
;;(setq load-path (cons "lisps/org/lisp" load-path))
;;(require 'org-install)
(require 'org-settings)
;; 让扩展名为.org的文件打开后默认进入 org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

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
(define-key global-map (kbd "C-x C-x") 'set-mark-command)
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
(define-key ctl-x-map "?" 'help-command)
;; 默认命令 C-h h view-hello-file
;;(define-key ctl-x-map "h" 'view-help-file)
;;查看变量的值和文档
;;C-h v (describe-variable)
(define-key ctl-x-map "v" 'describe-variable)
;; 查看函数的文档
;; C-h f (describe-function)
(define-key ctl-x-map "f" 'describe-function)
;; 查看face的文档
;; M-x describe-face
;; 查看某个mode的文档
;; C-h m (describe-mode)
;; 刚开始学习某个mode的时候, 可以用C-h m看看当前buffer对应的主mode和副mode的文档, 这个文档一般都会包括mode中的命令和快捷键列表.
(define-key ctl-x-map "m" 'describe-mode)
;; 查看某个快捷键对应的命令
;; C-h k (describe-key)
;;(global-set-key [C-f5] 'describe-key)
(define-key ctl-x-map "k" 'describe-key)
;; 查看某个命令对应的快捷键
;; C-h w (where-is)
;;(global-set-key [C-M-f5] 'where-is)
;;(define-key ctl-x-map "w" 'where-is)
;; 查看当前buffer所有的快捷键列表
;; C-h b (describe-bindings)
;;(global-set-key [C-f6] 'describe-bindings)
(define-key ctl-x-map "b" 'describe-bindings)
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
(define-key ctl-x-map "v" 'describe-variable)
;; 查看函数的文档
;; C-h f (describe-function)
(define-key ctl-x-map "f" 'describe-function)
;; 查看face的文档
;; M-x describe-face
;; 查看某个mode的文档
;; C-h m (describe-mode)
;; 刚开始学习某个mode的时候, 可以用C-h m看看当前buffer对应的主mode和副mode的文档, 这个文档一般都会包括mode中的命令和快捷键列表.
(define-key ctl-x-map "m" 'describe-mode)
;; 查看某个快捷键对应的命令
;; C-h k (describe-key)
;;(global-set-key [C-f5] 'describe-key)
(define-key ctl-x-map "k" 'describe-key)
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
(set-background-color "black") ;; 使用黑色背景
(set-foreground-color "white") ;; 使用白色前景
(set-face-foreground 'region "red")  ;; 区域前景颜色设为红色
(set-face-background 'region "blue") ;; 区域背景色设为蓝色

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
