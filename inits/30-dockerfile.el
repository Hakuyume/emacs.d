(use-package dockerfile-mode
  :config
  (add-hook 'dockerfile-mode-hook
            (lambda () (setq-local tab-width 4)))
  :mode
  "/Containerfile")
