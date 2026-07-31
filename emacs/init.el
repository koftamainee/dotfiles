(tool-bar-mode -1)
(menu-bar-mode -1)

(add-to-list 'load-path "~/.config/emacs/tokyodark.emacs")
(add-to-list 'custom-theme-load-path "~/.config/emacs/tokyodark.emacs/")
(load-theme 'tokyodark t)
