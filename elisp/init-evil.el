(require 'zane-mode-line)


(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (setcdr evil-insert-state-map nil)
  (define-key evil-insert-state-map [escape] 'evil-normal-state)
  (evil-mode t)
  (setq evil-flash-delay 10)
  (setq evil-emacs-state-cursor '("red" box))
  (setq evil-normal-state-cursor '("green" box))
  (setq evil-visual-state-cursor '("orange" box))
  (setq evil-insert-state-cursor '("red" bar))
  (setq evil-replace-state-cursor '("red" bar))
  (setq evil-operator-state-cursor '("red" )))

(defvar menu-tool-tabbar-mode 1)
(defun toggle-menu-tool-tabbar ()
  (interactive)
  (if (= menu-tool-tabbar-mode 1)
      (setf menu-tool-tabbar-mode -1)
    (setf menu-tool-tabbar-mode 1))
  (tabbar-mode menu-tool-tabbar-mode)
  (menu-bar-mode menu-tool-tabbar-mode)
  (tool-bar-mode menu-tool-tabbar-mode)
  (zane-mode-line-mode menu-tool-tabbar-mode)
  )

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
   ;; Normal function
   "s" 'save-buffer
   "r" 'recentf-open-files
   "o" 'other-window
   "l" 'highlight-symbol-at-point
   "z" 'unhighlight-regexp
   "x" 'kill-current-buffer
   "t" 'tabbar-mode
   "ut" 'toggle-menu-tool-tabbar

   ;; window function
   "wu" 'winner-undo
   "wr" 'winner-redo
   "wh" 'evil-window-left
   "wj" 'evil-window-down
   "wk" 'evil-window-up
   "wl" 'evil-window-right
;;   "uw" 'whitespace-mode
   )

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

  (with-eval-after-load 'imenu-list
    (evil-leader/set-key
      "i" 'imenu-list-smart-toggle))

  (with-eval-after-load 'window-numbering
    (evil-leader/set-key
      "0"  'delete-window
      "1"  'select-window-1
      "2"  'select-window-2
      "3"  'select-window-3
;;      "w/" 'split-window-right
;;      "w-" 'split-window-below
;;      ":"  'counsel-M-x
;;      "wM" 'delete-other-windows
  ))

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

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-collection
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (with-eval-after-load 'imenu-list
    (require 'evil-collection-imenu-list)
    (evil-collection-imenu-list-setup)))

(provide 'init-evil)
