(use-package flycheck
  :config (use-package helm-flycheck
            :bind (:map flycheck-mode-map
                        ("C-x e" . helm-flycheck))))
