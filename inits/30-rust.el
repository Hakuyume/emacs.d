(use-package rust-mode)

(use-package lsp-mode
  :custom
  ;; cargo install --git https://github.com/rust-analyzer/rust-analyzer.git rust-analyzer
  (lsp-rust-server 'rust-analyzer)
  (lsp-rust-clippy-preference "on")
  :hook
  (rust-mode . lsp))
