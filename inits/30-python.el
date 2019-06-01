(add-hook 'python-mode-hook
          (lambda ()
            (lsp)
            (add-hook 'before-save-hook 'lsp-format-buffer nil t)))
(add-hook 'python-mode-hook 'indent-guide-mode)
