(cd "~/")

(prefer-coding-system 'utf-8-unix)
(setq-default indent-tabs-mode nil)
(setq make-backup-files nil)
(setq custom-file (locate-user-emacs-file "custom.el"))

(setq ring-bell-function 'ignore)

(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq initial-major-mode 'fundamental-mode)

(global-set-key (kbd "C-h") 'delete-backward-char)

(setq windmove-wrap-around t)
(windmove-default-keybindings)

(setq-default truncate-lines t)
(global-linum-mode t)
(column-number-mode t)
(show-paren-mode t)

(defalias 'exit 'save-buffers-kill-emacs)
(global-set-key (kbd "C-x C-c")
                (lambda () (interactive) (message "use M-x exit")))
