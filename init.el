;; init.el --- Load the full configuration -*- lexical-binding: t -*-

;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
    (lambda ()
        (message "Emacs ready in %s with %d garbage collections."
            (format "%.2f seconds"
                (float-time
                    (time-subtract after-init-time before-init-time)))
        gcs-done)))

;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------
(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file)

;; init load path
(add-to-list 'load-path "~/.emacs.d/lisp")
;; init-elpa should be first
(require 'init-elpa)

(require 'init-basic)
(require 'init-paredit)
(require 'init-evil)
(require 'init-ivy)
(require 'init-completion)
(require 'init-neotree)
;; (require 'init-magit)

;; program language
(require 'init-cc)
(require 'init-python)
