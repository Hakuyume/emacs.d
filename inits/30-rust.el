(use-package rust-mode
  :custom (rust-format-on-save t))

(use-package lsp
  :custom (lsp-rust-clippy-preference "on")
  :hook (rust-mode . lsp))
