(setq face-scale 0)
(defun set-face-height ()
  (set-face-attribute 'default nil :height (round (* 110 (expt 1.2 face-scale)))))
(set-face-height)

(global-set-key (kbd "C-0") (lambda () (interactive) (setq face-scale 0) (set-face-height)))
(global-set-key (kbd "C-+") (lambda () (interactive) (setq face-scale (+ face-scale 1)) (set-face-height)))
(global-set-key (kbd "C--") (lambda () (interactive) (setq face-scale (- face-scale 1)) (set-face-height)))
