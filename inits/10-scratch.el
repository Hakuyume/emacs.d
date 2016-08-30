(defun make-scratch ()
  (progn
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)))
(add-hook 'kill-buffer-query-functions
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (make-scratch) t)))
(add-hook 'after-save-hook
          (lambda ()
            (unless (member (get-buffer "*scratch*") (buffer-list))
              (make-scratch))))
