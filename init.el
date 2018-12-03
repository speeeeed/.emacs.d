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
 '(package-selected-packages
   (quote
    (powerline-evil evil-leader counsel-gtags counsel-projectile projectile counsel yasnippet-snippets yasnippet company evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; define some function to make config more readable

(defun basic-config ()
  (load-theme 'tsdh-dark)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
;;  (scroll-bar-mode -1)
  (if (not window-system)
;;      (setq linum-format "%4d \u2502"))
      (setq linum-format "%4d "))
  (global-linum-mode t)            ;; global linum mode
  (setq inhibit-startup-message t)  ;; disable startup message
  (setq make-backup-files nil)      ;; disable make backup files
  ;; set font
  (set-face-attribute 'default nil
		      :family "Courier 10 pitch" :height 145 :weight 'normal)
  ;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
  ;;   (set-fontset-font (frame-parameter nil 'font)
  ;;                     charset
  ;;                     (font-spec :family "Microsoft Yahei" :size 16)))
;;  (setq redisplay-dont-pause t
;;	scroll-margin 3
;;	scroll-step 1
;;	scroll-conservatively 10000
;;	scroll-preserve-screen-position 1)
  (recentf-mode 1)
  (setq recentf-max-menu-items 25)
  (global-whitespace-mode t)
  (setq-default whitespace-style '(tabs tab-mark))
  )

(defun evil-and-leader-key-config ()
  (require 'evil-leader)
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
   ;; Normal function
   "f" 'counsel-find-file
   "s" 'save-buffer
   "b" 'ivy-switch-buffer
   "<SPC>" 'counsel-M-x

   ;; Projectile
   "p f" 'counsel-projectile-find-file
   "p d" 'counsel-projectile-find-dir


   ;; Emacs help
   "h k" 'counsel-descbinds
   "h v" 'counsel-describe-variable
   "h f" 'counsel-describe-function
   )
  (require 'evil)
  (setcdr evil-insert-state-map nil)
  (define-key evil-insert-state-map [escape] 'evil-normal-state)
  (with-eval-after-load 'counsel-gtags
    (evil-leader/set-key
     ;; GNU global tags
     "g r" 'counsel-gtags-find-reference
     "g d" 'counsel-gtags-find-definition
     "g b" 'counsel-gtags-go-backward
     "g f" 'counsel-gtags-go-forward
     "g s" 'counsel-gtags-find-symbol
     "g t" 'counsel-gtags-dwim
     "g u" 'counsel-gtags-update-tags
   ))
;;  (if (not window-system)
;;      (powerline-evil-vim-color-theme)
;;    (powerline-evil-center-color-theme))
  (evil-mode t))

(defun plugins-config ()
  (global-company-mode t)
  (yas-global-mode 1)
  (ivy-mode 1)
  (counsel-mode 1)
  (counsel-projectile-mode t)
  (add-hook 'c-mode-hook 'counsel-gtags-mode)
  (add-hook 'c++-mode-hook 'counsel-gtags-mode)
  )

(basic-config)
;; evil mode
(evil-and-leader-key-config)
(plugins-config)

;; cc-mode
(setq c-default-style '((java-mode . "java")
			(awk-mode . "awk")
			(other . "linux")))
(setq c-basic-offset 8)
(setq-default indent-tabs-mode t)

(defun set-c-mode-space ()
  (interactive)
  (setq c-basic-offset 4)
  (setq-default indent-tabs-mode nil))

(defun set-c-mode-tab ()
  (interactive)
  (setq c-basic-offset 8)
  (setq-default indent-tabs-mode t))

;; fix yasnippet and company tab conflict
(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
    (backward-char 1)
    (if (looking-at "->") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (cond
   ((minibufferp)
    (minibuffer-complete))
   (t
    (indent-for-tab-command)
    (if (or (not yas/minor-mode)
        (null (do-yas-expand)))
    (if (check-expansion)
        (progn
          (company-manual-begin)
          (if (null company-candidates)
          (progn
            (company-abort)
            (indent-for-tab-command)))))))))

(defun tab-complete-or-next-field ()
  (interactive)
  (if (or (not yas/minor-mode)
      (null (do-yas-expand)))
      (if company-candidates
      (company-complete-selection)
    (if (check-expansion)
      (progn
        (company-manual-begin)
        (if (null company-candidates)
        (progn
          (company-abort)
          (yas-next-field))))
      (yas-next-field)))))

(defun expand-snippet-or-complete-selection ()
  (interactive)
  (if (or (not yas/minor-mode)
      (null (do-yas-expand))
      (company-abort))
      (company-complete-selection)))

(defun abort-company-or-yas ()
  (interactive)
  (if (null company-candidates)
      (yas-abort-snippet)
    (company-abort)))

(global-set-key [tab] 'tab-indent-or-complete)
(global-set-key (kbd "TAB") 'tab-indent-or-complete)
(global-set-key [(control return)] 'company-complete-common)

(define-key company-active-map [tab] 'expand-snippet-or-complete-selection)
(define-key company-active-map (kbd "TAB") 'expand-snippet-or-complete-selection)

(define-key yas-minor-mode-map [tab] nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)

(define-key yas-keymap [tab] 'tab-complete-or-next-field)
(define-key yas-keymap (kbd "TAB") 'tab-complete-or-next-field)
(define-key yas-keymap [(control tab)] 'yas-next-field)
(define-key yas-keymap (kbd "C-g") 'abort-company-or-yas)
