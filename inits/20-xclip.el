(use-package xclip
  :if (not window-system)
  :init
  (xclip-mode 1))
