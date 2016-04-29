(defun qrencode (start end)
  (interactive "r")
  (progn
    (if (get-buffer "*qrencode*")
        (kill-buffer "*qrencode*"))
    (call-process-region start end "qrencode" nil "*qrencode*" nil "-tUTF8")
    (switch-to-buffer-other-window "*qrencode*")
    (read-only-mode)
    (goto-char 0)))
(eval-after-load "popwin"
  '(progn
     (push '("*qrencode*" :regexp nil) popwin:special-display-config)))
