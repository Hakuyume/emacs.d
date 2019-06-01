(use-package jedi-core
  :config (add-to-list 'company-backends 'company-jedi)
  :custom
     (jedi:complete-on-dot t)
     (jedi:environment-virtualenv '("python" "-m" "venv"))
     :hook (python-mode . jedi:setup))

(use-package py-autopep8
  :hook ((python-mode . py-autopep8-enable-on-save)))

(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'indent-guide-mode)
