(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))

(cmake-ide-setup)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook
          (lambda ()
            (define-key c++-mode-map "\C-xr"
              (lambda () (interactive) (helm :sources helm-source-rtags)))
            (add-hook 'before-save-hook 'clang-format-buffer nil t)))
