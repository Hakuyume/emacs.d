(use-package rust-mode
  :custom (rust-format-on-save t))

(add-hook 'rust-mode-hook 'lsp)
