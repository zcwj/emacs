;; Copyright (C) 2010 ahei

;; Author: ahei <ahei0802@gmail.com>
;; URL: http://code.google.com/p/dea/source/browse/trunk/my-lisps/org-settings.el
;; Time-stamp: <2014-05-05 21:36:10 星期一 by dwliang>

;; This  file is free  software; you  can redistribute  it and/or
;; modify it under the terms of the GNU General Public License as
;; published by  the Free Software Foundation;  either version 3,
;; or (at your option) any later version.

;; This file is  distributed in the hope that  it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR  A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You  should have  received a  copy of  the GNU  General Public
;; License along with  GNU Emacs; see the file  COPYING.  If not,
;; write  to  the Free  Software  Foundation,  Inc., 51  Franklin
;; Street, Fifth Floor, Boston, MA 02110-1301, USA.

;; can not work when default-major-mode is text-mode
;; (am-add-hooks
;;   `(text-mode-hook)
;;   'turn-on-orgstruct)

(require 'org-install)
(require 'org)

(defun org-settings ()
  "Settings for `org'."

  (setq org-startup-folded nil
        org-cycle-include-plain-lists t)
  (setq org-log-done 'time)

  (defun org-hook-settings ()
    "Hook settings for `org'."
    (setq truncate-lines nil)
    (eval-after-load "hideshow"
      `(setq fold-all-fun 'org-toggle-display-content
             fold-fun 'org-toggle-fold-subtree))
    (org-literal-links))
  (add-hook 'org-mode-hook 'org-hook-settings)
  
  (defun org-kill-whole-line (&optional arg)
    "Kill line, to tags or end of line."
    (interactive "P")
    (cond
     ((or (not org-special-ctrl-k)
          (bolp)
          (not (org-on-heading-p)))
      (call-interactively 'kill-whole-line))
     ((looking-at (org-re ".*?\\S-\\([ \t]+\\(:[[:alnum:]_@:]+:\\)\\)[ \t]*$"))
      (kill-region (point) (match-beginning 1))
      (org-set-tags nil t))
     (t (kill-region (point) (point-at-eol)))))

  (defun org-literal-links ()
    "Show literal links."
    (interactive)
	(org-remove-from-invisibility-spec '(org-link)) (org-restart-font-lock))

  (defun org-descriptive-links ()
    "Show descriptive links."
    (interactive)
    (org-add-to-invisibility-spec '(org-link)) (org-restart-font-lock))

  (defun org-display-content ()
    "Display content in `org-mode'."
    (interactive)
    (org-overview)
    (org-content))

  (defvar org-display-content nil "Display content or not now.")
  (make-variable-buffer-local 'org-display-content)

  (defvar org-fold-subtree nil "Fold subtree or not now.")
  (make-variable-buffer-local 'org-fold-subtree)
  
  (defun org-toggle-display-content ()
    "Toggle display content."
    (interactive)
    (setq org-display-content (not org-display-content))
    (if org-display-content
        (org-display-content)
      (show-all)))

  (defun org-toggle-fold-subtree ()
    "Toggle fold subtree."
    (interactive)
    (setq org-fold-subtree (not org-fold-subtree))
    (if org-fold-subtree
        (hide-subtree)
      (show-subtree)))

  (defun org-settings-4-emaci ()
    "`org-mode' settings for `emaci'."
    (emaci-add-key-definition "N" 'outline-next-visible-heading
                              '(eq major-mode 'org-mode))
    (emaci-add-key-definition "P" 'outline-previous-visible-heading
                              '(eq major-mode 'org-mode)))

  (eval-after-load "emaci"
    `(org-settings-4-emaci))

  (eal-define-keys
   'emaci-mode-map
   `(("N" emaci-N)
     ("P" emaci-P)))
  
  (defun org-jsinfo-settings ()
    "Settings for `org-jsinfo'."
    (setcdr (assoc 'view org-infojs-options) "showall"))

  (eval-after-load "org-jsinfo"
    `(org-jsinfo-settings)))
;; capture template
(setq org-capture-templates
      '(("T" "Todo" entry (file+heanline "~/org/gtd.org" "Tasks")
	 "* TODO %?\n %i\n %a")
	("w" "Wangtianzhaocha" entry (file+datetree "~/org/wtzc.org" "Read")
	 "* %?\nMorning Tea on %U\n %i\n %a")
	("C" "ChanZhongShuoChan" entry (file+datetree "~/org/czsc.org")
	 "* %?\nLearning on %U\n %i\n %a")
	("i" "New" entry (file+datetree "~/org/inbox.org" "Tasks")
	 "* %?\n 收件箱，收集未整理的信息 on %U\n %i\n %a")
	("t" "Task" entry (file+datetree "~/org/task.org" "Tasks")
	 "* %?\n 待办事项，所有未完成的事情 on %U\n %i\n %a")
	("c" "Calendar" entry (file+datetree "~/org/task.org" "Tasks")
	 "* %?\n 日程安排，具有明确时间的待办实现，可以是周期性任务 on %U\n %i\n %a")
	("I" "Idea" entry (file+datetree "~/org/idea.org" "Tasks")
	 "* %?\n 想法，愿望 on %U\n %i\n %a")
	("N" "Note" entry (file+datetree "~/org/note.org" "Tasks")
	 "* %?\n 笔记，最终会被移到真正的笔记本 on %U\n %i\n %a")
	("p" "Project" entry (file+datetree "~/org/project.org" "Tasks")
	 "* %?\n 项目任务 on %U\n %i\n %a")
	("r" "Read" entry (file+datetree "~/org/read.org.gpg" "Read")
	 "* %?\n 读书笔记 on %U\n %i\n %a")
	("n" "News" entry (file+datetree "~/org/news.org" "Read")
	 "* %?\n 新闻记录 on %U\n %i\n %a")
	("f" "Finished" entry (file+datetree "~/org/finished.org" "Tasks")
	 "* %?\n 归档 on %U\n %i\n %a")
	("Q" "秋波媚媚" entry (file+datetree "~/org/qiubomeimei.org" "Tasks")
	 "* %?\n 秋波媚媚 on %U\n %i\n %a")
	("j" "Journal" entry (file+datetree "~/org/journal.org.gpg")
	 "* %?\nEntered on %U\n %i\n %a")))
(eal-define-keys
 'org-mode-map
 `(("C-c e"   org-table-edit-field)
   ("C-k"     org-kill-whole-line)
   ("C-c M-b" org-export-as-html-and-open)
   ("C-c M-h" org-export-as-html)
   ("<tab>"   nil)
   ("C-j"     nil)
   ("C-c n"   org-forward-same-level)
   ("C-c p"   org-backward-same-level)
   ("C-c M-l" org-shiftright)
   ("C-c ,"   org-priority-sb)
   ("C-x C-p" org-move-subtree-up)
   ("C-x C-n" org-move-subtree-down)
   ("C-c c" org-capture)
   ("C-c l" org-store-link)
   ("C-c a" org-agenda)
   ("C-c b" org-iswitchb)
))

(eal-define-keys
 'org-agenda-mode-map
 `(("'" switch-to-other-buffer)
   ("1" delete-other-windows)
   ("2" split-window-vertically)
   ("3" split-window-horizontally)
   ("o" other-window)))

(defun org-colview-settings ()
  "Settings for `org-colview'."
  (org-defkey org-columns-map "e" 'org-columns-edit-value-sb)
  (org-defkey org-columns-map "h" 'backward-char)
  (org-defkey org-columns-map "l" 'forward-char)
  (org-defkey org-columns-map "j" 'next-line)
  (org-defkey org-columns-map "k" 'previous-line)
  (define-key org-columns-map "f" (key-binding (kbd "M-f")))
  (define-key org-columns-map "b" (key-binding (kbd "M-b"))))

(require 'org-latex)
(setq org-latex-to-pdf-process '("xelatex %f"))
;; ;; 设置xelatex为默认编译命令
;; (add-hook 'LaTeX-mode-hook (lambda()
;; 			     (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
;; 			     (setq TeX-command-default "XeLaTeX")
;; 			     (setq TeX-save-query  nil )
;; 			     (setq TeX-show-compilation t)
;; 			     ))

;; 使用xelatex一步生成PDF
(setq org-latex-to-pdf-process
      '("xelatex -interaction nonstopmode %f"
	"xelatex -interaction nonstopmode %f"))
;; code执行免应答（Eval code without confirm）
(setq org-confirm-babel-evaluate nil)
;; Auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(defun org-mode-article-modes ()
  (reftex-mode t)
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all)))
(add-hook 'org-mode-hook
          (lambda ()
            (if (member "REFTEX" org-todo-keywords-1)
                (org-mode-article-modes))))
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))

(add-to-list 'org-export-latex-classes
             '("cn-article"
               "\\documentclass[10pt,a4paper]{article}
\\usepackage{graphicx}
\\usepackage{xcolor}
\\usepackage{xeCJK}
\\usepackage{lmodern}
\\usepackage{verbatim}
\\usepackage{fixltx2e}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{tikz}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{textcomp}
\\usepackage{listings}
\\usepackage{geometry}
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{latexsym}
\\usepackage{natbib}
\\usepackage{fancyhdr}
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,
linkcolor=blue,
urlcolor=blue,
menucolor=blue]{hyperref}
\\usepackage{fontspec,xunicode,xltxtra}
\\setmainfont[BoldFont=Adobe Heiti Std]{Adobe Song Std}  
\\setsansfont[BoldFont=Adobe Heiti Std]{AR PL UKai CN}  
\\setmonofont{Bitstream Vera Sans Mono}  
\\newcommand\\fontnamemono{AR PL UKai CN}%等宽字体
\\newfontinstance\\MONO{\\fontnamemono}
\\newcommand{\\mono}[1]{{\\MONO #1}}
\\setCJKmainfont[Scale=0.9]{Adobe Heiti Std}%中文字体
\\setCJKmonofont[Scale=0.9]{Adobe Heiti Std}
\\hypersetup{unicode=true}
\\geometry{a4paper, textwidth=6.5in, textheight=10in,
marginparsep=7pt, marginparwidth=.6in}
\\definecolor{foreground}{RGB}{220,220,204}%浅灰
\\definecolor{background}{RGB}{62,62,62}%浅黑
\\definecolor{preprocess}{RGB}{250,187,249}%浅紫
\\definecolor{var}{RGB}{239,224,174}%浅肉色
\\definecolor{string}{RGB}{154,150,230}%浅紫色
\\definecolor{type}{RGB}{225,225,116}%浅黄
\\definecolor{function}{RGB}{140,206,211}%浅天蓝
\\definecolor{keyword}{RGB}{239,224,174}%浅肉色
\\definecolor{comment}{RGB}{180,98,4}%深褐色
\\definecolor{doc}{RGB}{175,215,175}%浅铅绿
\\definecolor{comdil}{RGB}{111,128,111}%深灰
\\definecolor{constant}{RGB}{220,162,170}%粉红
\\definecolor{buildin}{RGB}{127,159,127}%深铅绿
\\punctstyle{kaiming}
\\title{}
\\fancyfoot[C]{\\bfseries\\thepage}
\\chead{\\MakeUppercase\\sectionmark}
\\pagestyle{fancy}
\\tolerance=1000
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; 使用Listings宏包格式化源代码(只是把代码框用listing环境框起来，还需要额外的设置)
(setq org-export-latex-listings t)
;; Options for \lset command（reference to listing Manual)
(setq org-export-latex-listings-options
      '(
        ("basicstyle" "\\color{foreground}\\small\\mono")           ; 源代码字体样式
        ("keywordstyle" "\\color{function}\\bfseries\\small\\mono") ; 关键词字体样式
        ("identifierstyle" "\\color{doc}\\small\\mono")
        ("commentstyle" "\\color{comment}\\small\\itshape")         ; 批注样式
        ("stringstyle" "\\color{string}\\small")                    ; 字符串样式
        ("showstringspaces" "false")                                ; 字符串空格显示
        ("numbers" "left")                                          ; 行号显示
        ("numberstyle" "\\color{preprocess}")                       ; 行号样式
        ("stepnumber" "1")                                          ; 行号递增
        ("backgroundcolor" "\\color{background}")                   ; 代码框背景色
        ("tabsize" "4")                                             ; TAB等效空格数
        ("captionpos" "t")                                          ; 标题位置 top or buttom(t|b)
        ("breaklines" "true")                                       ; 自动断行
        ("breakatwhitespace" "true")                                ; 只在空格分行
        ("showspaces" "false")                                      ; 显示空格
        ("columns" "flexible")                                      ; 列样式
        ("frame" "single")                                          ; 代码框：阴影盒
        ("frameround" "tttt")                                       ; 代码框： 圆角
        ("framesep" "0pt")
        ("framerule" "8pt")
        ("rulecolor" "\\color{background}")
        ("fillcolor" "\\color{white}")
        ("rulesepcolor" "\\color{comdil}")
        ("framexleftmargin" "10mm")
        ))
;; Make Org use ido-completing-read for most of its completing prompts.
(setq org-completion-use-ido t)
;; ;; 各种Babel语言支持
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((R . t)
;;    (emacs-lisp . t)
;;    (matlab . t)
;;    (C . t)
;;    (perl . t)
;;    (sh . t)
;;    (ditaa . t)
;;    (python . t)
;;    (haskell . t)
;;    (dot . t)
;;    (latex . t)
;;    (js . t)
;;    ))

;; 导出Beamer的设置
;; allow for export=>beamer by placing #+LaTeX_CLASS: beamer in org files
;;-----------------------------------------------------------------------------
(add-to-list 'org-export-latex-classes
             ;; beamer class, for presentations
             '("beamer"
               "\\documentclass[11pt,professionalfonts]{beamer}
\\mode
\\usetheme{{{{Warsaw}}}}
%\\usecolortheme{{{{beamercolortheme}}}}

\\beamertemplateballitem
\\setbeameroption{show notes}
\\usepackage{graphicx}
\\usepackage{tikz}
\\usepackage{xcolor}
\\usepackage{xeCJK}
\\usepackage{amsmath}
\\usepackage{lmodern}
\\usepackage{fontspec,xunicode,xltxtra}
\\usepackage{polyglossia}
\\setmainfont{Times New Roman}
\\setCJKmainfont{DejaVu Sans YuanTi}
\\setCJKmonofont{DejaVu Sans YuanTi Mono}
\\usepackage{verbatim}
\\usepackage{listings}
\\institute{{{{beamerinstitute}}}}
\\subject{{{{beamersubject}}}}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\begin{frame}[fragile]\\frametitle{%s}"
                "\\end{frame}"
                "\\begin{frame}[fragile]\\frametitle{%s}"
                "\\end{frame}")))

(setq ps-paper-type 'a4
      ps-font-size 16.0
      ps-print-header nil
      ps-landscape-mode nil)

(eval-after-load "org"
  `(org-settings))

(eval-after-load "org-colview"
  `(org-colview-settings))

(provide 'org-settings)
