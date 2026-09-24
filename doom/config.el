;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; i want to use 12 font size, but for some fucking reason xwayland doesnt
;; want to scale properly.
(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 24)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 24))


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/dev/emacs/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq display-line-numbers-type 'relative)
(setq user-full-name "koftamainee"
      user-mail-address "dev@koftamainee.ru")

(use-package! protobuf-mode :mode "\\.proto\\'")

(after! eglot
  (map! :leader
        :desc "Toggle inlay hints"
        "t h" #'eglot-inlay-hints-mode))


(use-package! slang-mode
  :mode (("\\.slang\\'" . slang-mode)
         ("\\.sl\\'" . slang-mode)
         ("\\.slangh\\'" . slang-mode))
  :config
  (require 'slang-lsp)
  (slang-lsp-initialize))

(add-hook 'slang-mode-local-vars-hook #'lsp!)

(setq-default tab-width 4
              evil-shift-width 4)

(after! eglot
  (add-to-list 'eglot-server-programs
               '(cmake-mode . ("neocmakelsp" "stdio"))))


;; ts mode for cmake kinda sucks
(after! cmake-mode
  (setq auto-mode-alist
        (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                  ("\\.cmake\\'" . cmake-mode))
                auto-mode-alist)))

(after! eglot
  (set-eglot-client! '(python-mode python-ts-mode) '("pyright-langserver" "--stdio")))

;; Mantle stuff
(after! nerd-icons
  (add-to-list 'nerd-icons-extension-icon-alist
               '("mdl" nerd-icons-mdicon "nf-md-cube_scan" :face nerd-icons-orange))
  (add-to-list 'nerd-icons-mode-icon-alist
               '(mdl-mode nerd-icons-mdicon "nf-md-cube_scan" :face nerd-icons-orange))
  (add-to-list 'nerd-icons-mode-icon-alist
               '(mdl-ts-mode nerd-icons-mdicon "nf-md-cube_scan" :face nerd-icons-orange)))

;; use minted in latex for listings
(use-package! ox-latex
  :config
  (setq org-latex-src-block-backend 'minted
        org-latex-caption-above '(table src-block)
        org-latex-pdf-process
        '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

  (setq org-latex-classes
        (delq (assoc "article" org-latex-classes) org-latex-classes))
  (add-to-list 'org-latex-classes
               '("article" "\\documentclass[14pt]{extarticle}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(after! mwheel
  (pixel-scroll-precision-mode 1))

(setq citar-bibliography       '("~/dev/emacs/references.bib")
      citar-library-paths      '("~/dev/emacs/papers")
      citar-notes-paths        '("~/dev/emacs/notes")
      reftex-default-bibliography "~/dev/emacs/references.bib")

(map! :leader
      (:prefix ("n" . "notes")
               (:prefix ("b" . "bibliography")
                :desc "Lookup references online" "b" #'biblio-lookup
                :desc "Insert citation"          "c" #'citar-insert-citation
                :desc "Import by DOI"            "d" #'biblio-doi-insert-bibtex
                :desc "Open notes"               "n" #'citar-open-notes
                :desc "Open entry"               "o" #'citar-open
                :desc "Refresh bibliography"     "r" #'citar-refresh)))

(after! LaTeX-mode
  (map! :map LaTeX-mode-map
        :localleader
        :desc "Insert citation" "i c" #'citar-insert-citation))

(setq-default TeX-engine 'luatex)
