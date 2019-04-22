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
   "wo" 'delete-other-windows
   "wu" 'winner-undo
   "wr" 'winner-redo
   "wh" 'evil-window-left
   "wj" 'evil-window-down
   "wk" 'evil-window-up
   "wl" 'evil-window-right
   "w [" 'shrink-window-horizontally
   "w ]" 'enlarge-window-horizontally
   "w ^" 'enlarge-window
   "w *" 'shrink-window
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
      "pd" 'counsel-projectile-find-dir))

  (with-eval-after-load 'imenu-list
    (evil-leader/set-key
      "ni" 'imenu-list-smart-toggle))

  (with-eval-after-load 'neotree
    (evil-leader/set-key
      "nn" 'neotree-toggle))

  (with-eval-after-load 'window-numbering
    (evil-leader/set-key
      "w0"  'delete-window
      "w1"  'select-window-1
      "w2"  'select-window-2
      "w3"  'select-window-3
;;      "w/" 'split-window-right
;;      "w-" 'split-window-below
;;      ":"  'counsel-M-x
;;      "wM" 'delete-other-windows
  ))

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

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-collection
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (with-eval-after-load 'neotree
    (require 'evil-collection-neotree)
    (evil-collection-neotree-setup))
  (with-eval-after-load 'imenu-list
    (require 'evil-collection-imenu-list)
    (evil-collection-imenu-list-setup)))

(provide 'init-evil)
