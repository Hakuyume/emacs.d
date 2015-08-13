(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(defvar my-packages
  '(helm
    popwin
    magit
    company))

(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))

(prefer-coding-system 'utf-8-unix)
(setq-default indent-tabs-mode nil)

(setq make-backup-files nil)

(menu-bar-mode -1)

(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq initial-major-mode 'fundamental-mode)

(setq ring-bell-function 'ignore)

(global-set-key "\C-h" 'delete-backward-char)

(when window-system
  (tool-bar-mode -1)
  (set-scroll-bar-mode 'right)
  (global-set-key "\C-z" nil)
  (load-theme 'wombat))

(cond
 ((eq window-system 'x)
  (setq x-select-enable-clipboard t)
  (global-set-key "\C-y" 'x-clipboard-yank)
  (set-face-attribute 'default nil :family "Inconsolata")
  (set-fontset-font nil 'japanese-jisx0208
                    (font-spec :family "IPA P Gothic")))
 ((eq window-system 'w32)
  (cd "~/")
  (set-face-attribute 'default nil :height 120)
  (setq warning-minimum-level :error)
  (setq magit-git-executable "C:/Program Files (x86)/Git/bin/git.exe")))

(setq windmove-wrap-around t)
(windmove-default-keybindings)

(setq-default truncate-lines t)
(global-linum-mode t)
(column-number-mode t)
(show-paren-mode t)

(global-set-key "\C-xm" 'magit-status)
(setq magit-auto-revert-mode nil)

(global-set-key "\C-xa" 'helm-mini)
(eval-after-load "helm"
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)
     (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
     (custom-set-variables
      '(helm-mini-default-sources
        '(helm-source-buffers-list
          helm-source-recentf
          helm-source-files-in-current-dir
          helm-source-locate)))))

(global-whitespace-mode 1)
(eval-after-load "whitespace"
  '(progn
     (setq whitespace-style '(tab-mark face tabs trailing))))

(setq display-buffer-function 'popwin:display-buffer)
(eval-after-load "popwin"
  '(progn
     (push '("helm" :regexp t) popwin:special-display-config)
     (push '("compilation" :regexp t) popwin:special-display-config)))

(add-hook 'after-init-hook 'global-company-mode)

(global-set-key "\C-xe" 'helm-flycheck)

(when (locate-library "uim")
  (autoload 'uim-mode "uim" nil t)
  (global-set-key [zenkaku-hankaku] 'uim-mode)
  (eval-after-load "uim"
    '(progn
       (setq uim-default-im-prop '("action_skk_hiragana")))))

(defun find-cmakelist (path)
  (if path
      (let
          ((cmakefile (expand-file-name (concat path "/CMakeLists.txt")))
           (parent-dir (expand-file-name (concat path "/.."))))
        (if (file-exists-p cmakefile)
            cmakefile
          (if (string= parent-dir "/")
              nil
            (find-cmakelist parent-dir))))
    nil))

(defun cmake-build-dir (cmakelist)
  (concat "/tmp/cmake-build/" (substring (secure-hash 'sha256 cmakelist) 0 8)))

(defun cmake-build ()
  (interactive)
  (let ((cmakelist (find-cmakelist (file-name-directory buffer-file-name))))
    (if cmakelist
        (progn
          (make-directory (cmake-build-dir cmakelist) t)
          (compile
           (concat
            "cd " (cmake-build-dir cmakelist) " && "
            "cmake " (file-name-directory cmakelist) " && "
            "make")))
      (message "Cannot find CMakeLists.txt"))))

(add-hook 'c++-mode-hook
          (lambda ()
            (when (find-cmakelist (file-name-directory buffer-file-name))
              (local-set-key "\C-c\C-c" 'cmake-build))))

(when (file-exists-p "/usr/share/clang/clang-format.el")
  (load "/usr/share/clang/clang-format.el")
  (add-hook 'c++-mode-hook
            (lambda ()
              (add-hook 'before-save-hook 'clang-format-buffer nil t))))

(eval-after-load "company"
  '(progn
     (custom-set-variables
      '(company-clang-arguments
        '("-std=c++11")))))

(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook
          (lambda ()
            (setq flycheck-clang-language-standard "c++11")))

(defalias 'perl-mode 'cperl-mode)

(add-hook 'haskell-mode-hook 'haskell-indent-mode)

(defun make-scratch (&optional arg)
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
                (progn (make-scratch 0) nil)
              t)))
(add-hook 'after-save-hook
          (lambda ()
            (unless (member (get-buffer "*scratch*") (buffer-list))
              (make-scratch 1))))

(defun sudo-reopen ()
  "Reopen current buffer with sudo."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
        (find-alternate-file (concat "/sudo::" file-name))
      (error "Cannot get a file name."))))

