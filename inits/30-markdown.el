(eval-after-load "markdown-mode"
  '(progn
     (setq markdown-asymmetric-header t)
     (if (executable-find "pandoc-filter-graphviz")
         (setq markdown-command "pandoc -s --mathjax -F pandoc-filter-graphviz -f markdown -t html")
       (setq markdown-command "pandoc -s --mathjax -f markdown -t html"))
     (define-key markdown-mode-map (kbd "TAB") 'markdown-demote)
     (define-key markdown-mode-map (kbd "S-<iso-lefttab>") 'markdown-promote)
     (define-key markdown-mode-map "\C-c\C-c" 'markdown-preview)))
(when (package-installed-p 'indent-guide)
  (add-hook 'markdown-mode-hook 'indent-guide-mode))
