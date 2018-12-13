;; init-basic.el


;; basic setting
(load-theme 'deeper-blue)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(scroll-all-mode -1)
(if (not window-system)
    (setq linum-format "%4d "))
(global-linum-mode t)            ;; global linum mode
(setq inhibit-startup-message t)  ;; disable startup message
(setq make-backup-files nil)      ;; disable make backup files
;; set font
(set-face-attribute 'default nil
                    :family "Monaco" :height 120 :weight 'normal)

(if window-system
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
			charset
			(font-spec :family "Microsoft Yahei" :size 16))))
;;  (recentf-mode 1)
;;  (setq recentf-max-menu-items 25)
(require 'vc)
(delete 'Git vc-handled-backends)


;; awesome-tab
(use-package awesome-tab
  :load-path "~/.emacs.d/elisp"
  :config
  (awesome-tab-mode t)
  :bind (("M-<left>" . awesome-tab-backward-tab)
	 ("M-<right>" . awesome-tab-forward-tab)
	 ("M-<up>" . awesome-tab-backward-group)
	 ("M-<down>" . awesome-tab-forward-group)))


(provide 'init-basic)