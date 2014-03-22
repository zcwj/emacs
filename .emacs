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

;;; 个人信息
(setq user-mail-address "261008760@qq.com")
(setq user-fill-name "左次")

;;; 不要显示Emacs的开始画面
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;;; 在fringe上显示一个小乘着指示当前buffer的边界
(setq-default indicate-buffer-bounderies 'left)

;;; 尽快显示按键序列
(setq echo-keystrokes 0.1)
(setq system-time-locale "C")

;;; 不要流动条
(customize-set-variable 'scroll-bar-mode nil)

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
(autoload 'toggle-emacs-lock "emacs-lock" "Emacs lock" t)

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
(add-to-list 'load-path "~/lisps/git-emacs/")
(require 'git-emacs)





;;; 对Info-mode, view-mode, grep-mode, color-theme绑定vi中的光标移动快捷键hjkl,

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
