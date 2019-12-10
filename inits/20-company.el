(use-package color)

(use-package company
  :bind
  ("M-<tab>" . company-complete)
  :config
  (progn
    (define-key company-active-map (kbd "C-h") nil)
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
    (when (color-name-to-rgb default-background)
      (custom-set-faces
       `(company-tooltip
         ((t (:inherit default :background ,(color-lighten-name default-background 2)))))
       `(company-scrollbar-bg
         ((t (:background ,(color-lighten-name default-background 10)))))
       `(company-scrollbar-fg
         ((t (:background ,(color-lighten-name default-background 5))))))))
  :custom-face
  (company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
  (company-tooltip-common ((t (:inherit font-lock-constant-face))))
  (company-tooltip-annotation ((t (:inherit font-lock-comment-face))))
  :hook
  (emacs-startup . global-company-mode))
