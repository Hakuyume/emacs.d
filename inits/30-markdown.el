(use-package markdown-mode
  :config
  (progn
    (define-key markdown-mode-map (kbd "<tab>") 'markdown-demote)
    (define-key markdown-mode-map (kbd "S-<iso-lefttab>") 'markdown-promote)
    (define-key markdown-mode-map (kbd "C-c C-c") 'markdown-preview))
  :custom
  (markdown-asymmetric-header t)
  (markdown-command "pandoc -s --mathjax -f markdown -t html"))

(use-package indent-guide
  :hook
  (markdown-mode . indent-guide-mode))
