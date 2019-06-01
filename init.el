(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(custom-set-variables
 '(package-selected-packages
   '(
     init-loader
     use-package

     buffer-move
     company
     company-lsp
     elscreen
     elscreen-separate-buffer-list
     helm
     helm-elscreen
     helm-flycheck
     helm-xref
     indent-guide
     lsp-mode
     lsp-ui
     magit
     shackle
     zenburn-theme

     cmake-mode
     dockerfile-mode
     haskell-mode
     js2-mode
     lua-mode
     markdown-mode
     matlab-mode
     ninja-mode
     rust-mode
     scala-mode
     toml-mode
     typescript-mode
     web-mode
     yaml-mode)))

(unless (package-installed-p 'use-package)
  (defmacro use-package (&rest args)))

(use-package init-loader
  :custom (init-loader-show-log-after-init nil)
  :init (init-loader-load))
