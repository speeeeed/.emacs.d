;; init-basic.el

;; basic setting

;; face
(add-to-list 'custom-theme-load-path "~/.emacs.d/theme/")

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

;;(use-package imenu-list
;;  :load-path "~/.emacs.d/elisp/")

(use-package dts-mode
  :ensure t)

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

(electric-indent-mode -1)

;; (setq exec-path (append exec-path '("E:\\software\\glo663wb\\bin")))

(use-package markdown-mode
  :ensure t)

(provide 'init-basic)
