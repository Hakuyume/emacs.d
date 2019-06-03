(use-package lsp
  :custom (lsp-pyls-configuration-sources '("flake8"))
  :hook (python-mode . (lambda ()
                         (setq-local lsp-pyls-server-command (find-pyls (buffer-file-name)))
                         (lsp))))

(use-package indent-guide
  :hook (python-mode . indent-guide-mode))

(defun find-python-venv (path)
  (cond
   ((not path) nil)
   ((equal path "/") nil)
   ((file-regular-p path) (find-python-venv (file-name-directory path)))
   ((file-directory-p path)
    (or
     (seq-find
      (lambda (path) (file-regular-p (expand-file-name "pyvenv.cfg" path)))
      (directory-files path t))
     (find-python-venv (file-name-directory (directory-file-name path)))))))

(defun find-pyls (path)
  (cons
   (if-let ((venv (find-python-venv path)))
       (expand-file-name "python" (expand-file-name "bin" venv)) "python")
   '("-m" "pyls")))
