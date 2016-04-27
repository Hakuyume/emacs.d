(eval-after-load "yasnippet"
  '(progn
     (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
     (yas-initialize)
     (define-key yas-minor-mode-map (kbd "TAB") nil)
     (if (package-installed-p 'helm-c-yasnippet)
         (require 'helm-c-yasnippet))))
