(setq rtags-display-result-backend 'helm)
(defvar helm-source-rtags
  '((name . "RTags")
    (candidates . (("display summary" . rtags-display-summary)
                   ("find symbol" . rtags-find-symbol)
                   ("find references" . rtags-find-references)))
    (action . command-execute)))
