(use-package lsp
  :custom (lsp-pyls-configuration-sources '("flake8"))
  :hook (python-mode . lsp))

(use-package indent-guide
  :hook (python-mode . indent-guide-mode))
