(use-package lsp
  :custom (lsp-pyls-configuration-sources '("flake8"))
  :hook (python-mode . (lambda ()
                         (let ((lsp-pyls-server-command (find-pyls (buffer-file-name)))) (lsp)))))

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
  (let ((venv (find-python-venv path)))
    (if venv
        (expand-file-name "pyls" (expand-file-name "bin" venv))
      "pyls")))
