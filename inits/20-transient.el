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
       [("s" "Rsync" transient-dashboard-rsync)]])

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
       [("r" "Rename" lsp-rename)]])

    (defun transient-dashboard-rsync ()
      (interactive)
      (helm
       :sources (helm-build-in-file-source
                    "Rsync" (expand-file-name ".rsync-remotes" (magit-toplevel))
                    :action 'transient-dashboard-rsync-action)
       :buffer "*helm rsync*"))

    (defun transient-dashboard-rsync-action (remote)
      (let ((default-directory (magit-toplevel))
            (gitignore (get-buffer-create "*gitignore*")))
        (if (not default-directory) (error "not a git repository"))
        (with-current-buffer gitignore (erase-buffer))
        (let ((status
               (call-process "git" nil gitignore nil
                             "ls-files" "--other" "--ignored"
                             "--exclude-standard" "--directory")))
          (if (not (= status 0)) (error "git ls-files: %s" status)))
        (let ((process
               (start-process "rsync" "*rsync*"
                              "rsync" "-acv"
                              "--exclude=.git/" "--exclude-from=/dev/stdin"
                              "./" remote)))
          (with-current-buffer gitignore
            (process-send-region process (point-min) (point-max))
            (process-send-eof process))
          (set-process-sentinel
           process
           (lambda (process event) (message (format "rsync: %s" event))))))))
  :demand)
