(use-package lsp-mode
  :custom
  (lsp-enable-snippet nil)
  :hook
  (before-save . lsp-format-buffer))

(use-package lsp-ui
  :custom
  (lsp-ui-doc-enable nil))
