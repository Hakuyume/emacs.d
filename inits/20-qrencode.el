(defun qrencode (start end)
  (interactive "r")
  (progn
    (if-let ((buffer (get-buffer "*qrencode*")))
        (kill-buffer buffer))
    (call-process-region start end "qrencode" nil "*qrencode*" nil "-tsvg")
    (switch-to-buffer-other-window "*qrencode*")
    (read-only-mode)
    (image-mode)))
