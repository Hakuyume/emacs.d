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
     elscreen
     elscreen-separate-buffer-list
     helm
     helm-elscreen
     helm-flycheck
     indent-guide
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
     yaml-mode

     py-autopep8
     flycheck-pyflakes
     company-jedi
     racer)))

(use-package init-loader
  :custom (init-loader-show-log-after-init nil))
(init-loader-load)
