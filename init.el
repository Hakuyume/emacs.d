(setq make-backup-files nil)

(menu-bar-mode -1)

(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq initial-major-mode 'fundamental-mode)

(setq ring-bell-function 'ignore)

(global-set-key "\C-h" 'delete-backward-char)

(cond
 ((eq window-system 'x)
  (tool-bar-mode -1)
  (set-scroll-bar-mode 'right)
  (setq x-select-enable-clipboard t)
  (global-set-key "\C-y" 'x-clipboard-yank)
  (global-set-key "\C-z" nil)
  (load-theme 'wombat)
  ))

(setq windmove-wrap-around t)
(windmove-default-keybindings)

(setq-default truncate-lines t)
(global-linum-mode t)
(column-number-mode t)
(show-paren-mode t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(require 'magit)
(require 'magit-blame)
(global-set-key "\C-xm" 'magit-status)

(require 'helm-config)
(global-set-key "\C-xa" 'helm-mini)
(helm-mode 0)
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
(custom-set-variables
 '(helm-mini-default-sources
   '(helm-source-buffers-list
     helm-source-recentf
     helm-source-files-in-current-dir
     helm-source-locate)))

(require 'whitespace)
(global-whitespace-mode 1)
(setq whitespace-style '(space-mark tab-mark face spaces tabs trailing))

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq helm-samewindow nil)
(push '("helm" :regexp t) popwin:special-display-config)
(push '("compilation" :regexp t) popwin:special-display-config)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(custom-set-variables
 '(company-backends
   (quote
    (company-irony company-bbdb company-nxml company-css company-semantic company-ropemacs company-cmake
		   company-capf (company-dabbrev-code company-gtags company-etags company-keywords)
		   company-oddmuse company-files company-dabbrev)))
 '(irony-additional-clang-options (quote ("-std=c++11"))))

(when (locate-library "uim-leim")
  (require 'uim-leim)
  (global-set-key [zenkaku-hankaku] 'uim-mode)
  (setq uim-default-im-prop '("action_skk_hiragana")))

(when (file-exists-p "/usr/share/clang/clang-format.el")
  (load "/usr/share/clang/clang-format.el")
  (add-hook 'c++-mode-hook
	    (lambda ()
	      (add-hook 'before-save-hook 'clang-format-buffer nil t))))

(add-hook 'c++-mode-hook
	  (lambda ()
	    (local-set-key "\C-c\C-c" 'compile)))
(setq compilation-read-command nil)

(add-hook 'c++-mode-hook 'irony-mode)

(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'haskell-indent-mode)

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
	  ((= arg 1) (message "Another *scratch* is created.")))))
(add-hook 'kill-buffer-query-functions
	  (lambda ()
	    (if (string= "*scratch*" (buffer-name))
		(progn (my-make-scratch 0) nil)
	      t)))
(add-hook 'after-save-hook
	  (lambda ()
	    (unless (member (get-buffer "*scratch*") (buffer-list))
	      (my-make-scratch 1))))

(defun sudo-reopen ()
  "Reopen current buffer with sudo."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
        (find-alternate-file (concat "/sudo::" file-name))
      (error "Cannot get a file name."))))

