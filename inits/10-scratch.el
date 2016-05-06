(defun random-str (len)
  (substring
   (secure-hash 'sha512
                (concat (current-time-string) (number-to-string (random t))))
   0 len))
(defun prefer-extension (mode)
  (cdr (assoc mode
              '((emacs-lisp-mode . ".el")
                (haskell-mode . ".hs")
                (latex-mode . ".tex")
                (markdown-mode . ".md")
                (cperl-mode . ".pl")
                (python-mode . ".py")))))
(defun save-buffer-custom ()
  (interactive)
  (if (string= "*scratch*" (buffer-name))
      (write-file (concat "~/scratches/" (random-str 16) (prefer-extension major-mode)))
    (save-buffer)))
(global-set-key "\C-x\C-s" 'save-buffer-custom)

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
