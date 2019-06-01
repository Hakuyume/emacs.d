(use-package helm
  :bind (("C-x a" . helm-mini)
         ("M-y" . helm-show-kill-ring)
         :map helm-map
         ("C-h" . delete-backward-char)
         ("<tab>" . helm-execute-persistent-action))
  :custom
  (helm-display-function 'pop-to-buffer)
  (helm-mini-default-sources
   '(helm-source-buffers-list
     helm-source-recentf)))

(use-package helm-xref
  :init (custom-set-variables
         '(xref-show-xrefs-function 'helm-xref-show-xrefs)))
