(setq display-buffer-function 'popwin:display-buffer)
(eval-after-load "popwin"
  '(progn
     (push '("compilation" :regexp t) popwin:special-display-config)))
