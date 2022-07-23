;; https://github.com/radian-software/straight.el#getting-started
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(custom-set-variables
 '(straight-use-package-by-default t))

(setq-default indent-tabs-mode nil)

(global-set-key (kbd "C-h") 'delete-backward-char)
(defalias 'exit 'save-buffers-kill-emacs)
(global-set-key (kbd "C-x C-c") (lambda () (interactive) (message "use M-x exit")))

(column-number-mode +1)
(global-linum-mode +1)
(menu-bar-mode -1)
(show-paren-mode +1)

(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message "")
(defun make-scratch ()
  (unless (get-buffer "*scratch*")
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)))
(add-hook 'after-save-hook 'make-scratch)
(add-hook 'kill-buffer-hook 'make-scratch)

(use-package company
  :bind
  (:map company-active-map ("C-h" . nil))
  :hook
  (after-init . global-company-mode))
(use-package consult
  :after
  (magit)
  :config
  (add-to-list 'consult-buffer-sources
               (list
                :category 'file
                :enabled 'magit-toplevel
                :face 'consult-file
                :items (lambda ()
                         (let ((default-directory (magit-toplevel)))
                           (mapcar 'expand-file-name (magit-list-files))))
                :name "Git"
                :narrow ?g
                :new 'consult--file-action
                :state 'consult--file-state)
               :append))
(use-package lsp-mode
  :hook
  (before-save . lsp-format-buffer))
(use-package magit)
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))
(use-package recentf
  :custom
  (recentf-max-saved-items 65536)
  :init
  (recentf-mode +1))
(use-package transient
  :bind
  ("C-q" . transient-dashboard)
  :config
  (progn
    (transient-define-prefix transient-dashboard ()
      [[("e" "Flymake" consult-flymake)]
       [("g" "Git grep" consult-git-grep)]
       [("h" "Buffer" consult-buffer)]
       [("j" "Goto line" goto-line)]
       [("m" "Magit" magit-status)]])))
(use-package vertico
  :init
  (vertico-mode +1))
(use-package whitespace
  :custom
  (whitespace-style '(face tab-mark tabs trailing))
  :init
  (global-whitespace-mode +1))
(use-package windmove
  :custom
  (windmove-wrap-around t)
  :init
  (windmove-default-keybindings))

(use-package dockerfile-mode
  :hook
  (dockerfile-mode-hook . (lambda () (setq-local tab-width 4)))
  :mode
  "/Containerfile")
(use-package markdown-mode
  :custom
  (markdown-asymmetric-header t))
(use-package lsp-pyright
  :hook
  (python-mode . (lambda () (require 'lsp-pyright) (lsp))))
(use-package protobuf-mode)
(use-package rust-mode
  :custom
  (lsp-rust-server 'rust-analyzer)
  (lsp-rust-clippy-preference "on")
  :hook
  (rust-mode . lsp))
(use-package sh-script
  :custom
  (sh-here-document-word " 'EOD'")
  :mode
  ("/PKGBUILD" . shell-script-mode))
(use-package systemd)
(use-package toml-mode)
(use-package typescript-mode)
(use-package yaml-mode)
