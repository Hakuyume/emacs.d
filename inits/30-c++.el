;; clang-fomat
;; cmake-ide
;; rtags

(require 'rtags)
(eval-after-load "rtags"
  '(progn
     (setq rtags-use-helm t)
     (defvar helm-source-rtags
       '((name . "RTags")
         (candidates . (("find symbol" . rtags-find-symbol-at-point)
                        ("find references" . rtags-find-references-at-point)))
         (action . command-execute)))
     (define-key c++-mode-map "\C-xr"
       (lambda () (interactive) (helm :sources helm-source-rtags)))))
(cmake-ide-setup)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'clang-format-buffer nil t)))
