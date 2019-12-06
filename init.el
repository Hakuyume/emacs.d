(load
 (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory)
 nil)

(straight-use-package 'use-package)
(custom-set-variables
 '(straight-use-package-by-default t))

(use-package init-loader
  :custom
  (init-loader-show-log-after-init nil)
  :init
  (init-loader-load))
