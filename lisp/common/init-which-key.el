
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (dolist (pf '("SPC "))
    (which-key-declare-prefixes
      (concat pf "f") "files"
      (concat pf "b") "buffers"
      (concat pf "w") "windows"
      (concat pf "ws") "split window"
      (concat pf "wd") "delete window"
      (concat pf "g") "gtags"
      (concat pf "n") "normal"
      (concat pf "u") "user interface"
      (concat pf "h") "help"
      (concat pf "p") "projectile"
      )
    )
  )

(provide 'init-which-key)
