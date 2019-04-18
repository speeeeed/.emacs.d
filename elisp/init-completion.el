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

(provide 'init-completion)
