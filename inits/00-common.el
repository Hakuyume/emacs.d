(cd "~/")

(prefer-coding-system 'utf-8-unix)
(setq-default indent-tabs-mode nil)
(setq make-backup-files nil)

(menu-bar-mode -1)
(setq ring-bell-function 'ignore)

(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq initial-major-mode 'fundamental-mode)

(global-set-key "\C-h" 'delete-backward-char)

(setq windmove-wrap-around t)
(windmove-default-keybindings)

(setq-default truncate-lines t)
(global-linum-mode t)
(column-number-mode t)
(show-paren-mode t)

(when window-system
  (tool-bar-mode -1)
  (set-scroll-bar-mode 'right)
  (global-set-key "\C-z" nil)
  (load-theme 'misterioso)
  (set-frame-parameter nil 'alpha 95))

(when (eq window-system 'w32)
  (set-face-attribute 'default nil :family "Consolas" :height 110)
  (set-fontset-font nil '(#x80 . #x3FFFFF) (font-spec :family "Yu Gothic")))
