(use-package lsp
  :custom (lsp-rust-clippy-preference "on")
  :hook (rust-mode . lsp))
