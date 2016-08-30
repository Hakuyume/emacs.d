(eval-after-load "markdown-mode"
  '(progn
     (setq markdown-asymmetric-header t)
     (setq markdown-command "pandoc -s --mathml -f markdown -t html")
     (define-key markdown-mode-map (kbd "TAB") 'markdown-demote)
     (define-key markdown-mode-map (kbd "S-<iso-lefttab>") 'markdown-promote)
     (define-key markdown-mode-map "\C-c\C-c" 'markdown-preview)))
(when (package-installed-p 'indent-guide)
  (add-hook 'markdown-mode-hook 'indent-guide-mode))
