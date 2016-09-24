(global-set-key "\C-xa" 'helm-mini)
(global-set-key "\M-y" 'helm-show-kill-ring)
(global-set-key "\C-tw" 'helm-elscreen)
(eval-after-load "helm"
  '(progn
     (setq helm-display-function 'pop-to-buffer)
     (define-key helm-map "\C-h" 'delete-backward-char)
     (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
     (custom-set-variables
      '(helm-mini-default-sources
        '(helm-source-buffers-list
          helm-source-recentf)))))
(eval-after-load "magit"
  '(progn
     (define-key magit-mode-map "\C-xa" 'helm-mini)))
