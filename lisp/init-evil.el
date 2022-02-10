;; (require 'zane-mode-line)

(use-package undo-tree
  :ensure t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (setcdr evil-insert-state-map nil)
  (define-key evil-insert-state-map [escape] 'evil-normal-state)
  (evil-mode t)
  (setq evil-flash-delay 10)
)

(defun swiper-at-point (sym)
  "Use `swiper' to search for the `sym' at point."
  (interactive (list (thing-at-point 'symbol)))
  (swiper sym))

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
   ;; file operation
   "fs" 'save-buffer

   ;; UI operation
   "um" 'toggle-menu-tool-tabbar
   "ut" 'tabbar-mode

   ;; Normal function
   "nr" 'recentf-open-files
   "nl" 'highlight-symbol-at-point
   "nz" 'unhighlight-regexp
   "nw" 'whitespace-mode

   ;; Buffer operation
   "bd" 'kill-current-buffer
   "bs" 'swiper
   "bf" 'swiper-at-point
   ;; "bb" 'ivy-switch-buffer

   ;; window operation
   "ww" 'other-window
   "w -" 'split-window-below
   "w /" 'split-window-right
   "wk" 'delete-window
   "wdo" 'delete-other-windows
   "wu" 'winner-undo
   "wr" 'winner-redo
   "wh" 'evil-window-left
   "wj" 'evil-window-down
   "wk" 'evil-window-up
   "wl" 'evil-window-right
   )

  (with-eval-after-load 'ivy
    (evil-leader/set-key
      "bb" 'ivy-switch-buffer))

  (with-eval-after-load 'counsel
    (evil-leader/set-key
      "ff" 'counsel-find-file
      "<SPC>" 'counsel-M-x
      "hk" 'counsel-descbinds
      "hv" 'counsel-describe-variable
      "hf" 'counsel-describe-function))

  ;; Projectile
  (with-eval-after-load 'counsel-projectile
    (evil-leader/set-key
      "pf" 'counsel-projectile-find-file
      "pg" 'counsel-projectile-rg
      "pd" 'counsel-projectile-find-dir))

  (with-eval-after-load 'imenu-list
    (evil-leader/set-key
      "ni" 'imenu-list-smart-toggle))

  (with-eval-after-load 'neotree
    (evil-leader/set-key
      "nn" 'neotree-toggle))

  (with-eval-after-load 'counsel-gtags
    (evil-leader/set-key
      ;; GNU global tags
      "gr" 'counsel-gtags-find-reference
      "gd" 'counsel-gtags-find-definition
      "gb" 'counsel-gtags-go-backward
      "gf" 'counsel-gtags-go-forward
      "gs" 'counsel-gtags-find-symbol
      "gt" 'counsel-gtags-dwim
      "gu" 'counsel-gtags-update-tags)))

(use-package evil-escape
  :load-path "~/.emacs.d/elisp"
  :config
  (evil-escape-mode))

(use-package evil-collection
  :ensure t
  :defer t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-collection-init)
  )

(provide 'init-evil)
