(add-hook 'latex-mode-hook 'indent-guide-mode)
(add-hook 'latex-mode-hook
          (lambda ()
            (make-local-variable 'helm-mini-default-sources)
            (yas-minor-mode)
            (add-to-list 'helm-mini-default-sources helm-source-yasnippet)
            (reftex-mode)
            (add-to-list 'helm-mini-default-sources helm-source-reftex)))
(eval-after-load "reftex"
  '(progn
     (setq reftex-refstyle "\\ref")
     (push '("reftex" :regexp t) popwin:special-display-config)
     (defvar helm-source-reftex
       '((name . "RefTeX")
         (candidates . (("ref" . reftex-reference)
                        ("cite" . reftex-citation)
                        ("label" . reftex-label)))
         (action . command-execute)))))
