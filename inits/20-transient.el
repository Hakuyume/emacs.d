(use-package dired)

(use-package transient
  :bind (("C-t" . transient-dashboard)
         :map dired-mode-map
         ("C-t" . transient-dashboard))
  :demand
  :config (progn
            (define-transient-command transient-dashboard ()
              [[("e" "Flycheck" helm-flycheck)]
               [("g" "Grep" transient-dashboard-grep)]
               [("h" "Helm" helm-mini)]
               [("H" "Helm (large)" transient-dashboard-helm-large)]
               [("j" "Goto Line" goto-line)]
               [("m" "Magit" magit-status)]])

            (define-transient-command transient-dashboard-grep ()
              [[("g" "Git Grep" transient-dashboard-grep-git-grep)]
               [("p" "Grep" helm-projectile-grep)]])

            (defun transient-dashboard-helm-large ()
              (interactive)
              (helm '(helm-source-buffers-list
                      helm-source-recentf
                      helm-source-projectile-files-list)))

            (defun transient-dashboard-grep-git-grep ()
              (interactive)
              (let ((default-directory (magit-toplevel))) (helm-grep-do-git-grep t)))))
