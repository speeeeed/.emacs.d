;; init-ivy.el

(use-package ivy
  :ensure t
  :defer t
  :config
  (ivy-mode 1))

(use-package counsel
  :ensure t
  :defer t
  :config
  (counsel-mode 1))

(use-package counsel-gtags
  :ensure t
  :config
  (add-hook 'c-mode-hook 'counsel-gtags-mode)
  (add-hook 'c++-mode-hook 'counsel-gtags-mode))

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode t))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :ensure t
  :init (ivy-rich-mode 1))

(provide 'init-ivy)
