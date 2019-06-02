(use-package helm
  :bind (("M-y" . helm-show-kill-ring)
         :map helm-map
         ("C-h" . delete-backward-char)
         ("<tab>" . helm-execute-persistent-action))
  :custom
  (helm-display-function 'pop-to-buffer)
  (helm-mini-default-sources
   '(helm-source-buffers-list
     helm-source-recentf)))

(use-package helm-xref
  :custom
  (xref-show-xrefs-function 'helm-xref-show-xrefs))

;; https://github.com/emacs-helm/helm/issues/1976#issuecomment-378724670
(setq x-wait-for-event-timeout nil)
