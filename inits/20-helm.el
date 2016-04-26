(global-set-key "\C-xa" 'helm-mini)
(eval-after-load "helm"
  '(progn
     (define-key helm-map "\C-h" 'delete-backward-char)
     (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
     (custom-set-variables
      '(helm-mini-default-sources
        '(helm-source-buffers-list
          helm-source-recentf
          helm-source-files-in-current-dir
          helm-source-locate)))))
(eval-after-load "magit"
  '(progn
     (define-key magit-mode-map "\C-xa" 'helm-mini)))
