(use-package markdown-mode
  :bind (:map markdown-mode-map
              ("<tab>" . markdown-demote)
              ("S-<iso-lefttab>" . markdown-promote)
              ("C-c C-c" . 'markdown-preview))
  :custom
  (markdown-asymmetric-header t)
  (markdown-command "pandoc -s --mathjax -f markdown -t html"))

(use-package indent-guide
  :hook (markdown-mode . indent-guide-mode))
