(use-package evil
  :ensure t
  :config
  (setcdr evil-insert-state-map nil)
  (define-key evil-insert-state-map [escape] 'evil-normal-state)
  (evil-mode t)
  (setq evil-emacs-state-cursor '("red" box))
  (setq evil-normal-state-cursor '("green" box))
  (setq evil-visual-state-cursor '("orange" box))
  (setq evil-insert-state-cursor '("red" bar))
  (setq evil-replace-state-cursor '("red" bar))
  (setq evil-operator-state-cursor '("red" )))

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
   ;; Normal function
   "s" 'save-buffer
   "r" 'recentf-open-files
   "w" 'whitespace-mode)

  (with-eval-after-load 'ivy
    (evil-leader/set-key
      "b" 'ivy-switch-buffer))

  (with-eval-after-load 'counsel
    (evil-leader/set-key
      "f" 'counsel-find-file
      "<SPC>" 'counsel-M-x
      "h k" 'counsel-descbinds
      "h v" 'counsel-describe-variable
      "h f" 'counsel-describe-function))

  ;; Projectile
  (with-eval-after-load 'counsel-projectile
    (evil-leader/set-key
      "p f" 'counsel-projectile-find-file
      "p d" 'counsel-projectile-find-dir))


  (with-eval-after-load 'counsel-gtags
    (evil-leader/set-key
      ;; GNU global tags
      "g r" 'counsel-gtags-find-reference
      "g d" 'counsel-gtags-find-definition
      "g b" 'counsel-gtags-go-backward
      "g f" 'counsel-gtags-go-forward
      "g s" 'counsel-gtags-find-symbol
      "g t" 'counsel-gtags-dwim
      "g u" 'counsel-gtags-update-tags)))

(provide 'init-evil)
