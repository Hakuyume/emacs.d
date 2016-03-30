(setq display-buffer-function 'popwin:display-buffer)
(eval-after-load "popwin"
  '(progn
     (push '("helm" :regexp t) popwin:special-display-config)
     (push '("compilation" :regexp t) popwin:special-display-config)))
