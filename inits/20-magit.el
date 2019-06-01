(use-package magit
  :bind (("C-x m" . magit-status)
         :map magit-mode-map
         ("C-x a" . helm-mini)
         ("G" . (lambda () (interactive)
                  (let ((default-directory (magit-toplevel)))
                    (helm-grep-do-git-grep t))))))
