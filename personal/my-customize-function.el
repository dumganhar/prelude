(defun change-cpp-to-lua ()
  "Changes cpp codes to lua codes."
  (interactive)
  
  ;; 正则替换最后是 t nil
  (goto-char 1)
  (while (search-forward-regexp "{\\([^}]\\)" nil t) (replace-match "\\1" t nil))

  (goto-char 1)
  (while (search-forward-regexp "\\([^{]\\)}" nil t) (replace-match "\\1end" t nil))

  (goto-char 1)
  (while (search-forward-regexp "^[A-z:]+[\s\t]*[A-z0-9_]*::\\(.*\\)" nil t) (replace-match "local function \\1" t nil))

  (goto-char 1)
  (while (search-forward-regexp "\\(CCSize\\|CCRect\\|CCPoint\\)[\s\t]+\\([A-z_0-9]+\\)" nil t) (replace-match "local \\2" t nil))

  (goto-char 1)
  (while (search-forward-regexp "[Cc]\\{2\\}[Ll][Oo][Gg]" nil t) (replace-match "cclog" t nil))

  (goto-char 1)
  (while (search-forward-regexp "\\([0-9]*\\)\\.\\([0-9]*\\)f\\([^A-z]\\)" nil t) (replace-match "\\1.\\2\\3" t nil))
  
  (goto-char 1)
  (while (search-forward-regexp "CC[A-z0-9_]+.*\\*\\(.*=\\)" nil t) (replace-match "local \\1" t nil))

  (goto-char 1)
  (while (search-forward-regexp "(\\([\s\t]*CC[A-z0-9_]+\\)[\s\t]*\\*[\s\t]*)[\s\t]*\\([A-z0-9]*[->]*[A-z0-9_]*([A-z0-9_]*)\\)" nil t) (replace-match "tolua.cast(\\2, \"\\1\")" t nil))

  ;; 非正则替换最后是 nil t
  (goto-char 1)
  (while (search-forward "::" nil t) (replace-match ":" nil t))
  
  (goto-char 1)
  (while (search-forward ";" nil t) (replace-match "" nil t))
  
  (goto-char 1)
  (while (search-forward "->" nil t) (replace-match ":" nil t))
  
  (goto-char 1)
  (while (search-forward "//" nil t) (replace-match "--" nil t))
  
  (goto-char 1)
  (while (search-forward "CC_UNUSED" nil t) (replace-match "" nil t))

  (goto-char 1)
  (while (search-forward "
" nil t) (replace-match "" nil t))

  )

(defun copy-line (&optional arg)
 "Save current line into Kill-Ring without mark the line"
 (interactive "P")
 (let ((beg (line-beginning-position)) 
   (end (line-end-position arg)))
 (copy-region-as-kill beg end))
)


(defun copy-word (&optional arg)
 "Copy words at point"
 (interactive "P")
 (let ((beg (progn (if (looking-back "[a-zA-Z0-9]" 1) (backward-word 1)) (point))) 
   (end (progn (forward-word arg) (point))))
 (copy-region-as-kill beg end))
)


(defun copy-paragraph (&optional arg)
 "Copy paragraphes at point"
 (interactive "P")
 (let ((beg (progn (backward-paragraph 1) (point))) 
   (end (progn (forward-paragraph arg) (point))))
 (copy-region-as-kill beg end))
)

(defun removeHungaryNaming_1 ()
  ;;  (interactive)
  (goto-char (point-min))
  ;; (while (search-forward-regexp "\\([ \\t]*\\*[ \\t]*\\)\\(p\\|pob\\|psz\\)\\([A-Z]\\)" nil t) 
  (while (search-forward-regexp "\\([^A-Za-z]\\)\\(p\\|pob\\|psz\\)\\([A-Z]\\)\\([a-z]\\)" nil t)
    (replace-match (concat (match-string 1)
                           (downcase (match-string 3))
                           (match-string 4)
                           ) t nil)))

(defun removeHungaryNaming_2 ()
  ;;  (interactive)
  (goto-char (point-min))
  ;; (while (search-forward-regexp "\\([ \\t]*\\*[ \\t]*\\)\\(p\\|pob\\|psz\\)\\([A-Z]\\)" nil t) 
  (while (search-forward-regexp "\\([^A-Za-z]\\)\\(p\\|pob\\|psz\\)\\([A-Z][A-Z]\\)" nil t)
    (replace-match "\\1\\3") t nil))


(defun my-process-file (fPath)
  "Process the file at path FPATH …"
  (let ( fileChanged-p )
    (with-temp-buffer
      (insert-file-contents fPath)

      ;; process text …
      (when (not (string-match "\\(unzip\\|third_party\\|kazmath\\)" fPath))
        (when (string-match "\\(cocos2dx\\/\\|CocosDenshion\\/\\|extensions\\/\\|samples\\/\\)" fPath)
          (removeHungaryNaming_1)
          ;; (removeHungaryNaming_2)
          ;; set fileChanged-p to true/false
          (setq fileChanged-p t)
      (when fileChanged-p (write-region 1 (point-max) fPath) ))))))

(require 'find-lisp)

(defun remove-hungary-naming()
  (mapc 'my-process-file (find-lisp-find-files "/Users/james/Project/cocos2d-x/cocos2dx" "\\.\\(cpp\\|h\\|mm\\)$")))


(provide 'my-customize-function)
