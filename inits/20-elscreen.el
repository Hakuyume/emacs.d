(use-package elscreen
  :bind (:map elscreen-map
              ("C-t" . elscreen-toggle))
  :config (progn
            (elscreen-separate-buffer-list-mode)
            (elscreen-set-prefix-key "\C-t"))
  :custom
  (elscreen-display-tab nil)
  (elscreen-tab-display-control nil)
  (elscreen-tab-display-kill-screen nil)
  :init (elscreen-start))

(use-package helm-elscreen
  :bind ("C-t w" . helm-elscreen))
