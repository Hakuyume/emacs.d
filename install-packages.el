(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(package-refresh-contents)

(defvar my-packages
  '(
    helm
    popwin
    magit
    company-irony
    haskell-mode
    ))

(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))
