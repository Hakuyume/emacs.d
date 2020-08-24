(use-package rust-mode)

(use-package lsp-mode
  :custom
  (lsp-rust-server 'rust-analyzer)
  (lsp-rust-clippy-preference "on")
  :hook
  (rust-mode . lsp))
