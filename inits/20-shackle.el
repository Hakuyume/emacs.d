(use-package shackle
  :custom (shackle-rules
           '(
             (compilation-mode :align below)
             ("^\*helm" :regexp t :align below)))
  :init (shackle-mode))
