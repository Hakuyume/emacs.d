;; clang-fomat
;; cmake-ide

(cmake-ide-setup)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'clang-format-buffer nil t)))
