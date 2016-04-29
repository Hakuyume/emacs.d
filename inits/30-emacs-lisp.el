(when (package-installed-p 'indent-guide)
  (add-hook 'emacs-lisp-mode-hook 'indent-guide-mode))
