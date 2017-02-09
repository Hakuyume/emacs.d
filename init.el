(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(custom-set-variables
 '(package-selected-packages
   '(
     company
     elscreen
     helm
     helm-c-yasnippet
     helm-flycheck
     indent-guide
     init-loader
     magit
     shackle

     cmake-mode
     haskell-mode
     markdown-mode
     matlab-mode
     rust-mode
     scala-mode
     toml-mode
     web-mode
     yaml-mode

     clang-format
     rtags
     cmake-ide
     py-autopep8
     flycheck-pyflakes
     company-jedi
     racer)))

(setq init-loader-show-log-after-init nil)
(init-loader-load)
