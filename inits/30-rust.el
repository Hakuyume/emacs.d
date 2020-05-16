(use-package rust-mode)

(use-package lsp-mode
  :custom
  ;; cargo install --git https://github.com/rust-analyzer/rust-analyzer.git --tag 2020-05-11 rust-analyzer
  (lsp-rust-server 'rust-analyzer)
  (lsp-rust-clippy-preference "on")
  :hook
  (rust-mode . lsp))
