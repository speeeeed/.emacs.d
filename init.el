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
(let ((normal-gc-cons-threshold (* 128 1024 1024))
      (init-gc-cons-threshold (* 512 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file)

(defun add-subdirectory (dir)
  "Load the init.el file from the subdirectory DIR."
  (interactive "DDirectory: ")
  (let ((init-file (expand-file-name "minit.el" dir)))
    (when (file-exists-p init-file)
      (load init-file)
      (message "Loaded init.el from %s" dir)
      t)))

(defmacro include-current-directory ()
  "Add the directory of the current file to `load-path'."
  `(let ((file-name (buffer-file-name)))
     (when file-name
       (let* ((file-dir (file-name-directory file-name))
              (directory (file-truename file-dir)))
         (unless (member directory load-path)
           (add-to-list 'load-path directory)
           (message "Added %s to `load-path'." directory))))))

(add-subdirectory "lisp")
(add-subdirectory "site-lisp")
(add-subdirectory "theme")

;; init-elpa should be first
;; (require 'init-elpa)

;; (require 'init-basic)
;; (require 'init-paredit)
;; (require 'init-evil)
;; (require 'init-ivy)
;; (require 'init-completion)
;; (require 'init-neotree)
;; (require 'init-magit)
;; (require 'init-which-key)

;; program language
;; (require 'init-cc)
;; (require 'init-python)

;; (require 'init-rime)
