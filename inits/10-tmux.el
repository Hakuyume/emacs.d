(defun tmux-environment () (interactive)
  (if-let (tmux (executable-find "tmux"))
      (dolist
          (line
           (split-string
            (with-output-to-string
              (call-process tmux nil standard-output nil "show-environment"))
            "\n"))
        (if-let ((index (string-match "=" line)))
            (setenv (substring line 0 index) (substring line (+ index 1)))))))
