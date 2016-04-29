(package-refresh-contents)

(defvar auto-install-packages
  '(init-loader
    helm
    popwin
    magit
    company
    indent-guide))

(dolist (package auto-install-packages)
  (unless (package-installed-p package)
    (package-install package)))
