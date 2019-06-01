(use-package magit
  :bind (("C-x m" . magit-status)
         :map magit-mode-map
         ("C-x a" . helm-mini))
  :config (use-package helm
            :bind (:map magit-mode-map
                        ("G" . (lambda () (interactive)
                                 (let ((default-directory (magit-toplevel)))
                                   (helm-grep-do-git-grep t)))))))
