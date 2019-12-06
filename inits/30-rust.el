(use-package rust-mode)

(use-package lsp-mode
  :custom
  ;; cargo install --git https://github.com/rust-analyzer/rust-analyzer.git ra_lsp_server
  (lsp-rust-server 'rust-analyzer)
  (lsp-rust-clippy-preference "on")
  :hook
  (rust-mode . lsp))
