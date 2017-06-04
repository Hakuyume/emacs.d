(defun qrencode (start end)
  (interactive "r")
  (progn
    (if (get-buffer "*qrencode*")
        (kill-buffer "*qrencode*"))
    (call-process-region start end "qrencode" nil "*qrencode*" nil "-tsvg")
    (switch-to-buffer-other-window "*qrencode*")
    (read-only-mode)
    (image-mode)))
