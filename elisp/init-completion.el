;; init-completion.el


(use-package company
  :ensure t 
  :defer t
  :init (global-company-mode)
  :config
  (progn
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)
    (setq company-tooltip-align-annotations t
	  company-show-numbers t)
    (setq company-dabbrev-downcase nil))
  :diminish company-mode)

(use-package posframe
  :ensure t)

;;(use-package nox
;;  :load-path "~/.emacs.d/elisp/site/nox"
;;  :config
;;  (dolist (hook (list
;;		;; 'js-mode-hook
;;		;; 'rust-mode-hook
;;		;; 'python-mode-hook
;;		;; 'ruby-mode-hook
;;		'java-mode-hook
;;		'sh-mode-hook
;;		;; 'php-mode-hook
;;		'c-mode-common-hook
;;		'c-mode-hook
;;		'c++-mode-hook
;;		;; 'haskell-mode-hook
;;		))
;;    (add-hook hook '(lambda () (nox-ensure)))))

(provide 'init-completion)
