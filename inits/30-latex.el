(add-hook 'latex-mode-hook 'indent-guide-mode)
(add-hook 'latex-mode-hook 'reftex-mode)
(eval-after-load "reftex"
  '(progn
     (setq reftex-refstyle "\\ref")
     (push '("reftex" :regexp t) popwin:special-display-config)
     (defvar helm-source--reftex
       '((name . "reftex")
         (candidates . (("cite" . reftex-citation)
                        ("ref" . reftex-reference)
                        ("label" . reftex-label)))
         (action . command-execute)))))
(add-hook 'reftex-mode-hook
          (lambda ()
            (make-local-variable 'helm-mini-default-sources)
            (add-to-list 'helm-mini-default-sources helm-source--reftex)))
