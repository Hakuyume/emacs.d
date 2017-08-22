(setq shackle-rules
      '(
        (compilation-mode :align below)
        ("^\*helm" :regexp t :align below)
        ("^\*reftex" :regexp t :align below)))
(shackle-mode)
