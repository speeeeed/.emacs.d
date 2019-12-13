
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; init load path
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/elisp/lang")
;; (add-to-list 'load-path "~/.emacs.d/elisp/emacs-ccls")

;; init-elpa should be first
(require 'init-elpa)

(require 'init-basic)
(require 'init-evil)
(require 'init-ivy)
(require 'init-which-key)
(require 'init-completion)
(require 'init-neotree)
(require 'init-magit)

;; program language
(require 'init-cc)
(require 'init-lua)
(require 'init-python)

;; (require 'init-lsp)
;; (require 'init-yasnippet)
;; (require 'init-flycheck)
