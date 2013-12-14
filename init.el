(setq make-backup-files nil)

(tool-bar-mode -1)
(menu-bar-mode -1)

(set-scroll-bar-mode 'right)

(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq initial-major-mode 'fundamental-mode)

(setq ring-bell-function 'ignore)

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

(global-set-key "\C-xm" 'magit-status)

(add-hook 'doc-view-mode-hook 'auto-revert-mode)

(setq auto-mode-alist (cons '("\\.tex$" . yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq tex-command "platex")
(add-hook 'yatex-mode-hook
	  '(lambda ()
	     (local-set-key "\C-c\C-c" '(lambda () (interactive) (YaTeX-typeset-menu nil ?j)))
	     (auto-fill-mode -1)
	     ))

(add-to-list 'load-path "~/.emacs.d")
(require 'multi-term)

(require 'flymake)

(defun flymake-tex-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-dir   (file-name-directory buffer-file-name))
         (local-file  (file-relative-name
                       temp-file
                       local-dir)))
    (list "platex" (list "-file-line-error" "-interaction=nonstopmode" local-file))))
(defun flymake-tex-cleanup-custom ()
  (let* ((base-file-name (file-name-sans-extension (file-name-nondirectory flymake-temp-source-file-name)))
	 (regexp-base-file-name (concat "^" base-file-name "\\.")))
    (mapcar '(lambda (filename)
	       (when (string-match regexp-base-file-name filename)
		 (flymake-safe-delete-file filename)))
	    (split-string (shell-command-to-string "ls"))))
  (setq flymake-last-change-time nil))
(push '("\\.tex$" flymake-tex-init flymake-tex-cleanup-custom) flymake-allowed-file-name-masks)
(add-hook 'yatex-mode-hook 'flymake-mode-1)
(defun flymake-mode-1 ()
  (if (not (null buffer-file-name)) (flymake-mode))
  (local-set-key "\C-cd" 'flymake-display-err-minibuf))
(defun flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info (flymake-current-line-no))))
         (count (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
        (let* ((text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)))
      (setq count (1- count)))))

(require 'tramp)

(require 'anything)
(require 'anything-config)
(global-set-key "\C-xa" 'anything)

