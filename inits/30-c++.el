;; clang-fomat

(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'clang-format-buffer nil t)))
