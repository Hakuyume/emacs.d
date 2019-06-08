(use-package dired)

(use-package transient
  :bind ("C-z" . transient-dashboard)
  :demand
  :config
  (progn
    (define-transient-command transient-dashboard ()
      [[("e" "Flycheck" helm-flycheck)]
       [("g" "Grep" transient-dashboard-grep)]
       [("h" "Helm" helm-mini)]
       [("H" "Helm (full)" transient-dashboard-helm-full)]
       [("j" "Goto Line" goto-line)]
       [("l" "LSP" transient-dashboard-lsp)]
       [("m" "Magit" magit-status)]
       [("z" "Suspend" suspend-frame)]])

    (define-transient-command transient-dashboard-grep ()
      [[("g" "Git Grep" transient-dashboard-grep-git-grep)]
       [("p" "Grep" helm-projectile-grep)]])

    (defun transient-dashboard-grep-git-grep ()
      (interactive)
      (let ((default-directory (magit-toplevel))) (helm-grep-do-git-grep t)))

    (defun transient-dashboard-helm-full ()
      (interactive)
      (use-package helm-projectile)
      (let ((helm-mini-default-sources
             '(helm-source-buffers-list
               helm-source-recentf
               helm-source-projectile-files-list)))
        (helm-mini)))

    (define-transient-command transient-dashboard-lsp ()
      [[("d" "Definition" lsp-find-definition)]
       [("i" "Implementation" lsp-find-implementation)]
       [("r" "Rename" lsp-rename)]])))
