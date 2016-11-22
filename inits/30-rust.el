(add-hook 'rust-mode-hook 'racer-mode)
(eval-after-load "racer"
  '(progn
     (setq racer-rust-src-path "/usr/src/rust/src/")))
(add-hook 'racer-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'rust-format-buffer nil t)))
