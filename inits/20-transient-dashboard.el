(use-package dired :straight nil)
(use-package helm-flycheck)
(use-package helm-projectile)
(use-package lsp-mode)
(use-package magit)

(use-package transient
  :bind ("C-q" . transient-dashboard)
  :config
  (progn
    (define-transient-command transient-dashboard ()
      [[("e" "Flycheck" helm-flycheck)]
       [("g" "Grep" transient-dashboard--grep)]
       [("h" "Helm" helm-mini)]
       [("H" "Helm (full)" transient-dashboard--helm-full)]
       [("i" "Quoted Insert" quoted-insert)]
       [("j" "Goto Line" goto-line)]
       [("l" "LSP" transient-dashboard--lsp)]
       [("m" "Magit" magit-status)]
       [("s" "Rsync" transient-dashboard--rsync)]])

    (define-transient-command transient-dashboard--grep ()
      [[("g" "Git Grep" transient-dashboard--grep-git-grep)]
       [("p" "Grep" helm-projectile-grep)]])

    (defun transient-dashboard--grep-git-grep ()
      (interactive)
      (magit-with-toplevel (helm-grep-do-git-grep t)))

    (defun transient-dashboard--helm-full ()
      (interactive)
      (let ((helm-mini-default-sources
             '(helm-source-buffers-list
               helm-source-recentf
               helm-source-projectile-files-list)))
        (helm-mini)))

    (define-transient-command transient-dashboard--lsp ()
      [[("d" "Definition" lsp-find-definition)]
       [("i" "Implementation" lsp-find-implementation)]
       [("r" "Rename" lsp-rename)]
       [("w" "Workspace folders" transient-dashboard--lsp-workspace-folders)]])

    (defun transient-dashboard--lsp-workspace-folders ()
      (interactive)
      (helm
       :sources (helm-build-sync-source
                    "LSP Workspace Folders"
                  :candidates (lsp-session-folders (lsp-session))
                  :action '(("Switch" . lsp-workspace-folders-switch)
                            ("Remove" . lsp-workspace-folders-remove)))
       :buffer "*helm lsp workspace folders*"))

    (defun transient-dashboard--rsync ()
      (interactive)
      (helm
       :sources (helm-build-in-file-source
                    "Rsync" (expand-file-name ".rsync" (magit-toplevel))
                    :action 'transient-dashboard--rsync-action)
       :buffer "*helm rsync*"))

    (defun transient-dashboard--rsync-action (remote)
      (call-process
       "rsync"
       nil "*rsync*" nil
       "-av" "--delete" "--exclude=.git/" (concat (magit-toplevel) "/") remote))))
