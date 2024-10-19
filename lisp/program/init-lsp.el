
;; init-lsp.el
;; configure emacs lsp

(use-package lsp-ui
  :ensure t)

(use-package lsp-mode
  :ensure t)

(require 'lsp-mode)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'lsp)

;; (require 'ccls)
;; (setq ccls-executable "/home/zane/Downloads/ccls/ccls/Release/ccls")

(provide 'init-lsp)

