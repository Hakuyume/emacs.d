(add-hook 'python-mode-hook 'jedi:setup)
(eval-after-load "jedi-core"
  '(progn
     (setq jedi:complete-on-dot t)
     (add-to-list 'company-backends 'company-jedi)))
(add-hook 'python-mode-hook 'indent-guide-mode)
