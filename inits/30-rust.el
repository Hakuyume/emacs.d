(use-package lsp
  :custom
  (lsp-rust-clippy-preference "on")
  (lsp-rust-rls-server-command '("rustup" "run" "nightly" "rls"))
  :hook (rust-mode . lsp))
