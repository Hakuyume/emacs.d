(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))

(defvar helm-source-rtags
  '((name . "RTags")
    (candidates . (("display summary" . rtags-display-summary)
                   ("find symbol" . rtags-find-symbol-at-point)
                   ("find references" . rtags-find-references-at-point)))
    (action . command-execute)))
(eval-after-load "rtags"
  (progn
    (setq rtags-use-helm t)))
(cmake-ide-setup)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook
          (lambda ()
            (define-key c++-mode-map "\C-xr"
              (lambda () (interactive) (helm :sources helm-source-rtags)))
            (add-hook 'before-save-hook 'clang-format-buffer nil t)))
