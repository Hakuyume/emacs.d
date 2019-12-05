(defun make-scratch ()
  (unless (get-buffer "*scratch*")
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)))

(add-hook 'after-save-hook 'make-scratch)
(add-hook 'kill-buffer-hook 'make-scratch)
