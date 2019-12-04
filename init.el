(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=34341#31
(if (eq emacs-major-version 26)
    (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))
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
     xclip

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

     pyvenv)))

(unless (package-installed-p 'use-package)
  (defmacro use-package (&rest args)))

(use-package init-loader
  :custom
  (init-loader-show-log-after-init nil)
  :init
  (init-loader-load))
