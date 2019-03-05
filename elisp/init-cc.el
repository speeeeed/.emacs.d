;; init-cc.el


;; cc-mode
(setq c-default-style '((java-mode . "java")
			(awk-mode . "awk")
			(other . "linux")))
(setq c-basic-offset 8)
(setq-default indent-tabs-mode -1
 tab-always-indent -1
 backward-delete-char-untabify-method nil)

(add-to-list 'c-mode-hook
 (lambda () (setq c-syntactic-indentation nil)))

(defun set-c-mode-space ()
  (interactive)
  (setq c-basic-offset 4)
  (setq-default indent-tabs-mode nil))

(defun set-c-mode-tab ()
  (interactive)
  (setq c-basic-offset 8)
  (setq-default indent-tabs-mode t))

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t))

(defun my-c-mode-font-lock-if0 (limit)
  (save-restriction
    (widen)
    (save-excursion
      (goto-char (point-min))
      (let ((depth 0) str start start-depth)
        (while (re-search-forward "^\\s-*#\\s-*\\(if\\|else\\|endif\\)" limit 'move)
          (setq str (match-string 1))
          (if (string= str "if")
              (progn
                (setq depth (1+ depth))
                (when (and (null start) (looking-at "\\s-+0"))
                  (setq start (match-end 0)
                        start-depth depth)))
            (when (and start (= depth start-depth))
              (c-put-font-lock-face start (match-beginning 0) 'font-lock-comment-face)
              (setq start nil))
            (when (string= str "endif")
              (setq depth (1- depth)))))
        (when (and start (> depth 0))
          (c-put-font-lock-face start (point) 'font-lock-comment-face)))))
  nil)

(defun my-c-mode-common-hook ()
  (font-lock-add-keywords
   nil
   '((my-c-mode-font-lock-if0 (0 font-lock-comment-face prepend))) 'add-to-end))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(provide 'init-cc)
