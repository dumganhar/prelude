(desktop-save-mode 1) ;自动打开上次文件

; (scroll-bar-mode -1);去掉滚动条
(disable-theme 'zenburn)
; ;; color theme
; (load-file "~/.emacs.d/themes/color-theme-almost-monokai.el")
; (color-theme-almost-monokai)

;; 正则匹配大小写敏感
(setq-default case-fold-search nil) ; require exact matches

;; Set tab width
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))

;; Show line number
(require 'linum)
(global-linum-mode)

(global-whitespace-mode 1)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(require 'multiple-cursors)

(global-set-key (kbd "C-c C-c") 'mc/edit-lines)
(global-set-key (kbd "C-c C-n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-a") 'mc/mark-all-like-this)

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


; here are 20 hanzi and 40 english chars, see if they are the same width
; 你你你你你你你你你你你你你你你你你你你你
; aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

;; c c++ 配置
(require 'init-cc-mode)




