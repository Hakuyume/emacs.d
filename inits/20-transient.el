(use-package dired)

(use-package transient
  :bind ("C-q" . transient-dashboard)
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
       [("s" "Git Sync" transient-dashboard-git-sync)]])

    (define-transient-command transient-dashboard-grep ()
      [[("g" "Git Grep" transient-dashboard-grep-git-grep)]
       [("p" "Grep" helm-projectile-grep)]])

    (defun transient-dashboard-grep-git-grep ()
      (interactive)
      (magit-with-toplevel (helm-grep-do-git-grep t)))

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
       [("r" "Rename" lsp-rename)]])

    (defun transient-dashboard-git-sync ()
      (interactive)
      (helm
       :sources (helm-build-in-file-source
                    "Git Sync" (expand-file-name ".gitsync" (magit-toplevel))
                    :action 'transient-dashboard-git-sync-action)
       :buffer "*helm rsync*"))

    (defun transient-dashboard-git-sync-action (remote)
      (let* ((ref "refs/heads/_sync")
             (tree (magit-with-temp-index "HEAD" nil
               (magit-call-git "add" "--all")
               (magit-git-string "write-tree")))
             (parent (or (magit-rev-parse ref "--")
                         (magit-rev-parse "HEAD" "--")))
             (commit (magit-commit-tree "" tree parent)))
        (magit-update-ref ref "sync working tree" commit)
        (magit-run-git-async "push" "-v" remote (format "%s:%s" ref ref)))))
  :demand)
