;; https://github.com/radian-software/straight.el#getting-started
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(custom-set-variables
 '(straight-use-package-by-default t))

(setq-default indent-tabs-mode nil)
(setq make-backup-files nil)

(global-set-key (kbd "C-h") 'delete-backward-char)
(defalias 'exit 'save-buffers-kill-emacs)
(global-set-key (kbd "C-x C-c") (lambda () (interactive) (message "use M-x exit")))

(column-number-mode +1)
(global-display-line-numbers-mode +1)
(menu-bar-mode -1)
(show-paren-mode +1)

(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message "")

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
(use-package eglot :straight (:type built-in)
  :hook
  (before-save . eglot-format-buffer))
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
(use-package treesit :straight (:type built-in)
  :config
  (let (
        (treesit-language-source-alist
         '(
           (dockerfile "https://github.com/camdencheek/tree-sitter-dockerfile" "v0.1.2")
           (go "https://github.com/tree-sitter/tree-sitter-go" "v0.20.0")
           (gomod "https://github.com/camdencheek/tree-sitter-go-mod" "v1.0.0")
           (json "https://github.com/tree-sitter/tree-sitter-json" "v0.19.0")
           (proto "https://github.com/Hakuyume/tree-sitter-proto")
           (python "https://github.com/tree-sitter/tree-sitter-python" "v0.20.4")
           (rust "https://github.com/tree-sitter/tree-sitter-rust" "v0.20.4")
           (toml "https://github.com/tree-sitter/tree-sitter-toml" "v0.5.1")
           (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.2" "tsx/src")
           (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.2" "typescript/src")
           (yaml "https://github.com/ikatyang/tree-sitter-yaml" "v0.5.0"))))
    (dolist (source treesit-language-source-alist)
      (unless (treesit-ready-p (car source) t)
        (treesit-install-language-grammar (car source))))))
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

(use-package dockerfile-ts-mode
  :demand
  :mode
  ;; https://github.com/emacs-mirror/emacs/blob/emacs-29.1/lisp/progmodes/dockerfile-ts-mode.el#L191
  "\\(?:Containerfile\\(?:\\..*\\)?\\|\\.[Cc]ontainerfile\\)\\'")
(use-package go-ts-mode)
(use-package hcl-mode
  :mode
  "\\.tf\\'")
(use-package json-ts-mode)
(use-package markdown-mode
  :custom
  (markdown-asymmetric-header t))
(use-package python
  :mode
  ;; https://github.com/emacs-mirror/emacs/blob/emacs-29.1/lisp/progmodes/python.el#L6736
  ("\\.py[iw]?\\'" . python-ts-mode)
  :config
  (cl-defmethod project-root ((project (head pyproject))) (cdr project))
  (defun find-pyproject (dir)
    (let ((project (locate-dominating-file dir "pyproject.toml")))
      (if project (cons 'pyproject project))))
  :hook
  (python-ts-mode . (lambda ()
                      (add-hook 'project-find-functions 'find-pyproject nil t)
                      (eglot-ensure))))
(use-package protobuf-ts-mode)
(use-package rust-ts-mode
  :demand
  :config
  (cl-defmethod project-root ((project (head cargo))) (cdr project))
  (defun find-cargo-workspace (dir)
    (with-current-buffer (generate-new-buffer "*cargo-metadata*")
      (let* ((default-directory dir)
             (metadata
              (when (eq (call-process "cargo" nil t nil "metadata" "--format-version=1" "--no-deps") 0)
                (goto-char (point-min))
                (json-parse-buffer))))
        (kill-buffer)
        (if metadata (cons 'cargo (gethash "workspace_root" metadata))))))
  :hook
  (rust-ts-mode . (lambda ()
                    (add-hook 'project-find-functions 'find-cargo-workspace nil t)
                    (eglot-ensure))))
(use-package sh-script
  :custom
  (sh-here-document-word " 'EOD'")
  :mode
  ("/PKGBUILD\\'" . shell-script-mode))
(use-package systemd)
(use-package toml-ts-mode
  :demand
  :mode
  ("/Pipfile\\'" . toml-ts-mode))
(use-package typescript-ts-mode)
(use-package yaml-ts-mode)
