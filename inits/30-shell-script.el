(add-to-list 'auto-mode-alist '("/PKGBUILD" . shell-script-mode))
(add-hook 'sh-mode-hook
          (lambda ()
            (sh-electric-here-document-mode -1)))
