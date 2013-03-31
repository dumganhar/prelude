(desktop-save-mode 1) ;自动打开上次文件

(scroll-bar-mode -1);去掉滚动条 
(disable-theme 'zenburn)
;; color theme
(load-file "~/.emacs.d/themes/color-theme-almost-monokai.el")
(color-theme-almost-monokai)

;; 正则匹配大小写敏感
(setq-default case-fold-search nil) ; require exact matches

(require 'linum)
(global-linum-mode)

;; Comment and Uncomment
(defun comment-or-uncomment-line-or-region ()
  "Comments or uncomments the current line or region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    )
  )
(global-set-key "\M-," 'comment-or-uncomment-line-or-region)

;;(add-hook 'prog-mode-hook 'prelude-turn-off-whitespace t)

(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'auto-mode-alist '("\\.m\\'" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))


(global-set-key [(meta p)] 'window-move-down) ;光标位置不变，窗口向下移动两行
(global-set-key [(meta n)] 'window-move-up) ;光标位置不变，窗口向上移动四行

;; 有关大小写p的区别.
;; 小写的p, 总是将任意的参数转换为一个有意义的数字.即使不指定参数, 即参数为nil, 默认代表1.
;; 大写的p, 除非显式的通过C-u或其他方式指定参数, 否则所有的nil, 当作无参数处理.
(defun window-move-up (&optional arg)
  "Current window move-up 3 lines."
  (interactive "P")
  (if (region-active-p)
      (next-line nil)
    (if arg
        (scroll-up arg)
      (scroll-up 3))))
(defun window-move-down (&optional arg)
  "Current window move-down 3 lines."
  (interactive "P")
  (if (region-active-p)
      (previous-line nil)
    (if arg
        (scroll-down arg)
      (scroll-down 3))))


; 修改lua-mode 的tab宽度
(setq lua-indent-level 4)
(setq lua-electric-flag nil)
(defun lua-abbrev-mode-off () (abbrev-mode 0))
(add-hook 'lua-mode-hook 'lua-abbrev-mode-off)

(defun qiang-font-existsp (font)
  (if (null (x-list-fonts font))
      nil t))

(defun qiang-make-font-string (font-name font-size)
  (if (and (stringp font-size) 
           (equal ":" (string (elt font-size 0))))
      (format "%s%s" font-name font-size)
    (format "%s %s" font-name font-size)))

(defun qiang-set-font (english-fonts
					   english-font-size
					   chinese-fonts
					   &optional chinese-font-size)
  "english-font-size could be set to \":pixelsize=18\" or a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
  (require 'cl)						 ; for find if
  (let ((en-font (qiang-make-font-string
				  (find-if #'qiang-font-existsp english-fonts)
				  english-font-size))
		(zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
							:size chinese-font-size)))
	;; Set the default English font
	;;
	;; The following 2 method cannot make the font settig work in new frames.
	;; (set-default-font "Consolas:pixelsize=18")
	;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
	;; We have to use set-face-attribute
	(message "Set English Font to %s" en-font)
	(set-face-attribute
	 'default nil :font en-font)
	;; Set Chinese font
	;; Do not use 'unicode charset, it will cause the english font setting invalid
	(message "Set Chinese Font to %s" zh-font)
	(dolist (charset '(kana han symbol cjk-misc bopomofo))
	  (set-fontset-font (frame-parameter nil 'font)
						charset
						zh-font))))

(qiang-set-font
 '("Consolas" "Monaco" "DejaVu Sans Mono" "Monospace" "Courier New") ":pixelsize=14"
 '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))

;; c c++ 配置
(require 'init-cc-mode)
