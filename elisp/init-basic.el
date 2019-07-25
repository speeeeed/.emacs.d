;; init-basic.el

;; basic setting

;; face
(add-to-list 'custom-theme-load-path "~/.emacs.d/theme/")
(load-theme 'monokai)

(tool-bar-mode -1)
(menu-bar-mode -1)
(if window-system (progn (scroll-bar-mode -1)
      ;; (load-theme 'tsdh-light)
      )
  (progn
    (setq linum-format "%4d ")
    ;; (load-theme 'manoj-dark)
    ))
(scroll-all-mode -1)
(global-linum-mode t)            ;; global linum mode
(setq inhibit-startup-message t)  ;; disable startup message
(setq make-backup-files nil)      ;; disable make backup files

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

(setq initial-scratch-message ";; Keep calm and carry on!\n\n")

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

(use-package imenu-list
  :load-path "~/.emacs.d/elisp/"
  :config
  (imenu-list-minor-mode -1))

(use-package window-numbering
  :ensure t
  :config
  (window-numbering-mode 1)
  (winner-mode 1))

(setq ring-bell-function 'ignore)

(provide 'init-basic)
