;; init-basic.el

;; basic setting

(defun config-theme ()
  (use-package color-theme-sanityinc-solarized
    :ensure t)
  (use-package color-theme-sanityinc-tomorrow
    :ensure t)
  (setq custom-safe-themes t)
  (setq-default custom-enabled-themes '(sanityinc-tomorrow-night))
  (add-to-list 'custom-theme-load-path "~/.emacs.d/theme/")
)


(defun emacs-basic-setup ()
  (global-linum-mode t)            ;; global linum mode
  (if (not window-system)
      (setq linum-format "%4d "))
  (setq inhibit-startup-message t)  ;; disable startup message
  (setq make-backup-files nil)      ;; disable make backup files
  (setq-default make-backup-files nil)
  (require 'vc)
  (delete 'Git vc-handled-backends)
  (remove-hook 'find-file-hook 'vc-find-file-hook)
  (setq initial-scratch-message ";; Keep calm and carry on!\n\n")
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
  (modify-syntax-entry ?_ "w")  ;; will set '_'  a part of word
  (add-hook 'c-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  (add-hook 'c++-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  (add-hook 'emacs-lisp-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))
  (add-hook 'dts-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))
  (add-hook 'makefile-gmake-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))
  (setq ring-bell-function 'ignore)
  (setq scroll-step 1
	scroll-conservatively 10000)
  (electric-indent-mode -1)
  (setq auto-save-mode nil)
  (setq auto-save-default nil))

(defun font-setup ()
  (set-face-attribute 'default nil
		      :family "Consolas" :height 110 :weight 'normal)
  (if window-system
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
			charset
			(font-spec :family "Microsoft Yahei" :size 18)))))

(defun some-misc-mode-setup ()
  (use-package markdown-mode
    :ensure t)
  (setq auto-mode-alist
	(cons '("\\.m$" . octave-mode) auto-mode-alist))
  (add-hook 'octave-mode-hook
	    (lambda ()
	      (abbrev-mode 1)
	      (auto-fill-mode 1)
	      (if (eq window-system 'x)
		  (font-lock-mode 1))))
  (use-package dts-mode
    :ensure t))

(config-theme)
(emacs-basic-setup)
(font-setup)
(some-misc-mode-setup)

(defun reapply-themes ()
  "Forcibly load the themes listed in `custom-enabled-themes'."
  (dolist (theme custom-enabled-themes)
    (unless (custom-theme-p theme)
      (load-theme theme)))
  (custom-set-variables `(custom-enabled-themes (quote ,custom-enabled-themes))))

(add-hook 'after-init-hook 'reapply-themes)

(provide 'init-basic)
