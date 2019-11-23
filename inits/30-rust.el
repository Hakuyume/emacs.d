(use-package lsp
  :custom
  (lsp-rust-server 'rust-analyzer)
  (lsp-rust-clippy-preference "on")
  :hook
  (rust-mode . lsp))
