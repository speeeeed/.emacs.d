;; init-elpa.el

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(("gnu" . "http://elpa.emacs-china.org/gnu/")
        ("melpa-stable" . "http://elpa.emacs-china.org/melpa-stable/")
        ("melpa" . "http://elpa.emacs-china.org/melpa/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)


(provide 'init-elpa)
