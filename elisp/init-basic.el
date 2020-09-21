;; init-basic.el

;; basic setting

;; face
(add-to-list 'custom-theme-load-path "~/.emacs.d/theme/")
;; (load-theme 'monokai)
;; (load-theme 'adwaita)
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-acario-light t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


(global-linum-mode t)            ;; global linum mode
(setq inhibit-startup-message t)  ;; disable startup message
(setq make-backup-files nil)      ;; disable make backup files
(setq-default make-backup-files nil)

(setq auto-save-mode nil)
(setq auto-save-default nil)

;; set font
(set-face-attribute 'default nil
		    :family "Consolas" :height 110 :weight 'normal)

(if window-system
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
			charset
			(font-spec :family "Microsoft Yahei" :size 18)))
  (setq linum-format "%4d|"))

;;  (recentf-mode 1)
(use-package recentf
  :defer 1)

;;  (setq recentf-max-menu-items 25)
(require 'vc)
(delete 'Git vc-handled-backends)

(remove-hook 'find-file-hook 'vc-find-file-hook)
(setq initial-scratch-message ";; Keep calm and carry on!\n\n")
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
;; (setq mouse-wheel-progressive-speed nil)

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
(add-hook 'dts-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))
(add-hook 'makefile-gmake-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))

(use-package imenu-list
  :load-path "~/.emacs.d/elisp/")

(use-package dts-mode
  :ensure t)

(use-package memoize
  :ensure t)

(use-package all-the-icons
  :load-path "~/.emacs.d/elisp/site/all-the-icons"
  :ensure t)

(use-package awesome-tab
  :load-path "~/.emacs.d/elisp/site/awesome-tab"
  :init
  (bind-key "M-<left>"  'awesome-tab-backward-tab)
  (bind-key "M-<right>" 'awesome-tab-forward-tab)
  (bind-key "M-<up>"  'awesome-tab-backward-group)
  (bind-key "M-<down>" 'awesome-tab-forward-group)
  :config
  (awesome-tab-mode t)
  (setq awesome-tab-height 130)
  (setq awesome-tab-label-fixed-length 14))

(use-package doom-modeline
  :ensure t
  :config
  (doom-modeline-mode 1))

(setq ring-bell-function 'ignore)

;;(global-visual-line-mode 1)
;;(global-hl-line-mode 0)
;;(set-face-attribute hl-line-face nil :underline nil)
;;(set-face-background 'hl-line "#BEBEBE")
;; (set-face-foreground 'hl-line "#000000")

;; startup cost too much time on windows 10
;; (desktop-save-mode 1)

(setq scroll-step 1
      scroll-conservatively 10000)

;; (use-package aweshell
;;  :load-path "~/.emacs.d/elisp/site/aweshell")

(electric-indent-mode -1)

(setq exec-path (append exec-path '("E:\\software\\glo663wb\\bin")))

(use-package markdown-mode
  :ensure t)

(provide 'init-basic)
