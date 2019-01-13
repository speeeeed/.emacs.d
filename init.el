
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(add-to-list 'load-path "~/.emacs.d/elisp")

;; init-elpa should be first
(require 'init-elpa)

(require 'init-basic)

(require 'init-evil)

(require 'init-ivy)

(require 'init-completion)

(require 'init-cc)

(require 'init-which-key)
;; (require 'init-yasnippet)

;; (require 'init-flycheck)
