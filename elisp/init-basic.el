;; init-basic.el


;; basic setting
(load-theme 'deeper-blue)
;; (load-theme 'wombat)
;; (load-theme 'adwaita)

;; face
(tool-bar-mode t)
(menu-bar-mode t)
(if window-system
    (scroll-bar-mode -1))
(scroll-all-mode -1)
(if (not window-system)
    (setq linum-format "%4d "))
(global-linum-mode t)            ;; global linum mode
(setq inhibit-startup-message t)  ;; disable startup message
(setq make-backup-files nil)      ;; disable make backup files

;; highligh mode
(global-hl-line-mode -1)
;; (set-face-foreground 'highlight nil)
;; (set-face-attribute hl-line-face nil :underline nil)
;; set font
(set-face-attribute 'default nil
                    :family "Source Code Pro" :height 130 :weight 'normal)

(if window-system
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
			charset
			(font-spec :family "Microsoft Yahei" :size 16))))
;;  (recentf-mode 1)
;;  (setq recentf-max-menu-items 25)
(require 'vc)
(delete 'Git vc-handled-backends)

(setq initial-scratch-message ";; Happy Hacking, enjoy emacs!\n\n")

;; init octave mode
;; (autoload 'octave-mode "octave-mode" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))

(modify-syntax-entry ?_ "w")  ;; will set '_'  a part of word
(add-hook 'c-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'c++-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'emacs-lisp-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))

;; awesome-tab
;; (use-package awesome-tab
;;  :load-path "~/.emacs.d/elisp"
;;  :config
;;  (awesome-tab-mode -1)
;;  :bind (("M-<left>" . awesome-tab-backward-tab)
;;	 ("M-<right>" . awesome-tab-forward-tab)
;;	 ("M-<up>" . awesome-tab-backward-group)
;;	 ("M-<down>" . awesome-tab-forward-group)))

(defun set-my-mode-line ()
  (setq evil-normal-state-tag   (propertize "[N]" 'face '((:background "green" :foreground "black")))
	evil-emacs-state-tag    (propertize "[E]" 'face '((:background "orange" :foreground "black")))
	evil-insert-state-tag   (propertize "[I]" 'face '((:background "red") :foreground "white"))
	evil-motion-state-tag   (propertize "[M]" 'face '((:background "blue") :foreground "white"))
	evil-visual-state-tag   (propertize "[V]" 'face '((:background "grey80" :foreground "black")))
	evil-operator-state-tag (propertize "[O]" 'face '((:background "purple"))))

  (setq-default mode-line-format
              (list '(:propertize " %l " face (:weight bold))
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
  )

(set-my-mode-line)

(defvar mode-line-show 1)
(defun toggle-mode-line ()
  (interactive)
  (if (= mode-line-show 1)
      (setf mode-line-show -1)
    (setf mode-line-show 1))
  (if (= mode-line-show 1)
      (set-my-mode-line)
    (setq mode-line-format nil))
  )


(use-package tabbar
  :ensure t
  :config
  (tabbar-mode t)
  (set-face-attribute 'tabbar-default nil
		      :family "Courier New"
		      :background "gray80"
		      :foreground "gray30"
		      :height 1.0)

  (set-face-attribute 'tabbar-selected nil
		      :inherit 'tabbar-default
		      :foreground "DarkGreen"
		      :background "LightGoldenrod"
		      :box '(:line-width 2 :color "DarkGoldenrod")
		      :overline "black"
		      :underline "black"
		      :weight 'bold)

  (set-face-attribute 'tabbar-unselected nil
		      :inherit 'tabbar-default
		      :box '(:line-width 2 :color "gray70"))

  :bind (("M-<left>"  . tabbar-backward-tab)
	 ("M-<right>" . tabbar-forward-tab)
	 ("M-<up>"    . tabbar-backward-group)
	 ("M-<down>"  . tabbar-forward-group))
  )

;; (use-package powerline
;;  :ensure t
;;  :config
;;  (powerline-default-theme))

(use-package imenu-list
  :load-path "~/.emacs.d/elisp/"
  :config
  (imenu-list-minor-mode -1))

;; not important
;;(use-package beacon
;;  :ensure t
;;  :config
;;  (beacon-mode t))

;; for test
(use-package multiple-cursors
  :ensure t
  :bind ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this))

(use-package window-numbering
  :ensure t
  :config
  (window-numbering-mode 1)
  (winner-mode 1))


(provide 'init-basic)
