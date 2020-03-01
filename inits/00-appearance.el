(menu-bar-mode -1)
(when window-system
  (tool-bar-mode -1)
  (set-scroll-bar-mode 'right))

(load-theme 'misterioso)
(setq default-background (face-attribute 'default :background))
(unless window-system
  (send-string-to-terminal (format "\033]2;emacs@%s\007" (system-name)))
  (setq frame-background-mode (frame-parameter nil 'background-mode))
  (set-face-background 'default "unspecified-bg"))

(when (eq window-system 'w32)
  (set-face-attribute 'default nil :family "Consolas")
  (set-fontset-font nil '(#x80 . #x3FFFFF) (font-spec :family "Yu Gothic")))
(when (eq window-system 'x)
  (set-face-attribute 'default nil :family "Inconsolata")
  (set-fontset-font nil '(#x80 . #x3FFFFF) (font-spec :family "IPA Gothic")))
