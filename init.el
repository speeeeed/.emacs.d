;; MELPA
;; more packages

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives
      '(("gnu" . "http://elpa.emacs-china.org/gnu/")
	("melpa-stable" . "http://elpa.emacs-china.org/melpa-stable/")
        ("melpa" . "http://elpa.emacs-china.org/melpa/")
    ))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (company nlinum evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'evil)
(evil-mode t)

(tool-bar-mode -1)
(menu-bar-mode -1)

(global-nlinum-mode t)            ;; global nlinum mode
(setq inhibit-startup-message t)  ;; disable startup message
(setq make-backup-files nil)      ;; disable make backup files

;; cc-mode
(setq c-default-style '((java-mode . "java")
			(awk-mode . "awk")
			(other . "linux")))
(setq c-basic-offset 8)

;; set font
(set-face-attribute 'default nil
		    :family "Courier New" :height 145 :weight 'normal)

;; Chinese Font 配制中文字体
;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;   (set-fontset-font (frame-parameter nil 'font)
;;                     charset
;;                     (font-spec :family "Microsoft Yahei" :size 16)))

(global-company-mode t)
