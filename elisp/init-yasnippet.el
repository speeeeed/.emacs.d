(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t)
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  ;; fix yasnippet and company tab conflict
  (defun check-expansion ()
    (save-excursion
      (if (looking-at "\\_>") t
	(backward-char 1)
	(if (looking-at "\\.") t
	  (backward-char 1)
	  (if (looking-at "->") t nil)))))

  (defun do-yas-expand ()
    (let ((yas/fallback-behavior 'return-nil))
      (yas/expand)))

  (defun tab-indent-or-complete ()
    (interactive)
    (cond
     ((minibufferp)
      (ivy-partial-or-done))
     (t
      (indent-for-tab-command)
      (if (or (not yas/minor-mode)
              (null (do-yas-expand)))
	  (if (check-expansion)
              (progn
		(company-manual-begin)
		(if (null company-candidates)
		    (progn
		      (company-abort)
		      (indent-for-tab-command)))))))))

  (defun tab-complete-or-next-field ()
    (interactive)
    (if (or (not yas/minor-mode)
	    (null (do-yas-expand)))
	(if company-candidates
	    (company-complete-selection)
	  (if (check-expansion)
	      (progn
		(company-manual-begin)
		(if (null company-candidates)
		    (progn
		      (company-abort)
		      (yas-next-field))))
	    (yas-next-field)))))

  (defun expand-snippet-or-complete-selection ()
    (interactive)
    (if (or (not yas/minor-mode)
	    (null (do-yas-expand))
	    (company-abort))
	(company-complete-selection)))

  (defun abort-company-or-yas ()
    (interactive)
    (if (null company-candidates)
	(yas-abort-snippet)
      (company-abort)))

  (global-set-key [tab] 'tab-indent-or-complete)
  (global-set-key (kbd "TAB") 'tab-indent-or-complete)
  (global-set-key [(control return)] 'company-complete-common)

  (define-key company-active-map [tab] 'expand-snippet-or-complete-selection)
  (define-key company-active-map (kbd "TAB") 'expand-snippet-or-complete-selection)

  (define-key yas-minor-mode-map [tab] nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)

  (define-key yas-keymap [tab] 'tab-complete-or-next-field)
  (define-key yas-keymap (kbd "TAB") 'tab-complete-or-next-field)
  (define-key yas-keymap [(control tab)] 'yas-next-field)
  (define-key yas-keymap (kbd "C-g") 'abort-company-or-yas))

(provide 'init-yasnippet)