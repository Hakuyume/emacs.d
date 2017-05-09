(add-hook 'rust-mode-hook 'racer-mode)
(custom-set-variables
 '(rust-format-on-save t)
 '(rust-rustfmt-bin "~/.cargo/bin/rustfmt"))
