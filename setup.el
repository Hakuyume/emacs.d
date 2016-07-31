(package-refresh-contents)

(defvar packages
  '(
    company
    helm
    helm-c-yasnippet
    helm-flycheck
    indent-guide
    init-loader
    magit
    popwin

    cmake-mode
    haskell-mode
    makdown-mode
    scala-mode
    yaml-mode))

(dolist (package packages)
  (unless (package-installed-p package)
    (package-install package)))
