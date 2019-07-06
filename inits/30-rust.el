(use-package lsp
  :config
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection "$HOME/.cargo/bin/rls 2>/dev/null")
                    :major-modes '(rust-mode)
                    :remote? t
                    :server-id 'rls-remote
                    :notification-handlers (ht ("window/progress" 'lsp-clients--rust-window-progress))))
  :custom
  (lsp-rust-clippy-preference "on")
  (lsp-rust-rls-server-command '("rustup" "run" "nightly" "rls"))
  :hook
  (rust-mode . lsp))
