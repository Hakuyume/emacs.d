(setq make-backup-files nil)

(tool-bar-mode -1)
(menu-bar-mode -1)

(set-scroll-bar-mode 'right)

(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq initial-major-mode 'fundamental-mode)

(cond
 ((eq window-system 'x)
  (global-set-key "\C-z" nil)
  ))

(setq windmove-wrap-around t)
(windmove-default-keybindings)

(setq-default truncate-lines t)
(global-linum-mode t)

(show-paren-mode t)

(cond
 ((eq window-system 'x)
  (setq x-select-enable-clipboard t)
  (global-set-key "\C-y" 'x-clipboard-yank)
  ))

(defface hlline
  '(
    (((class color)(background dark))
     (:background "black"))
    (((class color)(background light))
     (:background "light blue"))
    )
  "*Face used by hl-line.")
(setq hl-line-face 'hlline)
(global-hl-line-mode)

(require 'tramp)

