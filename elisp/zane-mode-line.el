(require 'cl)

(defgroup zane-el nil
  "Modular tray bar."
  :group 'zane-el)
(defvar zane-el-mode-line-colors nil)

(defcustom zane-el-mode-line-active-color "DarkRed"
  "Active color."
  :type 'string
  :group 'zane-el)

(defcustom zane-el-mode-line-inactive-color "Gray10"
  "Inactive color."
  :type 'string
  :group 'zane-el)

(setq evil-normal-state-tag   (propertize "[N]" 'face '((:background "green" :foreground "black")))
      evil-emacs-state-tag    (propertize "[E]" 'face '((:background "orange" :foreground "black")))
      evil-insert-state-tag   (propertize "[I]" 'face '((:background "red") :foreground "white"))
      evil-motion-state-tag   (propertize "[M]" 'face '((:background "blue") :foreground "white"))
      evil-visual-state-tag   (propertize "[V]" 'face '((:background "grey80" :foreground "black")))
      evil-operator-state-tag (propertize "[O]" 'face '((:background "purple"))))

(setq zane-mode-line-format-list (list '(:propertize " %l " face (:weight bold))
				  'mode-line-mule-info
				  'mode-line-modified
				  'mode-line-remote " "
				  ;; evil state
				  '(:eval (evil-generate-mode-line-tag evil-state))
				  '(:eval (propertize " %b " 'face (if (buffer-modified-p) '(:background "#d33682" :foreground "#fdf6e3" :weight bold)
								    '(:background "#268bd2" :foreground "#fdf6e3" :weight normal))))
   				  '(:propertize " %p/%I " face (:background "gray60" :foreground "#fdf6e3")) 
				  '(:eval (propertize (concat " " (eyebrowse-mode-line-indicator) " "))) 
				  '(:eval (propertize (format-time-string "%p·%H:%M ") 'help-echo (format-time-string "%F %a") 'face '(:inherit 'font-lock-doc-face)))
				  '(:propertize vc-mode face (:inherit font-lock-keyword-face :weight bold))
				  " {%m} " "-%-"))

;; (setq-default mode-line-format zane-mode-line-format-list)

(defun enable-zane-mode-line ()
  ;; Restore mode-line colors.
  (set-face-attribute 'mode-line nil
                      :foreground (nth 0 zane-el-mode-line-colors)
                      :background (nth 1 zane-el-mode-line-colors)
                      :family (nth 2 zane-el-mode-line-colors)
                      :box (nth 3 zane-el-mode-line-colors)
                      :height (nth 4 zane-el-mode-line-colors))
                      ;;:height 10)
  (set-face-attribute 'mode-line-inactive nil
                      :foreground (nth 5 zane-el-mode-line-colors)
                      :background (nth 6 zane-el-mode-line-colors)
                      :family (nth 7 zane-el-mode-line-colors)
                      :box (nth 8 zane-el-mode-line-colors)
                      :height (nth 9 zane-el-mode-line-colors))

  (force-mode-line-update)
  (message "Enable zane-mode-line.")
  )

(unless zane-el-mode-line-colors
  (setq zane-el-mode-line-colors
        (list (face-attribute 'mode-line :foreground)
              (face-attribute 'mode-line :background)
              (face-attribute 'mode-line :family)
              (face-attribute 'mode-line :box)
              (face-attribute 'mode-line :height)
              (face-attribute 'mode-line-inactive :foreground)
              (face-attribute 'mode-line-inactive :background)
              (face-attribute 'mode-line-inactive :family)
              (face-attribute 'mode-line-inactive :box)
              (face-attribute 'mode-line-inactive :height)
              )))

(defun disable-zane-mode-line ()
  (unless zane-el-mode-line-colors
    (setq zane-el-mode-line-colors
          (list (face-attribute 'mode-line :foreground)
		(face-attribute 'mode-line :background)
		(face-attribute 'mode-line :family)
		(face-attribute 'mode-line :box)
		(face-attribute 'mode-line :height)
		(face-attribute 'mode-line-inactive :foreground)
		(face-attribute 'mode-line-inactive :background)
		(face-attribute 'mode-line-inactive :family)
		(face-attribute 'mode-line-inactive :box)
		(face-attribute 'mode-line-inactive :height)
		)))

  (set-face-attribute 'mode-line nil
		      :foreground zane-el-mode-line-active-color
		      :background zane-el-mode-line-active-color
		      :height 0.1
		      :box nil)

  (set-face-attribute 'mode-line-inactive nil
		      :foreground zane-el-mode-line-inactive-color
		      :background zane-el-mode-line-inactive-color
		      :height 0.1
		      :box nil
		      :inherit 'unspecified)

  (force-mode-line-update)
  (message "Disable zane-mode-line.")
  )

(defvar mode-line-show 1)
(defun toggle-mode-line ()
  (interactive)
  (if (= mode-line-show 1)
      (progn (setf mode-line-show -1)
	     ;;(set-zane-mode-line)
	     (disable-zane-mode-line)
	     )
    (progn (setf mode-line-show 1)
	   ;;(setq mode-line-format nil)
	   (enable-zane-mode-line)
	   )
    )
  )

(defun zane-mode-line-mode (zane-mode)
  (setf mode-line-show zane-mode)
  (if (= mode-line-show 1)
      (enable-zane-mode-line)
    (disable-zane-mode-line)))

(provide 'zane-mode-line)
