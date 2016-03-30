(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(setq init-loader-show-log-after-init nil)
(init-loader-load)
