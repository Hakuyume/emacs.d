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

