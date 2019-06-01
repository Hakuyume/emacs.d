(use-package lsp
  :custom (lsp-pyls-configuration-sources '("flake8"))
  :hook ((python-mode . lsp)
         (python-mode . (lambda () (add-hook 'before-save-hook 'lsp-format-buffer nil t)))))

(use-package indent-guide
  :hook (python-mode . indent-guide-mode))
