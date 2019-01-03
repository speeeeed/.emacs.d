;; init-cc.el


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

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t))

(provide 'init-cc)
