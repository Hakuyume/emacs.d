(eval-after-load "flycheck"
  '(progn
     (define-key flycheck-mode-map "\C-xe" 'helm-flycheck)))
