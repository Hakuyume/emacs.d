(require 'json)

(defvar-local cmake-project nil)
(defvar-local cmake-cmakelist nil)
(defvar-local cmake-build-dir nil)

(defun cmake-find-cmakelist (path)
  (if path
      (let
          ((cmakefile (expand-file-name "CMakeLists.txt" path))
           (parent-dir (expand-file-name ".." path)))
        (if (file-exists-p cmakefile)
            cmakefile
          (if (string= parent-dir "/")
              nil
            (cmake-find-cmakelist parent-dir))))
    nil))

(defun cmake-build ()
  (interactive)
  (when cmake-project
    (let ((default-directory cmake-build-dir))
      (compile "make"))))

(defun cmake-parse-compile-options (command)
  (mapcar (lambda (x) (concat "-" x))
          (cdr (split-string command " +-"))))

(defun cmake-filter-compile-options (options)
  (let ((case-fold-search nil))
    (delete nil
            (mapcar (lambda (x)
                      (when (string-match "^-std=\\|^-I\\|^-isystem\\|^-D" x)
                        (replace-regexp-in-string "^-isystem +" "-I" x))) options))))

(defun cmake-config-company (options)
  (progn
    (make-local-variable 'company-clang-arguments)
    (setq company-clang-arguments (cmake-filter-compile-options  options))))

(defun cmake-config-flycheck (options)
  (progn
    (make-local-variable 'flycheck-clang-args)
    (setq flycheck-clang-args (cmake-filter-compile-options options))))

(defun cmake-setup ()
  (interactive)
  (progn
    (setq cmake-cmakelist (cmake-find-cmakelist (file-name-directory buffer-file-name)))
    (if cmake-cmakelist
        (progn
          (setq cmake-project t)
          (setq cmake-build-dir (concat "/tmp/cmake-build/" (substring (secure-hash 'sha256 cmake-cmakelist) 0 8) "/"))
          (make-directory cmake-build-dir t)
          (let ((default-directory cmake-build-dir)
                (json-key-type 'string))
            (unless (and (file-exists-p "Makefile") (file-exists-p "compile_commands.json"))
              (message "Running cmake ...")
              (call-process "cmake" nil nil nil (file-name-directory cmake-cmakelist) "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON")
              (message "Done."))
            (let ((cmake-compile-options
                   (cmake-parse-compile-options (cdr (assoc "command" (elt (json-read-file "compile_commands.json") 0))))))
              (cmake-config-company cmake-compile-options)
              (cmake-config-flycheck cmake-compile-options)))
          (local-set-key "\C-c\C-c" 'cmake-build))
      (message "Cannot find CMakeLists.txt."))))
