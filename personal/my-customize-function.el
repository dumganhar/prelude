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
  (while (search-forward "" nil t) (replace-match "" nil t))

  )

(provide 'my-customize-function)
