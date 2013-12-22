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

(add-to-list 'load-path "~/.emacs.d/cl-lib")
(add-to-list 'load-path "~/.emacs.d/magit")
(add-to-list 'load-path "~/.emacs.d/git-modes")
(require 'magit)
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

(add-to-list 'load-path "~/.emacs.d/anything-config")
(require 'anything)
(require 'anything-config)
(global-set-key "\C-xa" 'anything)
(setq anything-sources
      (list anything-c-source-buffers
            anything-c-source-recentf
            anything-c-source-locate))
(setq anything-c-locate-command
      (case system-type
	('gnu/linux "locate -i -r %s")
	('berkeley-unix "locate -i %s")
	('windows-nt "es -i -r %s")
	(t "locate %s")))

(add-to-list 'load-path "~/.emacs.d/popwin-el")
(add-to-list 'load-path "~/.emacs.d/popwin-el/misc")
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq anything-samewindow nil)
(push '("anything" :regexp t) popwin:special-display-config)
(require 'popwin-yatex)
(push '("*YaTeX-typesetting*") popwin:special-display-config)

(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/auto-complete/lib/popup")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))
(add-hook 'kill-buffer-query-functions
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (progn (my-make-scratch 0) nil)
              t)))
(add-hook 'after-save-hook
          (lambda ()
            (unless (member (get-buffer "*scratch*") (buffer-list))
              (my-make-scratch 1))))

(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))
    (rename-buffer
     (format "%s:%s"
             (file-remote-p (buffer-file-name) 'method)
             (buffer-name)))))
(add-hook 'find-file-hook
          'th-rename-tramp-buffer)
(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0)
                             " is read-only.  Open it as root? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))
(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file))))

