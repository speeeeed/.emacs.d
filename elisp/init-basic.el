;; init-basic.el


;; basic setting

;; face
(tool-bar-mode -1)
(menu-bar-mode -1)
(if window-system
    (progn
      (scroll-bar-mode -1)
      (load-theme 'tsdh-light)
      )
  (progn
    (setq linum-format "%4d ")
    ;; (load-theme 'manoj-dark)
    ))
(scroll-all-mode -1)
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

(remove-hook 'find-file-hook 'vc-find-file-hook)

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
;; (use-package multiple-cursors
;;   :ensure t
;;   :bind ("C->" . mc/mark-next-like-this)
;;   ("C-<" . mc/mark-previous-like-this)
;;   ("C-c C-<" . mc/mark-all-like-this))

(use-package window-numbering
  :ensure t
  :config
  (window-numbering-mode 1)
  (winner-mode 1))

;; (use-package magit
;;  :ensure t)

;; Visualize TAB, (HARD) SPACE, NEWLINE
;; (use-package whitespace
;;   :ensure nil
;;   :diminish
;;   :hook ((prog-mode outline-mode conf-mode) . whitespace-mode)
;;   :config
;;   (setq whitespace-line-column fill-column) ;; limit line length
;;   ;; automatically clean up bad whitespace
;;   (setq whitespace-action '(auto-cleanup))
;;   ;; only show bad whitespace
;;   (setq whitespace-style '(face
;;                            trailing space-before-tab
;;                            indentation empty space-after-tab))
;;
;;   (with-eval-after-load 'popup
;;     ;; advice for whitespace-mode conflict with popup
;;     (defvar my-prev-whitespace-mode nil)
;;     (make-local-variable 'my-prev-whitespace-mode)
;;
;;     (defadvice popup-draw (before my-turn-off-whitespace activate compile)
;;       "Turn off whitespace mode before showing autocomplete box."
;;       (if whitespace-mode
;;           (progn
;;             (setq my-prev-whitespace-mode t)
;;             (whitespace-mode -1))
;;         (setq my-prev-whitespace-mode nil)))
;;
;;     (defadvice popup-delete (after my-restore-whitespace activate compile)
;;       "Restore previous whitespace mode when deleting autocomplete box."
;;       (if my-prev-whitespace-mode
;;           (whitespace-mode 1)))))

;; (require 'zane-mode-line)

(setq ring-bell-function 'ignore)

(provide 'init-basic)
