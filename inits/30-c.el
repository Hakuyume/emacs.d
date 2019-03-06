(add-hook 'c-mode-hook
          (lambda ()
            (define-key c-mode-map "\C-xr"
              (lambda () (interactive) (helm :sources helm-source-rtags)))))
