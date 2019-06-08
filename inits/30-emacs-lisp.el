(use-package indent-guide
  :config
  (define-key emacs-lisp-mode-map (kbd "C-M-i") nil)
  :hook (emacs-lisp-mode . indent-guide-mode))
