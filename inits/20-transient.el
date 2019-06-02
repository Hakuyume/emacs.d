(use-package transient)

(define-transient-command transient-dashboard ()
  [[("f" "Flycheck" helm-flycheck)]
   [("g" "Grep" transient-dashboard-grep)]
   [("h" "Helm" helm-mini)]
   [("H" "Helm (large)" transient-dashboard-helm-large)]
   [("j" "Goto Line" goto-line)]
   [("m" "Magit" magit-status)]
   [("t" "Elscreen" transient-dashboard-elscreen)]])

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
  (let ((default-directory (magit-toplevel))) (helm-grep-do-git-grep t)))

(define-transient-command transient-dashboard-elscreen ()
  [[("c" "Create" elscreen-create)]
   [("t" "Toggle" elscreen-toggle)]
   [("w" "Screens" helm-elscreen)]])

(global-set-key (kbd "C-t") 'transient-dashboard)
(define-key dired-mode-map (kbd "C-t") 'transient-dashboard)
