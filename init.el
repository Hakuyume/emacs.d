(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(custom-set-variables
 '(package-selected-packages
   '(
     init-loader
     use-package

     buffer-move
     company
     company-lsp
     helm
     helm-flycheck
     helm-projectile
     helm-xref
     indent-guide
     lsp-mode
     lsp-ui
     magit
     shackle

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
  :custom
  (init-loader-show-log-after-init nil)
  :init
  (init-loader-load))
