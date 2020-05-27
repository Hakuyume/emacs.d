(use-package pyvenv)

(use-package lsp-mode
  :hook
  (python-mode . (lambda ()
                   (if-let ((pyvenv-directory (find-pyvenv-directory (buffer-file-name))))
                       (pyvenv-activate pyvenv-directory))
                   (lsp))))

(use-package indent-guide
  :hook
  (python-mode . indent-guide-mode))

(defun find-pyvenv-directory (path)
  (cond
   ((not path) nil)
   ((file-regular-p path) (find-pyvenv-directory (file-name-directory path)))
   ((file-directory-p path)
    (or
     (seq-find
      (lambda (path) (file-regular-p (expand-file-name "pyvenv.cfg" path)))
      (directory-files path t))
     (let ((parent (file-name-directory (directory-file-name path))))
       (unless (equal parent path) (find-pyvenv-directory parent)))))))
