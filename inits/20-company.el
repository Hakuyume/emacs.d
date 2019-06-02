(use-package color)

(use-package company
  :bind ("M-<tab>" . company-complete)
  :config (let ((bg (face-attribute 'default :background)))
            (custom-set-faces
             `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
             '(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
             '(company-tooltip-common ((t (:inherit font-lock-constant-face))))
             '(company-tooltip-annotation ((t (:inherit font-lock-comment-face))))
             `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
             `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))))
  :hook (after-init . global-company-mode))
