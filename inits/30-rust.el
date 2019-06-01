(use-package rust-mode
  :custom (rust-format-on-save t))

(use-package lsp
  :hook (rust-mode . lsp))
