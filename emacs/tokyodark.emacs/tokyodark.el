;;; tokyodark.el --- Tokyo Dark color theme -*- lexical-binding: t; -*-

;; Copyright (C) 2026

;; Author: koftamainee
;; URL: https://github.com/koftamainee/tokyodark.emacs
;; Version: 0.1.0
;; Package-Requires: ((emacs "27.1"))
;; Keywords: faces themes

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Tokyo Dark theme for Emacs, ported from eneriaa/tokyo-dark.nvim.
;; Provides a dark color scheme with carefully chosen contrast levels
;; and semantic color assignments.

;;; Code:

(require 'cl-lib)

(defgroup tokyodark nil
  "Tokyo Dark theme."
  :group 'faces
  :prefix "tokyodark-"
  :link '(url-link :tag "GitHub" "https://github.com/koftamainee/tokyodark.emacs")
  :tag "Tokyo Dark")

(defcustom tokyodark-scale-headings t
  "Whether to scale headings in org, outline, markdown, shr, and info.
Set to nil for uniform heading sizes.  Takes effect on theme load."
  :type 'boolean
  :group 'tokyodark)

(defcustom tokyodark-override-colors-alist '()
  "Alist of color overrides applied to the theme.
Each entry should be a cons cell (NAME . VALUE) where NAME is a
color name from the palette and VALUE is the replacement hex color string."
  :type '(alist :key-type string :value-type string)
  :group 'tokyodark)

;;; Color Palette

(defconst tokyodark-colors-alist
  '(;; Background shades
    ("tokyodark-black"       . "#06080A")
    ("tokyodark-bg"          . "#11121D")
    ("tokyodark-bg-dark"     . "#1A1B2A")
    ("tokyodark-bg-highlight". "#212234")
    ("tokyodark-bg5"         . "#282C34")
    ("tokyodark-selection"   . "#353945")
    ("tokyodark-grey"        . "#4A5057")

    ;; Foreground
    ("tokyodark-fg"          . "#A0A8CD")

    ;; Accent colors
    ("tokyodark-red"         . "#EE6D85")
    ("tokyodark-red-light"   . "#FE6D85")
    ("tokyodark-orange"      . "#F6955B")
    ("tokyodark-yellow"      . "#D7A65F")
    ("tokyodark-green"       . "#95C561")
    ("tokyodark-green-light" . "#98C379")
    ("tokyodark-blue"        . "#7199EE")
    ("tokyodark-blue-light"  . "#9FBBF3")
    ("tokyodark-cyan"        . "#38A89D")
    ("tokyodark-purple"      . "#A485DD")

    ;; Diff colors
    ("tokyodark-diff-red"    . "#773440")
    ("tokyodark-diff-green"  . "#587738")
    ("tokyodark-diff-blue"   . "#2A3A5A")
    ("tokyodark-diff-add"    . "#1E2326")
    ("tokyodark-diff-change" . "#262B3D")
    ("tokyodark-diff-delete" . "#281B27")
    ("tokyodark-diff-text"   . "#1C4474")

    ;; Git / VC
    ("tokyodark-git-add"     . "#95C561")
    ("tokyodark-git-change"  . "#7199EE")
    ("tokyodark-git-delete"  . "#EE6D85")

    ;; Headings
    ("tokyodark-heading1"    . "#EE6D85")
    ("tokyodark-heading2"    . "#F6955B")
    ("tokyodark-heading3"    . "#D7A65F")
    ("tokyodark-heading4"    . "#95C561")
    ("tokyodark-heading5"    . "#7199EE")
    ("tokyodark-heading6"    . "#A485DD"))
  "The Tokyo Dark color palette.")

;;; Face Application

(defun tokyodark--apply-theme (theme-name colors-alist)
  "Apply the Tokyo Dark face definitions to THEME-NAME using COLORS-ALIST."
  (let* ((merged (append tokyodark-override-colors-alist colors-alist))
         (class '((class color) (min-colors 88))))
    (cl-flet ((c (name) (cdr (assoc name merged))))
      (let ((tokyodark-black         (c "tokyodark-black"))
            (tokyodark-bg            (c "tokyodark-bg"))
            (tokyodark-bg-dark       (c "tokyodark-bg-dark"))
            (tokyodark-bg-highlight  (c "tokyodark-bg-highlight"))
            (tokyodark-bg5           (c "tokyodark-bg5"))
            (tokyodark-selection     (c "tokyodark-selection"))
            (tokyodark-grey          (c "tokyodark-grey"))
            (tokyodark-fg            (c "tokyodark-fg"))
            (tokyodark-red           (c "tokyodark-red"))
            (tokyodark-red-light     (c "tokyodark-red-light"))
            (tokyodark-orange        (c "tokyodark-orange"))
            (tokyodark-yellow        (c "tokyodark-yellow"))
            (tokyodark-green         (c "tokyodark-green"))
            (tokyodark-green-light   (c "tokyodark-green-light"))
            (tokyodark-blue          (c "tokyodark-blue"))
            (tokyodark-blue-light    (c "tokyodark-blue-light"))
            (tokyodark-cyan          (c "tokyodark-cyan"))
            (tokyodark-purple        (c "tokyodark-purple"))
            (tokyodark-diff-red      (c "tokyodark-diff-red"))
            (tokyodark-diff-green    (c "tokyodark-diff-green"))
            (tokyodark-diff-blue     (c "tokyodark-diff-blue"))
            (tokyodark-diff-add      (c "tokyodark-diff-add"))
            (tokyodark-diff-change   (c "tokyodark-diff-change"))
            (tokyodark-diff-delete   (c "tokyodark-diff-delete"))
            (tokyodark-diff-text     (c "tokyodark-diff-text"))
            (tokyodark-git-add       (c "tokyodark-git-add"))
            (tokyodark-git-change    (c "tokyodark-git-change"))
            (tokyodark-git-delete    (c "tokyodark-git-delete"))
            (tokyodark-heading1      (c "tokyodark-heading1"))
            (tokyodark-heading2      (c "tokyodark-heading2"))
            (tokyodark-heading3      (c "tokyodark-heading3"))
            (tokyodark-heading4      (c "tokyodark-heading4"))
            (tokyodark-heading5      (c "tokyodark-heading5"))
            (tokyodark-heading6      (c "tokyodark-heading6"))
            (h1 (if tokyodark-scale-headings 1.3 1.0))
            (h2 (if tokyodark-scale-headings 1.2 1.0))
            (h3 (if tokyodark-scale-headings 1.1 1.0))
            (h-doc (if tokyodark-scale-headings 1.4 1.0)))

        (custom-theme-set-faces
         theme-name

;;;;; basic coloring
         `(default ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg))))
         `(cursor ((,class (:foreground ,tokyodark-bg :background ,tokyodark-fg))))
         `(fringe ((,class (:background ,tokyodark-bg :foreground ,tokyodark-grey))))
         `(header-line ((,class (:background ,tokyodark-bg-dark :foreground ,tokyodark-fg))))
         `(highlight ((,class (:background ,tokyodark-bg-highlight))))
         `(success ((,class (:foreground ,tokyodark-green :weight bold))))
         `(warning ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(error ((,class (:foreground ,tokyodark-red :weight bold))))
         `(link ((,class (:foreground ,tokyodark-cyan :underline t))))
         `(link-visited ((,class (:foreground ,tokyodark-purple :underline t))))
         `(button ((,class (:foreground ,tokyodark-cyan :underline t))))
         `(minibuffer-prompt ((,class (:foreground ,tokyodark-blue))))
         `(escape-glyph ((,class (:foreground ,tokyodark-purple))))
         `(homoglyph ((,class (:foreground ,tokyodark-purple))))
         `(tooltip ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-dark))))
         `(menu ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-dark))))
         `(shadow ((,class (:foreground ,tokyodark-grey))))
         `(region ((,class (:background ,tokyodark-selection :extend t))))
         `(secondary-selection ((,class (:background ,tokyodark-bg-highlight :extend t))))
         `(trailing-whitespace ((,class (:background ,tokyodark-red))))
         `(vertical-border ((,class (:foreground ,tokyodark-bg5))))
         `(window-divider ((,class (:foreground ,tokyodark-bg5))))
         `(window-divider-first-pixel ((,class (:foreground ,tokyodark-bg5))))
         `(window-divider-last-pixel ((,class (:foreground ,tokyodark-bg5))))
         `(widget-field ((,class (:background ,tokyodark-bg-highlight :extend t))))

;;;;; fill-column-indicator
         `(fill-column-indicator ((,class (:foreground ,tokyodark-bg-highlight :weight normal))))

;;;;; mode-line
         `(mode-line ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-dark
                                           :box (:line-width -1 :color ,tokyodark-bg5)))))
         `(mode-line-inactive ((,class (:foreground ,tokyodark-grey :background ,tokyodark-black
                                                    :box (:line-width -1 :color ,tokyodark-bg-dark)))))
         `(mode-line-buffer-id ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(mode-line-emphasis ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(mode-line-highlight ((,class (:foreground ,tokyodark-purple))))

;;;;; ansi-colors
         `(ansi-color-black ((,class (:foreground ,tokyodark-bg-dark :background ,tokyodark-bg-dark))))
         `(ansi-color-red ((,class (:foreground ,tokyodark-red :background ,tokyodark-red))))
         `(ansi-color-green ((,class (:foreground ,tokyodark-green :background ,tokyodark-green))))
         `(ansi-color-yellow ((,class (:foreground ,tokyodark-yellow :background ,tokyodark-yellow))))
         `(ansi-color-blue ((,class (:foreground ,tokyodark-blue :background ,tokyodark-blue))))
         `(ansi-color-magenta ((,class (:foreground ,tokyodark-purple :background ,tokyodark-purple))))
         `(ansi-color-cyan ((,class (:foreground ,tokyodark-cyan :background ,tokyodark-cyan))))
         `(ansi-color-white ((,class (:foreground ,tokyodark-fg :background ,tokyodark-fg))))
         `(ansi-color-bright-black ((,class (:foreground ,tokyodark-grey :background ,tokyodark-grey))))
         `(ansi-color-bright-red ((,class (:foreground ,tokyodark-red-light :background ,tokyodark-red-light))))
         `(ansi-color-bright-green ((,class (:foreground ,tokyodark-green-light :background ,tokyodark-green-light))))
         `(ansi-color-bright-yellow ((,class (:foreground ,tokyodark-yellow :background ,tokyodark-yellow))))
         `(ansi-color-bright-blue ((,class (:foreground ,tokyodark-blue-light :background ,tokyodark-blue-light))))
         `(ansi-color-bright-magenta ((,class (:foreground ,tokyodark-purple :background ,tokyodark-purple))))
         `(ansi-color-bright-cyan ((,class (:foreground ,tokyodark-cyan :background ,tokyodark-cyan))))
         `(ansi-color-bright-white ((,class (:foreground ,tokyodark-fg :background ,tokyodark-fg))))

;;;;; font-lock
         `(font-lock-builtin-face ((,class (:foreground ,tokyodark-blue))))
         `(font-lock-comment-face ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(font-lock-comment-delimiter-face ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(font-lock-constant-face ((,class (:foreground ,tokyodark-orange))))
         `(font-lock-doc-face ((,class (:foreground ,tokyodark-grey))))
         `(font-lock-doc-markup-face ((,class (:foreground ,tokyodark-grey))))
         `(font-lock-function-name-face ((,class (:foreground ,tokyodark-green))))
         `(font-lock-function-call-face ((,class (:foreground ,tokyodark-green))))
         `(font-lock-keyword-face ((,class (:foreground ,tokyodark-red))))
         `(font-lock-negation-char-face ((,class (:foreground ,tokyodark-purple))))
         `(font-lock-number-face ((,class (:foreground ,tokyodark-orange))))
         `(font-lock-operator-face ((,class (:foreground ,tokyodark-red))))
         `(font-lock-preprocessor-face ((,class (:foreground ,tokyodark-cyan))))
         `(font-lock-regexp-grouping-construct ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(font-lock-regexp-grouping-backslash ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(font-lock-string-face ((,class (:foreground ,tokyodark-yellow))))
         `(font-lock-type-face ((,class (:foreground ,tokyodark-blue))))
         `(font-lock-variable-name-face ((,class (:foreground ,tokyodark-fg))))
         `(font-lock-variable-use-face ((,class (:foreground ,tokyodark-fg))))
         `(font-lock-warning-face ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(font-lock-property-name-face ((,class (:foreground ,tokyodark-cyan))))
         `(font-lock-property-use-face ((,class (:foreground ,tokyodark-cyan))))
         `(font-lock-bracket-face ((,class (:foreground ,tokyodark-fg))))
         `(font-lock-delimiter-face ((,class (:foreground ,tokyodark-fg))))
         `(font-lock-escape-face ((,class (:foreground ,tokyodark-purple))))
         `(font-lock-misc-punctuation-face ((,class (:foreground ,tokyodark-fg))))

;;;;; line numbers
         `(line-number ((,class (:foreground ,tokyodark-grey :background ,tokyodark-bg))))
         `(line-number-current-line ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg :weight bold))))
         `(line-number-major-tick ((,class (:foreground ,tokyodark-grey :background ,tokyodark-bg))))
         `(line-number-minor-tick ((,class (:foreground ,tokyodark-grey :background ,tokyodark-bg))))

;;;;; isearch / replace
         `(isearch ((,class (:foreground ,tokyodark-bg :background ,tokyodark-red :weight bold))))
         `(isearch-fail ((,class (:foreground ,tokyodark-red :background ,tokyodark-bg-highlight))))
         `(isearch-group-1 ((,class (:foreground ,tokyodark-bg :background ,tokyodark-blue))))
         `(isearch-group-2 ((,class (:foreground ,tokyodark-bg :background ,tokyodark-cyan))))
         `(lazy-highlight ((,class (:foreground ,tokyodark-fg :background ,tokyodark-selection))))
         `(match ((,class (:foreground ,tokyodark-green :background ,tokyodark-bg :weight bold))))
         `(query-replace ((,class (:foreground ,tokyodark-bg :background ,tokyodark-orange :weight bold))))

;;;;; show-paren
         `(show-paren-match ((,class (:foreground ,tokyodark-purple :background ,tokyodark-bg-highlight :weight bold))))
         `(show-paren-match-expression ((,class (:background ,tokyodark-bg-highlight))))
         `(show-paren-mismatch ((,class (:foreground ,tokyodark-red :background ,tokyodark-bg-highlight :weight bold :underline t))))

;;;;; completions
         `(completions-annotations ((,class (:foreground ,tokyodark-grey))))
         `(completions-common-part ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(completions-first-difference ((,class (:foreground ,tokyodark-orange))))
         `(completions-highlight ((,class (:background ,tokyodark-bg-highlight))))
         `(completions-group-title ((,class (:foreground ,tokyodark-purple :weight bold :slant italic))))
         `(completions-group-separator ((,class (:foreground ,tokyodark-grey :strike-through t))))

;;;;; compilation
         `(compilation-error ((,class (:foreground ,tokyodark-red :weight bold))))
         `(compilation-warning ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(compilation-info ((,class (:foreground ,tokyodark-cyan))))
         `(compilation-mode-line-exit ((,class (:foreground ,tokyodark-green :weight bold))))
         `(compilation-mode-line-fail ((,class (:foreground ,tokyodark-red :weight bold))))
         `(compilation-mode-line-run ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(compilation-line-number ((,class (:foreground ,tokyodark-grey))))
         `(compilation-column-number ((,class (:foreground ,tokyodark-grey))))

;;;;; customize
         `(custom-variable-tag ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(custom-group-tag ((,class (:foreground ,tokyodark-blue :weight bold :height 1.2))))
         `(custom-group-tag-1 ((,class (:foreground ,tokyodark-purple :weight bold :height 1.2))))
         `(custom-state ((,class (:foreground ,tokyodark-green))))
         `(custom-button ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-highlight
                                               :box (:line-width 2 :color ,tokyodark-bg5 :style released-button)))))
         `(custom-button-mouse ((,class (:foreground ,tokyodark-fg :background ,tokyodark-selection
                                                     :box (:line-width 2 :color ,tokyodark-bg5 :style released-button)))))
         `(custom-button-pressed ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-highlight
                                                       :box (:line-width 2 :color ,tokyodark-bg5 :style pressed-button)))))

;;;;; diff
         `(diff-added ((,class (:foreground ,tokyodark-git-add :background ,tokyodark-diff-add :extend t))))
         `(diff-removed ((,class (:foreground ,tokyodark-git-delete :background ,tokyodark-diff-delete :extend t))))
         `(diff-changed ((,class (:foreground ,tokyodark-git-change :background ,tokyodark-diff-change :extend t))))
         `(diff-refine-added ((,class (:foreground ,tokyodark-green :background ,tokyodark-diff-add :weight bold :extend t))))
         `(diff-refine-removed ((,class (:foreground ,tokyodark-red :background ,tokyodark-diff-delete :weight bold :extend t))))
         `(diff-refine-changed ((,class (:foreground ,tokyodark-blue :background ,tokyodark-diff-change :weight bold :extend t))))
         `(diff-header ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-dark :extend t))))
         `(diff-file-header ((,class (:foreground ,tokyodark-blue :background ,tokyodark-bg-dark :weight bold :extend t))))
         `(diff-hunk-header ((,class (:foreground ,tokyodark-purple :background ,tokyodark-bg-dark :extend t))))
         `(diff-indicator-added ((,class (:foreground ,tokyodark-git-add))))
         `(diff-indicator-removed ((,class (:foreground ,tokyodark-git-delete))))
         `(diff-indicator-changed ((,class (:foreground ,tokyodark-git-change))))
         `(diff-nonexistent ((,class (:foreground ,tokyodark-grey))))

;;;;; dired
         `(dired-directory ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(dired-flagged ((,class (:foreground ,tokyodark-red))))
         `(dired-header ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(dired-ignored ((,class (:foreground ,tokyodark-grey))))
         `(dired-mark ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(dired-marked ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(dired-perm-write ((,class (:foreground ,tokyodark-fg))))
         `(dired-symlink ((,class (:foreground ,tokyodark-cyan))))
         `(dired-warning ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(dired-broken-symlink ((,class (:foreground ,tokyodark-red :weight bold))))

;;;;; ediff
         `(ediff-current-diff-A ((,class (:background ,tokyodark-diff-delete :extend t))))
         `(ediff-current-diff-B ((,class (:background ,tokyodark-diff-add :extend t))))
         `(ediff-current-diff-C ((,class (:background ,tokyodark-diff-change :extend t))))
         `(ediff-fine-diff-A ((,class (:foreground ,tokyodark-red :background ,tokyodark-diff-delete :weight bold :extend t))))
         `(ediff-fine-diff-B ((,class (:foreground ,tokyodark-green :background ,tokyodark-diff-add :weight bold :extend t))))
         `(ediff-fine-diff-C ((,class (:foreground ,tokyodark-blue :background ,tokyodark-diff-change :weight bold :extend t))))
         `(ediff-even-diff-A ((,class (:background ,tokyodark-bg-highlight :extend t))))
         `(ediff-even-diff-B ((,class (:background ,tokyodark-bg-highlight :extend t))))
         `(ediff-even-diff-C ((,class (:background ,tokyodark-bg-highlight :extend t))))
         `(ediff-odd-diff-A ((,class (:background ,tokyodark-bg-highlight :extend t))))
         `(ediff-odd-diff-B ((,class (:background ,tokyodark-bg-highlight :extend t))))
         `(ediff-odd-diff-C ((,class (:background ,tokyodark-bg-highlight :extend t))))

;;;;; eshell
         `(eshell-prompt ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(eshell-ls-archive ((,class (:foreground ,tokyodark-purple))))
         `(eshell-ls-backup ((,class (:foreground ,tokyodark-grey))))
         `(eshell-ls-clutter ((,class (:foreground ,tokyodark-grey))))
         `(eshell-ls-directory ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(eshell-ls-executable ((,class (:foreground ,tokyodark-green))))
         `(eshell-ls-missing ((,class (:foreground ,tokyodark-red))))
         `(eshell-ls-product ((,class (:foreground ,tokyodark-fg))))
         `(eshell-ls-readonly ((,class (:foreground ,tokyodark-grey))))
         `(eshell-ls-special ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(eshell-ls-symlink ((,class (:foreground ,tokyodark-cyan))))
         `(eshell-ls-unreadable ((,class (:foreground ,tokyodark-grey))))

;;;;; erc
         `(erc-action-face ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(erc-bold-face ((,class (:weight bold))))
         `(erc-current-nick-face ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(erc-default-face ((,class (:foreground ,tokyodark-fg))))
         `(erc-direct-msg-face ((,class (:foreground ,tokyodark-orange))))
         `(erc-error-face ((,class (:foreground ,tokyodark-red :weight bold))))
         `(erc-fool-face ((,class (:foreground ,tokyodark-grey))))
         `(erc-highlight-face ((,class (:background ,tokyodark-bg-highlight))))
         `(erc-input-face ((,class (:foreground ,tokyodark-fg))))
         `(erc-keyword-face ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(erc-my-nick-face ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(erc-nick-default-face ((,class (:foreground ,tokyodark-cyan :weight bold))))
         `(erc-nick-msg-face ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(erc-notice-face ((,class (:foreground ,tokyodark-grey))))
         `(erc-pal-face ((,class (:foreground ,tokyodark-green :weight bold))))
         `(erc-prompt-face ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(erc-timestamp-face ((,class (:foreground ,tokyodark-grey))))
         `(erc-underline-face ((,class (:underline t))))

;;;;; flymake
         `(flymake-error ((,class (:underline (:style wave :color ,tokyodark-red)))))
         `(flymake-warning ((,class (:underline (:style wave :color ,tokyodark-yellow)))))
         `(flymake-note ((,class (:underline (:style wave :color ,tokyodark-cyan)))))

;;;;; flyspell
         `(flyspell-duplicate ((,class (:underline (:style wave :color ,tokyodark-yellow)))))
         `(flyspell-incorrect ((,class (:underline (:style wave :color ,tokyodark-red)))))

;;;;; gnus
         `(gnus-group-mail-1 ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(gnus-group-mail-1-empty ((,class (:foreground ,tokyodark-blue))))
         `(gnus-group-mail-2 ((,class (:foreground ,tokyodark-cyan :weight bold))))
         `(gnus-group-mail-2-empty ((,class (:foreground ,tokyodark-cyan))))
         `(gnus-group-mail-3 ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(gnus-group-mail-3-empty ((,class (:foreground ,tokyodark-purple))))
         `(gnus-group-mail-low ((,class (:foreground ,tokyodark-grey :weight bold))))
         `(gnus-group-mail-low-empty ((,class (:foreground ,tokyodark-grey))))
         `(gnus-group-news-1 ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(gnus-group-news-1-empty ((,class (:foreground ,tokyodark-blue))))
         `(gnus-group-news-2 ((,class (:foreground ,tokyodark-cyan :weight bold))))
         `(gnus-group-news-2-empty ((,class (:foreground ,tokyodark-cyan))))
         `(gnus-group-news-low ((,class (:foreground ,tokyodark-grey :weight bold))))
         `(gnus-group-news-low-empty ((,class (:foreground ,tokyodark-grey))))
         `(gnus-header-content ((,class (:foreground ,tokyodark-fg))))
         `(gnus-header-from ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(gnus-header-name ((,class (:foreground ,tokyodark-purple))))
         `(gnus-header-newsgroups ((,class (:foreground ,tokyodark-cyan :weight bold))))
         `(gnus-header-subject ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(gnus-summary-cancelled ((,class (:foreground ,tokyodark-red :background ,tokyodark-bg))))
         `(gnus-summary-normal-ancient ((,class (:foreground ,tokyodark-grey))))
         `(gnus-summary-normal-read ((,class (:foreground ,tokyodark-grey))))
         `(gnus-summary-normal-ticked ((,class (:foreground ,tokyodark-fg :slant italic))))
         `(gnus-summary-normal-unread ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(gnus-summary-selected ((,class (:foreground ,tokyodark-blue :weight bold :underline t))))

;;;;; grep
         `(grep-context-face ((,class (:foreground ,tokyodark-fg))))
         `(grep-error-face ((,class (:foreground ,tokyodark-red :weight bold :underline t))))
         `(grep-hit-face ((,class (:foreground ,tokyodark-blue))))
         `(grep-match-face ((,class (:foreground ,tokyodark-orange :weight bold))))

;;;;; hi-lock
         `(hi-blue ((,class (:foreground ,tokyodark-bg :background ,tokyodark-blue))))
         `(hi-green ((,class (:foreground ,tokyodark-bg :background ,tokyodark-green))))
         `(hi-pink ((,class (:foreground ,tokyodark-bg :background ,tokyodark-purple))))
         `(hi-yellow ((,class (:foreground ,tokyodark-bg :background ,tokyodark-yellow))))
         `(hi-blue-b ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(hi-green-b ((,class (:foreground ,tokyodark-green :weight bold))))
         `(hi-red-b ((,class (:foreground ,tokyodark-red :weight bold))))

;;;;; hl-line
         `(hl-line ((,class (:background ,tokyodark-bg-dark :extend t))))

;;;;; hl-todo
         `(hl-todo ((,class (:foreground ,tokyodark-purple :weight bold))))

;;;;; icomplete
         `(icomplete-first-match ((,class (:foreground ,tokyodark-green :weight bold))))
         `(icomplete-selected-match ((,class (:background ,tokyodark-bg-highlight))))

;;;;; ido
         `(ido-first-match ((,class (:foreground ,tokyodark-green :weight bold))))
         `(ido-only-match ((,class (:foreground ,tokyodark-cyan :weight bold))))
         `(ido-subdir ((,class (:foreground ,tokyodark-blue))))
         `(ido-incomplete-regexp ((,class (:foreground ,tokyodark-red))))
         `(ido-indicator ((,class (:foreground ,tokyodark-yellow :background ,tokyodark-bg))))
         `(ido-virtual ((,class (:foreground ,tokyodark-grey))))

;;;;; info
         `(Info-quoted ((,class (:foreground ,tokyodark-orange :inherit fixed-pitch-serif))))
         `(info-header-node ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(info-header-xref ((,class (:foreground ,tokyodark-cyan))))
         `(info-menu-header ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(info-menu-star ((,class (:foreground ,tokyodark-red))))
         `(info-node ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(info-title-1 ((,class (:foreground ,tokyodark-heading1 :weight bold :height ,h1))))
         `(info-title-2 ((,class (:foreground ,tokyodark-heading2 :weight bold :height ,h2))))
         `(info-title-3 ((,class (:foreground ,tokyodark-heading3 :weight bold :height ,h3))))
         `(info-title-4 ((,class (:foreground ,tokyodark-heading4 :weight bold))))
         `(info-xref ((,class (:foreground ,tokyodark-cyan :underline t))))
         `(info-xref-visited ((,class (:foreground ,tokyodark-purple :underline t))))

;;;;; message
         `(message-cited-text-1 ((,class (:foreground ,tokyodark-cyan))))
         `(message-cited-text-2 ((,class (:foreground ,tokyodark-green))))
         `(message-cited-text-3 ((,class (:foreground ,tokyodark-grey))))
         `(message-cited-text-4 ((,class (:foreground ,tokyodark-grey))))
         `(message-header-cc ((,class (:foreground ,tokyodark-blue))))
         `(message-header-name ((,class (:foreground ,tokyodark-purple))))
         `(message-header-newsgroups ((,class (:foreground ,tokyodark-cyan :weight bold))))
         `(message-header-other ((,class (:foreground ,tokyodark-fg))))
         `(message-header-subject ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(message-header-to ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(message-header-xheader ((,class (:foreground ,tokyodark-grey))))
         `(message-mml ((,class (:foreground ,tokyodark-green))))
         `(message-separator ((,class (:foreground ,tokyodark-grey))))

;;;;; org-mode
         `(org-archived ((,class (:foreground ,tokyodark-grey))))
         `(org-block ((,class (:background ,tokyodark-bg-dark :extend t))))
         `(org-block-begin-line ((,class (:foreground ,tokyodark-grey :background ,tokyodark-bg-dark :extend t :slant italic))))
         `(org-block-end-line ((,class (:inherit org-block-begin-line))))
         `(org-checkbox ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(org-checkbox-statistics-done ((,class (:foreground ,tokyodark-green))))
         `(org-checkbox-statistics-todo ((,class (:foreground ,tokyodark-orange))))
         `(org-code ((,class (:foreground ,tokyodark-cyan))))
         `(org-date ((,class (:foreground ,tokyodark-blue :underline t))))
         `(org-document-info ((,class (:foreground ,tokyodark-fg))))
         `(org-document-info-keyword ((,class (:foreground ,tokyodark-grey))))
         `(org-document-title ((,class (:foreground ,tokyodark-fg :weight bold :height ,h-doc))))
         `(org-done ((,class (:foreground ,tokyodark-green :weight bold))))
         `(org-drawer ((,class (:foreground ,tokyodark-grey))))
         `(org-ellipsis ((,class (:foreground ,tokyodark-grey :underline nil))))
         `(org-footnote ((,class (:foreground ,tokyodark-cyan))))
         `(org-formula ((,class (:foreground ,tokyodark-orange))))
         `(org-headline-done ((,class (:foreground ,tokyodark-grey))))
         `(org-hide ((,class (:foreground ,tokyodark-bg))))
         `(org-level-1 ((,class (:inherit outline-1))))
         `(org-level-2 ((,class (:inherit outline-2))))
         `(org-level-3 ((,class (:inherit outline-3))))
         `(org-level-4 ((,class (:inherit outline-4))))
         `(org-level-5 ((,class (:inherit outline-5))))
         `(org-level-6 ((,class (:inherit outline-6))))
         `(org-level-7 ((,class (:inherit outline-7))))
         `(org-level-8 ((,class (:inherit outline-8))))
         `(org-link ((,class (:foreground ,tokyodark-cyan :underline t))))
         `(org-meta-line ((,class (:foreground ,tokyodark-grey))))
         `(org-priority ((,class (:foreground ,tokyodark-orange))))
         `(org-property-value ((,class (:foreground ,tokyodark-fg))))
         `(org-quote ((,class (:foreground ,tokyodark-fg :slant italic :extend t))))
         `(org-scheduled ((,class (:foreground ,tokyodark-green))))
         `(org-scheduled-previously ((,class (:foreground ,tokyodark-orange))))
         `(org-scheduled-today ((,class (:foreground ,tokyodark-green))))
         `(org-special-keyword ((,class (:foreground ,tokyodark-grey))))
         `(org-table ((,class (:foreground ,tokyodark-fg))))
         `(org-tag ((,class (:foreground ,tokyodark-grey :weight normal))))
         `(org-target ((,class (:underline t))))
         `(org-time-grid ((,class (:foreground ,tokyodark-grey))))
         `(org-todo ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(org-upcoming-deadline ((,class (:foreground ,tokyodark-red))))
         `(org-verbatim ((,class (:foreground ,tokyodark-green))))
         `(org-verse ((,class (:inherit org-quote))))
         `(org-warning ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(org-agenda-date ((,class (:foreground ,tokyodark-blue))))
         `(org-agenda-date-today ((,class (:foreground ,tokyodark-blue :weight bold :slant italic))))
         `(org-agenda-date-weekend ((,class (:foreground ,tokyodark-grey))))
         `(org-agenda-date-weekend-today ((,class (:foreground ,tokyodark-grey :weight bold))))
         `(org-agenda-done ((,class (:foreground ,tokyodark-green))))
         `(org-agenda-structure ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(org-agenda-current-time ((,class (:foreground ,tokyodark-cyan))))

;;;;; outline
         `(outline-1 ((,class (:foreground ,tokyodark-heading1 :weight bold :height ,h1))))
         `(outline-2 ((,class (:foreground ,tokyodark-heading2 :weight bold :height ,h2))))
         `(outline-3 ((,class (:foreground ,tokyodark-heading3 :weight bold :height ,h3))))
         `(outline-4 ((,class (:foreground ,tokyodark-heading4 :weight bold))))
         `(outline-5 ((,class (:foreground ,tokyodark-heading5 :weight bold))))
         `(outline-6 ((,class (:foreground ,tokyodark-heading6 :weight bold))))
         `(outline-7 ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(outline-8 ((,class (:foreground ,tokyodark-grey :weight bold))))

;;;;; re-builder
         `(reb-match-0 ((,class (:foreground ,tokyodark-bg :background ,tokyodark-blue))))
         `(reb-match-1 ((,class (:foreground ,tokyodark-bg :background ,tokyodark-cyan))))
         `(reb-match-2 ((,class (:foreground ,tokyodark-bg :background ,tokyodark-purple))))
         `(reb-match-3 ((,class (:foreground ,tokyodark-bg :background ,tokyodark-orange))))

;;;;; ruler-mode
         `(ruler-mode-default ((,class (:foreground ,tokyodark-grey :background ,tokyodark-bg-dark))))
         `(ruler-mode-column-number ((,class (:foreground ,tokyodark-fg))))
         `(ruler-mode-current-column ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(ruler-mode-fill-column ((,class (:foreground ,tokyodark-red))))

;;;;; sh-mode
         `(sh-heredoc ((,class (:foreground ,tokyodark-green :slant italic))))
         `(sh-quoted-exec ((,class (:foreground ,tokyodark-orange))))

;;;;; shr
         `(shr-h1 ((,class (:foreground ,tokyodark-heading1 :weight bold :height ,h1))))
         `(shr-h2 ((,class (:foreground ,tokyodark-heading2 :weight bold :height ,h2))))
         `(shr-h3 ((,class (:foreground ,tokyodark-heading3 :weight bold :height ,h3))))
         `(shr-h4 ((,class (:foreground ,tokyodark-heading4 :weight bold))))
         `(shr-h5 ((,class (:foreground ,tokyodark-heading5 :weight bold))))
         `(shr-h6 ((,class (:foreground ,tokyodark-heading6 :weight bold))))
         `(shr-link ((,class (:foreground ,tokyodark-cyan :underline t))))
         `(shr-selected-link ((,class (:foreground ,tokyodark-orange :underline t))))
         `(shr-code ((,class (:foreground ,tokyodark-cyan :background ,tokyodark-bg-dark))))
         `(shr-mark ((,class (:foreground ,tokyodark-bg :background ,tokyodark-yellow))))

;;;;; tab-bar / tab-line
         `(tab-bar ((,class (:foreground ,tokyodark-fg :background ,tokyodark-black))))
         `(tab-bar-tab ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg :weight bold))))
         `(tab-bar-tab-inactive ((,class (:foreground ,tokyodark-grey :background ,tokyodark-bg-dark))))
         `(tab-bar-tab-ungrouped ((,class (:foreground ,tokyodark-grey :background ,tokyodark-bg-dark))))
         `(tab-bar-tab-group-current ((,class (:foreground ,tokyodark-blue :background ,tokyodark-bg :weight bold))))
         `(tab-bar-tab-group-inactive ((,class (:foreground ,tokyodark-grey :background ,tokyodark-bg-dark))))
         `(tab-line ((,class (:foreground ,tokyodark-fg :background ,tokyodark-black))))
         `(tab-line-tab ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg :weight bold))))
         `(tab-line-tab-current ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg :weight bold))))
         `(tab-line-tab-inactive ((,class (:foreground ,tokyodark-grey :background ,tokyodark-bg-dark))))
         `(tab-line-highlight ((,class (:background ,tokyodark-bg-highlight))))

;;;;; term / ansi-term / vterm
         `(term ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg))))
         `(term-color-black ((,class (:foreground ,tokyodark-bg-dark :background ,tokyodark-bg-dark))))
         `(term-color-red ((,class (:foreground ,tokyodark-red :background ,tokyodark-red))))
         `(term-color-green ((,class (:foreground ,tokyodark-green :background ,tokyodark-green))))
         `(term-color-yellow ((,class (:foreground ,tokyodark-yellow :background ,tokyodark-yellow))))
         `(term-color-blue ((,class (:foreground ,tokyodark-blue :background ,tokyodark-blue))))
         `(term-color-magenta ((,class (:foreground ,tokyodark-purple :background ,tokyodark-purple))))
         `(term-color-cyan ((,class (:foreground ,tokyodark-cyan :background ,tokyodark-cyan))))
         `(term-color-white ((,class (:foreground ,tokyodark-fg :background ,tokyodark-fg))))

;;;;; whitespace-mode
         `(whitespace-empty ((,class (:foreground ,tokyodark-red :background ,tokyodark-bg))))
         `(whitespace-hspace ((,class (:foreground ,tokyodark-bg-highlight))))
         `(whitespace-indentation ((,class (:foreground ,tokyodark-bg-highlight))))
         `(whitespace-line ((,class (:foreground ,tokyodark-red :background ,tokyodark-bg-highlight))))
         `(whitespace-newline ((,class (:foreground ,tokyodark-bg-highlight))))
         `(whitespace-space ((,class (:foreground ,tokyodark-bg-highlight))))
         `(whitespace-space-after-tab ((,class (:foreground ,tokyodark-bg-highlight))))
         `(whitespace-space-before-tab ((,class (:foreground ,tokyodark-orange))))
         `(whitespace-tab ((,class (:foreground ,tokyodark-bg-highlight))))
         `(whitespace-trailing ((,class (:foreground ,tokyodark-red :background ,tokyodark-diff-delete))))
         `(whitespace-big-indent ((,class (:foreground ,tokyodark-orange :background ,tokyodark-bg-highlight))))

;;;;; woman
         `(woman-bold ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(woman-italic ((,class (:foreground ,tokyodark-purple :slant italic))))

;;;;; xref
         `(xref-file-header ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(xref-line-number ((,class (:foreground ,tokyodark-grey))))
         `(xref-match ((,class (:foreground ,tokyodark-orange :weight bold))))

;;;; Built-in packages
;;;;; bookmark
         `(bookmark-face ((,class (:foreground ,tokyodark-yellow :background ,tokyodark-bg))))

;;;;; calendar
         `(calendar-today ((,class (:foreground ,tokyodark-blue :weight bold :underline t))))
         `(calendar-weekend-header ((,class (:foreground ,tokyodark-red))))
         `(calendar-weekday-header ((,class (:foreground ,tokyodark-cyan))))
         `(calendar-month-header ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(holiday ((,class (:foreground ,tokyodark-orange))))
         `(diary ((,class (:foreground ,tokyodark-yellow))))

;;;;; completion-preview
         `(completion-preview ((,class (:foreground ,tokyodark-grey))))
         `(completion-preview-common ((,class (:foreground ,tokyodark-grey))))
         `(completion-preview-exact ((,class (:foreground ,tokyodark-grey :underline t))))

;;;;; dictionary
         `(dictionary-word-entry-face ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(dictionary-word-definition-face ((,class (:foreground ,tokyodark-fg))))
         `(dictionary-reference-face ((,class (:foreground ,tokyodark-cyan :underline t))))
         `(dictionary-button-face ((,class (:foreground ,tokyodark-cyan :underline t :weight bold))))

;;;;; eglot
         `(eglot-highlight-symbol-face ((,class (:background ,tokyodark-bg-highlight :weight bold))))
         `(eglot-diagnostic-tag-unnecessary-face ((,class (:foreground ,tokyodark-grey :underline (:style wave :color ,tokyodark-grey)))))
         `(eglot-diagnostic-tag-deprecated-face ((,class (:foreground ,tokyodark-grey :strike-through ,tokyodark-grey))))
         `(eglot-inlay-hint-face ((,class (:foreground ,tokyodark-grey :height 0.9))))

;;;;; eldoc
         `(eldoc-highlight-function-argument ((,class (:foreground ,tokyodark-yellow :weight bold))))

;;;;; epa
         `(epa-field-body ((,class (:foreground ,tokyodark-fg :slant italic))))
         `(epa-field-name ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(epa-mark ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(epa-string ((,class (:foreground ,tokyodark-green))))
         `(epa-validity-disabled ((,class (:foreground ,tokyodark-red :slant italic))))
         `(epa-validity-high ((,class (:foreground ,tokyodark-green :weight bold))))
         `(epa-validity-low ((,class (:foreground ,tokyodark-grey))))
         `(epa-validity-medium ((,class (:foreground ,tokyodark-yellow))))

;;;;; eww
         `(eww-invalid-certificate ((,class (:foreground ,tokyodark-red :weight bold))))
         `(eww-valid-certificate ((,class (:foreground ,tokyodark-green :weight bold))))
         `(eww-form-text ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-highlight
                                               :box (:line-width -1 :color ,tokyodark-bg5)))))
         `(eww-form-textarea ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-highlight))))
         `(eww-form-checkbox ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(eww-form-select ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-highlight
                                                 :box (:line-width -1 :color ,tokyodark-bg5)))))
         `(eww-form-submit ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg5
                                                 :box (:line-width -1 :color ,tokyodark-grey)))))

;;;;; man
         `(Man-overstrike ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(Man-underline ((,class (:foreground ,tokyodark-cyan :underline t))))
         `(Man-reverse ((,class (:foreground ,tokyodark-bg :background ,tokyodark-fg))))

;;;;; vc
         `(vc-state-base ((,class (:foreground ,tokyodark-green))))
         `(vc-conflict-state ((,class (:foreground ,tokyodark-red :weight bold))))
         `(vc-edited-state ((,class (:foreground ,tokyodark-yellow))))
         `(vc-locally-added-state ((,class (:foreground ,tokyodark-git-add))))
         `(vc-locked-state ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(vc-missing-state ((,class (:foreground ,tokyodark-red))))
         `(vc-needs-update-state ((,class (:foreground ,tokyodark-orange))))
         `(vc-removed-state ((,class (:foreground ,tokyodark-red))))
         `(vc-up-to-date-state ((,class (:foreground ,tokyodark-green))))

;;;;; diff-hl
         `(diff-hl-change ((,class (:foreground ,tokyodark-git-change :background ,tokyodark-diff-change))))
         `(diff-hl-delete ((,class (:foreground ,tokyodark-git-delete :background ,tokyodark-diff-delete))))
         `(diff-hl-insert ((,class (:foreground ,tokyodark-git-add :background ,tokyodark-diff-add))))

;;;;; smerge
         `(smerge-base ((,class (:background ,tokyodark-diff-change :extend t))))
         `(smerge-markers ((,class (:foreground ,tokyodark-grey :background ,tokyodark-bg-dark :extend t))))
         `(smerge-upper ((,class (:background ,tokyodark-diff-delete :extend t))))
         `(smerge-lower ((,class (:background ,tokyodark-diff-add :extend t))))
         `(smerge-refined-added ((,class (:foreground ,tokyodark-green :background ,tokyodark-diff-add :weight bold :extend t))))
         `(smerge-refined-removed ((,class (:foreground ,tokyodark-red :background ,tokyodark-diff-delete :weight bold :extend t))))
         `(smerge-refined-changed ((,class (:foreground ,tokyodark-blue :background ,tokyodark-diff-change :weight bold :extend t))))

;;;; Third-party packages
;;;;; company
         `(company-tooltip ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-dark))))
         `(company-tooltip-selection ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-highlight))))
         `(company-tooltip-deprecated ((,class (:foreground ,tokyodark-grey :strike-through t))))
         `(company-tooltip-search ((,class (:foreground ,tokyodark-red :weight bold))))
         `(company-tooltip-search-selection ((,class (:foreground ,tokyodark-red :background ,tokyodark-bg-highlight :weight bold))))
         `(company-tooltip-mouse ((,class (:background ,tokyodark-bg-highlight))))
         `(company-tooltip-common ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(company-tooltip-common-selection ((,class (:foreground ,tokyodark-blue :background ,tokyodark-bg-highlight :weight bold))))
         `(company-tooltip-annotation ((,class (:foreground ,tokyodark-grey))))
         `(company-tooltip-annotation-selection ((,class (:foreground ,tokyodark-fg))))
         `(company-tooltip-quick-access ((,class (:foreground ,tokyodark-grey))))
         `(company-tooltip-quick-access-selection ((,class (:foreground ,tokyodark-fg))))
         `(company-tooltip-scrollbar-thumb ((,class (:background ,tokyodark-selection))))
         `(company-tooltip-scrollbar-track ((,class (:background ,tokyodark-bg-highlight))))
         `(company-preview ((,class (:foreground ,tokyodark-grey))))
         `(company-preview-common ((,class (:foreground ,tokyodark-blue))))
         `(company-preview-search ((,class (:foreground ,tokyodark-red))))
         `(company-echo ((,class (:foreground ,tokyodark-fg))))
         `(company-echo-common ((,class (:foreground ,tokyodark-blue :weight bold))))

;;;;; corfu
         `(corfu-default ((,class (:background ,tokyodark-bg-dark))))
         `(corfu-current ((,class (:background ,tokyodark-bg-highlight))))
         `(corfu-bar ((,class (:background ,tokyodark-selection))))
         `(corfu-border ((,class (:background ,tokyodark-grey))))
         `(corfu-annotations ((,class (:foreground ,tokyodark-grey))))
         `(corfu-deprecated ((,class (:foreground ,tokyodark-grey :strike-through t))))
         `(corfu-popupinfo ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-dark))))

;;;;; evil
         `(evil-ex-commands ((,class (:foreground ,tokyodark-fg :underline t :slant italic))))
         `(evil-ex-info ((,class (:foreground ,tokyodark-red :slant italic))))
         `(evil-ex-search ((,class (:foreground ,tokyodark-bg :background ,tokyodark-red :weight bold))))
         `(evil-ex-lazy-highlight ((,class (:foreground ,tokyodark-fg :background ,tokyodark-selection))))
         `(evil-ex-substitute-matches ((,class (:foreground ,tokyodark-fg :background ,tokyodark-selection))))
         `(evil-ex-substitute-replacement ((,class (:foreground ,tokyodark-orange :underline t :weight bold))))

;;;;; flycheck
         `(flycheck-error ((,class (:underline (:style wave :color ,tokyodark-red)))))
         `(flycheck-warning ((,class (:underline (:style wave :color ,tokyodark-yellow)))))
         `(flycheck-info ((,class (:underline (:style wave :color ,tokyodark-cyan)))))
         `(flycheck-fringe-error ((,class (:foreground ,tokyodark-red))))
         `(flycheck-fringe-warning ((,class (:foreground ,tokyodark-yellow))))
         `(flycheck-fringe-info ((,class (:foreground ,tokyodark-cyan))))
         `(flycheck-error-list-error ((,class (:foreground ,tokyodark-red))))
         `(flycheck-error-list-warning ((,class (:foreground ,tokyodark-yellow))))
         `(flycheck-error-list-info ((,class (:foreground ,tokyodark-cyan))))
         `(flycheck-error-list-filename ((,class (:foreground ,tokyodark-blue))))
         `(flycheck-error-list-line-number ((,class (:foreground ,tokyodark-grey))))
         `(flycheck-error-list-column-number ((,class (:foreground ,tokyodark-grey))))
         `(flycheck-error-list-id ((,class (:foreground ,tokyodark-grey))))
         `(flycheck-error-list-checker-name ((,class (:foreground ,tokyodark-grey))))
         `(flycheck-error-list-highlight ((,class (:background ,tokyodark-bg-highlight))))

;;;;; git-commit
         `(git-commit-summary ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(git-commit-overlong-summary ((,class (:foreground ,tokyodark-red :weight bold))))
         `(git-commit-nonempty-second-line ((,class (:foreground ,tokyodark-yellow))))
         `(git-commit-keyword ((,class (:foreground ,tokyodark-purple :slant italic))))
         `(git-commit-trailer-token ((,class (:foreground ,tokyodark-purple))))
         `(git-commit-trailer-value ((,class (:foreground ,tokyodark-fg))))
         `(git-commit-comment-branch-local ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(git-commit-comment-branch-remote ((,class (:foreground ,tokyodark-cyan :weight bold))))
         `(git-commit-comment-detached ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(git-commit-comment-heading ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(git-commit-comment-file ((,class (:foreground ,tokyodark-fg))))
         `(git-commit-comment-action ((,class (:foreground ,tokyodark-grey))))

;;;;; git-rebase
         `(git-rebase-hash ((,class (:foreground ,tokyodark-grey))))
         `(git-rebase-label ((,class (:foreground ,tokyodark-purple))))
         `(git-rebase-description ((,class (:foreground ,tokyodark-fg))))
         `(git-rebase-action ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(git-rebase-killed-action ((,class (:foreground ,tokyodark-grey :strike-through t))))
         `(git-rebase-comment-hash ((,class (:foreground ,tokyodark-grey))))
         `(git-rebase-comment-heading ((,class (:foreground ,tokyodark-fg :weight bold))))

;;;;; helpful
         `(helpful-heading ((,class (:foreground ,tokyodark-blue :weight bold :height 1.2))))

;;;;; magit
         `(magit-section-heading ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(magit-section-heading-selection ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(magit-section-secondary-heading ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(magit-section-highlight ((,class (:background ,tokyodark-bg-highlight))))
         `(magit-section-child-count ((,class (:foreground ,tokyodark-grey))))
         `(magit-header-line ((,class (:foreground ,tokyodark-blue :weight bold :background ,tokyodark-bg-dark))))
         `(magit-header-line-key ((,class (:foreground ,tokyodark-blue))))
         `(magit-dimmed ((,class (:foreground ,tokyodark-grey))))
         `(magit-hash ((,class (:foreground ,tokyodark-grey))))
         `(magit-tag ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(magit-keyword ((,class (:foreground ,tokyodark-purple))))
         `(magit-keyword-squash ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(magit-filename ((,class (:foreground ,tokyodark-fg))))
         `(magit-head ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(magit-branch-local ((,class (:foreground ,tokyodark-blue))))
         `(magit-branch-current ((,class (:foreground ,tokyodark-blue :weight bold :box (:line-width -1 :color ,tokyodark-blue)))))
         `(magit-branch-remote ((,class (:foreground ,tokyodark-cyan))))
         `(magit-branch-remote-head ((,class (:foreground ,tokyodark-cyan :weight bold :box (:line-width -1 :color ,tokyodark-cyan)))))
         `(magit-branch-upstream ((,class (:slant italic))))
         `(magit-branch-warning ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(magit-refname ((,class (:foreground ,tokyodark-grey))))
         `(magit-refname-stash ((,class (:foreground ,tokyodark-grey))))
         `(magit-refname-wip ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(magit-refname-pullreq ((,class (:foreground ,tokyodark-grey))))
         `(magit-signature-good ((,class (:foreground ,tokyodark-green))))
         `(magit-signature-bad ((,class (:foreground ,tokyodark-red :weight bold))))
         `(magit-signature-untrusted ((,class (:foreground ,tokyodark-yellow))))
         `(magit-signature-expired ((,class (:foreground ,tokyodark-orange))))
         `(magit-signature-expired-key ((,class (:foreground ,tokyodark-orange))))
         `(magit-signature-revoked ((,class (:foreground ,tokyodark-purple))))
         `(magit-signature-error ((,class (:foreground ,tokyodark-red))))
         `(magit-cherry-unmatched ((,class (:foreground ,tokyodark-cyan))))
         `(magit-cherry-equivalent ((,class (:foreground ,tokyodark-purple))))
         `(magit-diff-file-heading ((,class (:foreground ,tokyodark-fg :weight bold :extend t))))
         `(magit-diff-file-heading-highlight ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-highlight :weight bold :extend t))))
         `(magit-diff-file-heading-selection ((,class (:foreground ,tokyodark-orange :background ,tokyodark-bg-highlight :weight bold :extend t))))
         `(magit-diff-hunk-heading ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-dark :extend t))))
         `(magit-diff-hunk-heading-highlight ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg5 :extend t))))
         `(magit-diff-hunk-heading-selection ((,class (:foreground ,tokyodark-orange :background ,tokyodark-bg5 :extend t))))
         `(magit-diff-conflict-heading ((,class (:foreground ,tokyodark-yellow :background ,tokyodark-bg-dark :extend t))))
         `(magit-diff-conflict-heading-highlight ((,class (:foreground ,tokyodark-yellow :background ,tokyodark-bg5 :extend t))))
         `(magit-diff-revision-summary ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(magit-diff-revision-summary-highlight ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-highlight :weight bold))))
         `(magit-diff-lines-heading ((,class (:foreground ,tokyodark-bg :background ,tokyodark-blue :extend t))))
         `(magit-diff-context ((,class (:foreground ,tokyodark-grey :extend t))))
         `(magit-diff-context-highlight ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-dark :extend t))))
         `(magit-diff-added ((,class (:foreground ,tokyodark-git-add :background ,tokyodark-diff-add :extend t))))
         `(magit-diff-added-highlight ((,class (:foreground ,tokyodark-git-add :background ,tokyodark-diff-add :weight bold :extend t))))
         `(magit-diff-removed ((,class (:foreground ,tokyodark-git-delete :background ,tokyodark-diff-delete :extend t))))
         `(magit-diff-removed-highlight ((,class (:foreground ,tokyodark-git-delete :background ,tokyodark-diff-delete :weight bold :extend t))))
         `(magit-diff-our ((,class (:inherit magit-diff-removed))))
         `(magit-diff-our-highlight ((,class (:inherit magit-diff-removed-highlight))))
         `(magit-diff-base ((,class (:foreground ,tokyodark-yellow :background ,tokyodark-diff-change :extend t))))
         `(magit-diff-base-highlight ((,class (:foreground ,tokyodark-yellow :background ,tokyodark-diff-change :weight bold :extend t))))
         `(magit-diff-their ((,class (:inherit magit-diff-added))))
         `(magit-diff-their-highlight ((,class (:inherit magit-diff-added-highlight))))
         `(magit-diffstat-added ((,class (:foreground ,tokyodark-git-add))))
         `(magit-diffstat-removed ((,class (:foreground ,tokyodark-git-delete))))
         `(magit-diff-whitespace-warning ((,class (:background ,tokyodark-red))))
         `(magit-log-graph ((,class (:foreground ,tokyodark-grey))))
         `(magit-log-author ((,class (:foreground ,tokyodark-orange))))
         `(magit-log-date ((,class (:foreground ,tokyodark-cyan))))
         `(magit-header-line-log-select ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(magit-process-ok ((,class (:foreground ,tokyodark-green :weight bold))))
         `(magit-process-ng ((,class (:foreground ,tokyodark-red :weight bold))))
         `(magit-mode-line-process ((,class (:foreground ,tokyodark-blue))))
         `(magit-mode-line-process-error ((,class (:foreground ,tokyodark-red))))
         `(magit-sequence-pick ((,class (:foreground ,tokyodark-fg))))
         `(magit-sequence-stop ((,class (:foreground ,tokyodark-green))))
         `(magit-sequence-part ((,class (:foreground ,tokyodark-yellow))))
         `(magit-sequence-head ((,class (:foreground ,tokyodark-blue))))
         `(magit-sequence-drop ((,class (:foreground ,tokyodark-red))))
         `(magit-sequence-done ((,class (:foreground ,tokyodark-grey))))
         `(magit-sequence-onto ((,class (:foreground ,tokyodark-grey))))
         `(magit-sequence-exec ((,class (:foreground ,tokyodark-grey))))
         `(magit-bisect-good ((,class (:foreground ,tokyodark-green))))
         `(magit-bisect-skip ((,class (:foreground ,tokyodark-yellow))))
         `(magit-bisect-bad ((,class (:foreground ,tokyodark-red))))
         `(magit-blame-highlight ((,class (:background ,tokyodark-bg-highlight :extend t))))
         `(magit-blame-margin ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-dark :extend t))))
         `(magit-blame-dimmed ((,class (:foreground ,tokyodark-grey))))
         `(magit-blame-heading ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-dark :extend t))))
         `(magit-blame-summary ((,class (:foreground ,tokyodark-fg))))
         `(magit-blame-hash ((,class (:foreground ,tokyodark-grey))))
         `(magit-blame-name ((,class (:foreground ,tokyodark-orange))))
         `(magit-blame-date ((,class (:foreground ,tokyodark-cyan))))
         `(magit-reflog-commit ((,class (:foreground ,tokyodark-green))))
         `(magit-reflog-amend ((,class (:foreground ,tokyodark-yellow))))
         `(magit-reflog-merge ((,class (:foreground ,tokyodark-cyan))))
         `(magit-reflog-checkout ((,class (:foreground ,tokyodark-blue))))
         `(magit-reflog-reset ((,class (:foreground ,tokyodark-red))))
         `(magit-reflog-rebase ((,class (:foreground ,tokyodark-purple))))
         `(magit-reflog-cherry-pick ((,class (:foreground ,tokyodark-green))))
         `(magit-reflog-remote ((,class (:foreground ,tokyodark-cyan))))
         `(magit-reflog-other ((,class (:foreground ,tokyodark-grey))))

;;;;; marginalia
         `(marginalia-key ((,class (:foreground ,tokyodark-blue))))
         `(marginalia-type ((,class (:foreground ,tokyodark-blue))))
         `(marginalia-char ((,class (:foreground ,tokyodark-orange))))
         `(marginalia-lighter ((,class (:foreground ,tokyodark-grey))))
         `(marginalia-on ((,class (:foreground ,tokyodark-green))))
         `(marginalia-off ((,class (:foreground ,tokyodark-grey))))
         `(marginalia-documentation ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(marginalia-value ((,class (:foreground ,tokyodark-fg))))
         `(marginalia-null ((,class (:foreground ,tokyodark-grey))))
         `(marginalia-true ((,class (:foreground ,tokyodark-green))))
         `(marginalia-function ((,class (:foreground ,tokyodark-blue))))
         `(marginalia-symbol ((,class (:foreground ,tokyodark-purple))))
         `(marginalia-list ((,class (:foreground ,tokyodark-cyan))))
         `(marginalia-mode ((,class (:foreground ,tokyodark-cyan))))
         `(marginalia-date ((,class (:foreground ,tokyodark-cyan))))
         `(marginalia-version ((,class (:foreground ,tokyodark-cyan))))
         `(marginalia-archive ((,class (:foreground ,tokyodark-purple))))
         `(marginalia-installed ((,class (:foreground ,tokyodark-green))))
         `(marginalia-size ((,class (:foreground ,tokyodark-grey))))
         `(marginalia-number ((,class (:foreground ,tokyodark-orange))))
         `(marginalia-string ((,class (:foreground ,tokyodark-green))))
         `(marginalia-modified ((,class (:foreground ,tokyodark-yellow))))
         `(marginalia-file-name ((,class (:foreground ,tokyodark-fg))))
         `(marginalia-file-owner ((,class (:foreground ,tokyodark-grey))))
         `(marginalia-file-priv-no ((,class (:foreground ,tokyodark-grey))))
         `(marginalia-file-priv-dir ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(marginalia-file-priv-link ((,class (:foreground ,tokyodark-cyan))))
         `(marginalia-file-priv-read ((,class (:foreground ,tokyodark-yellow))))
         `(marginalia-file-priv-write ((,class (:foreground ,tokyodark-red))))
         `(marginalia-file-priv-exec ((,class (:foreground ,tokyodark-green))))
         `(marginalia-file-priv-other ((,class (:foreground ,tokyodark-purple))))
         `(marginalia-file-priv-rare ((,class (:foreground ,tokyodark-orange))))

;;;;; markdown-mode
         `(markdown-header-face ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(markdown-header-face-1 ((,class (:foreground ,tokyodark-heading1 :weight bold :height ,h1))))
         `(markdown-header-face-2 ((,class (:foreground ,tokyodark-heading2 :weight bold :height ,h2))))
         `(markdown-header-face-3 ((,class (:foreground ,tokyodark-heading3 :weight bold :height ,h3))))
         `(markdown-header-face-4 ((,class (:foreground ,tokyodark-heading4 :weight bold))))
         `(markdown-header-face-5 ((,class (:foreground ,tokyodark-heading5 :weight bold))))
         `(markdown-header-face-6 ((,class (:foreground ,tokyodark-heading6 :weight bold))))
         `(markdown-header-delimiter-face ((,class (:foreground ,tokyodark-grey))))
         `(markdown-header-rule-face ((,class (:foreground ,tokyodark-grey))))
         `(markdown-bold-face ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(markdown-italic-face ((,class (:foreground ,tokyodark-fg :slant italic))))
         `(markdown-strike-through-face ((,class (:foreground ,tokyodark-grey :strike-through t))))
         `(markdown-markup-face ((,class (:foreground ,tokyodark-grey))))
         `(markdown-list-face ((,class (:foreground ,tokyodark-purple))))
         `(markdown-blockquote-face ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(markdown-code-face ((,class (:foreground ,tokyodark-cyan :background ,tokyodark-bg-dark :extend t))))
         `(markdown-inline-code-face ((,class (:foreground ,tokyodark-cyan :background ,tokyodark-bg-dark))))
         `(markdown-pre-face ((,class (:foreground ,tokyodark-cyan :background ,tokyodark-bg-dark))))
         `(markdown-table-face ((,class (:foreground ,tokyodark-fg))))
         `(markdown-language-keyword-face ((,class (:foreground ,tokyodark-purple))))
         `(markdown-language-info-face ((,class (:foreground ,tokyodark-grey))))
         `(markdown-link-face ((,class (:foreground ,tokyodark-cyan))))
         `(markdown-missing-link-face ((,class (:foreground ,tokyodark-red :weight bold))))
         `(markdown-reference-face ((,class (:foreground ,tokyodark-grey))))
         `(markdown-footnote-marker-face ((,class (:foreground ,tokyodark-grey))))
         `(markdown-footnote-text-face ((,class (:foreground ,tokyodark-fg))))
         `(markdown-url-face ((,class (:foreground ,tokyodark-blue :underline t))))
         `(markdown-plain-url-face ((,class (:foreground ,tokyodark-blue :underline t))))
         `(markdown-link-title-face ((,class (:foreground ,tokyodark-green :slant italic))))
         `(markdown-line-break-face ((,class (:background ,tokyodark-bg-highlight))))
         `(markdown-comment-face ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(markdown-math-face ((,class (:foreground ,tokyodark-orange))))
         `(markdown-metadata-key-face ((,class (:foreground ,tokyodark-purple))))
         `(markdown-metadata-value-face ((,class (:foreground ,tokyodark-fg))))
         `(markdown-gfm-checkbox-face ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(markdown-highlight-face ((,class (:foreground ,tokyodark-bg :background ,tokyodark-yellow))))
         `(markdown-hr-face ((,class (:foreground ,tokyodark-grey))))
         `(markdown-html-tag-name-face ((,class (:foreground ,tokyodark-red))))
         `(markdown-html-tag-delimiter-face ((,class (:foreground ,tokyodark-grey))))
         `(markdown-html-attr-name-face ((,class (:foreground ,tokyodark-purple))))
         `(markdown-html-attr-value-face ((,class (:foreground ,tokyodark-green))))
         `(markdown-html-entity-face ((,class (:foreground ,tokyodark-orange))))

;;;;; orderless
         `(orderless-match-face-0 ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(orderless-match-face-1 ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(orderless-match-face-2 ((,class (:foreground ,tokyodark-cyan :weight bold))))
         `(orderless-match-face-3 ((,class (:foreground ,tokyodark-orange :weight bold))))

;;;;; rainbow-delimiters
         `(rainbow-delimiters-base-face ((,class (:foreground ,tokyodark-fg))))
         `(rainbow-delimiters-base-error-face ((,class (:foreground ,tokyodark-red :weight bold))))
         `(rainbow-delimiters-unmatched-face ((,class (:foreground ,tokyodark-red :weight bold))))
         `(rainbow-delimiters-mismatched-face ((,class (:foreground ,tokyodark-red :weight bold))))
         `(rainbow-delimiters-depth-1-face ((,class (:foreground ,tokyodark-blue))))
         `(rainbow-delimiters-depth-2-face ((,class (:foreground ,tokyodark-purple))))
         `(rainbow-delimiters-depth-3-face ((,class (:foreground ,tokyodark-cyan))))
         `(rainbow-delimiters-depth-4-face ((,class (:foreground ,tokyodark-orange))))
         `(rainbow-delimiters-depth-5-face ((,class (:foreground ,tokyodark-green))))
         `(rainbow-delimiters-depth-6-face ((,class (:foreground ,tokyodark-yellow))))
         `(rainbow-delimiters-depth-7-face ((,class (:foreground ,tokyodark-red))))
         `(rainbow-delimiters-depth-8-face ((,class (:foreground ,tokyodark-purple))))
         `(rainbow-delimiters-depth-9-face ((,class (:foreground ,tokyodark-blue))))

;;;;; transient
         `(transient-heading ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(transient-argument ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(transient-inactive-argument ((,class (:foreground ,tokyodark-grey))))
         `(transient-inapt-argument ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(transient-value ((,class (:foreground ,tokyodark-cyan :weight bold))))
         `(transient-inactive-value ((,class (:foreground ,tokyodark-grey))))
         `(transient-delimiter ((,class (:foreground ,tokyodark-grey))))
         `(transient-unreachable ((,class (:foreground ,tokyodark-grey))))
         `(transient-inapt-suffix ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(transient-active-infix ((,class (:background ,tokyodark-bg-highlight))))
         `(transient-enabled-suffix ((,class (:foreground ,tokyodark-green :background ,tokyodark-diff-add :weight bold))))
         `(transient-disabled-suffix ((,class (:foreground ,tokyodark-red :background ,tokyodark-diff-delete :weight bold))))
         `(transient-higher-level ((,class (:underline t))))
         `(transient-key ((,class (:foreground ,tokyodark-blue))))
         `(transient-key-stay ((,class (:foreground ,tokyodark-cyan :weight bold))))
         `(transient-key-noop ((,class (:foreground ,tokyodark-grey))))
         `(transient-key-return ((,class (:foreground ,tokyodark-purple))))
         `(transient-key-recurse ((,class (:foreground ,tokyodark-orange))))
         `(transient-key-stack ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(transient-key-exit ((,class (:foreground ,tokyodark-red))))
         `(transient-unreachable-key ((,class (:foreground ,tokyodark-grey))))
         `(transient-nonstandard-key ((,class (:foreground ,tokyodark-yellow :underline t))))
         `(transient-mismatched-key ((,class (:foreground ,tokyodark-yellow :underline t))))

;;;;; vertico
         `(vertico-current ((,class (:background ,tokyodark-bg-highlight :extend t))))
         `(vertico-multiline ((,class (:foreground ,tokyodark-grey))))
         `(vertico-group-title ((,class (:foreground ,tokyodark-purple :weight bold :slant italic))))
         `(vertico-group-separator ((,class (:foreground ,tokyodark-grey :strike-through t))))

;;;;; which-key
         `(which-key-key-face ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(which-key-separator-face ((,class (:foreground ,tokyodark-grey))))
         `(which-key-note-face ((,class (:foreground ,tokyodark-grey))))
         `(which-key-command-description-face ((,class (:foreground ,tokyodark-fg))))
         `(which-key-local-map-description-face ((,class (:foreground ,tokyodark-cyan))))
         `(which-key-highlighted-command-face ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(which-key-group-description-face ((,class (:foreground ,tokyodark-purple))))
         `(which-key-special-key-face ((,class (:foreground ,tokyodark-red :weight bold))))
         `(which-key-docstring-face ((,class (:foreground ,tokyodark-grey :slant italic))))

;;;;; ace-window
         `(aw-leading-char-face ((,class (:foreground ,tokyodark-red :weight bold :height 2.0))))
         `(aw-minibuffer-leading-char-face ((,class (:foreground ,tokyodark-red :weight bold))))
         `(aw-background-face ((,class (:foreground ,tokyodark-grey))))
         `(aw-mode-line-face ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(aw-key-face ((,class (:foreground ,tokyodark-red :weight bold))))

;;;;; doom-modeline
         `(doom-modeline ((,class (:inherit mode-line))))
         `(doom-modeline-emphasis ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(doom-modeline-highlight ((,class (:foreground ,tokyodark-purple))))
         `(doom-modeline-buffer-path ((,class (:foreground ,tokyodark-grey))))
         `(doom-modeline-buffer-file ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(doom-modeline-buffer-modified ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(doom-modeline-buffer-major-mode ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(doom-modeline-buffer-minor-mode ((,class (:foreground ,tokyodark-grey))))
         `(doom-modeline-project-parent-dir ((,class (:foreground ,tokyodark-grey))))
         `(doom-modeline-project-dir ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(doom-modeline-project-root-dir ((,class (:foreground ,tokyodark-fg))))
         `(doom-modeline-panel ((,class (:foreground ,tokyodark-bg :background ,tokyodark-blue))))
         `(doom-modeline-host ((,class (:foreground ,tokyodark-purple :slant italic))))
         `(doom-modeline-input-method ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(doom-modeline-input-method-alt ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(doom-modeline-debug ((,class (:foreground ,tokyodark-orange))))
         `(doom-modeline-info ((,class (:foreground ,tokyodark-cyan))))
         `(doom-modeline-warning ((,class (:foreground ,tokyodark-yellow))))
         `(doom-modeline-urgent ((,class (:foreground ,tokyodark-red))))
         `(doom-modeline-notification ((,class (:foreground ,tokyodark-orange))))
         `(doom-modeline-unread-number ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(doom-modeline-bar ((,class (:background ,tokyodark-blue))))
         `(doom-modeline-bar-inactive ((,class (:background ,tokyodark-bg-dark))))
         `(doom-modeline-debug-visual ((,class (:foreground ,tokyodark-orange :background ,tokyodark-bg-dark))))
         `(doom-modeline-evil-emacs-state ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(doom-modeline-evil-insert-state ((,class (:foreground ,tokyodark-green :weight bold))))
         `(doom-modeline-evil-motion-state ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(doom-modeline-evil-normal-state ((,class (:foreground ,tokyodark-cyan :weight bold))))
         `(doom-modeline-evil-operator-state ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(doom-modeline-evil-visual-state ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(doom-modeline-evil-replace-state ((,class (:foreground ,tokyodark-red :weight bold))))
         `(doom-modeline-overwrite ((,class (:foreground ,tokyodark-red :weight bold))))
         `(doom-modeline-project-name ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(doom-modeline-workspace-name ((,class (:foreground ,tokyodark-purple))))
         `(doom-modeline-persp-name ((,class (:foreground ,tokyodark-cyan :weight bold))))
         `(doom-modeline-persp-buffer-not-in-persp ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(doom-modeline-repl-success ((,class (:foreground ,tokyodark-green :weight bold))))
         `(doom-modeline-repl-warning ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(doom-modeline-vcs-default ((,class (:foreground ,tokyodark-fg))))
         `(doom-modeline-lsp-success ((,class (:foreground ,tokyodark-green :weight bold))))
         `(doom-modeline-lsp-warning ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(doom-modeline-lsp-error ((,class (:foreground ,tokyodark-red :weight bold))))
         `(doom-modeline-lsp-running ((,class (:foreground ,tokyodark-orange))))
         `(doom-modeline-battery-charging ((,class (:foreground ,tokyodark-green))))
         `(doom-modeline-battery-full ((,class (:foreground ,tokyodark-green))))
         `(doom-modeline-battery-normal ((,class (:foreground ,tokyodark-fg))))
         `(doom-modeline-battery-warning ((,class (:foreground ,tokyodark-yellow :weight bold))))
         `(doom-modeline-battery-critical ((,class (:foreground ,tokyodark-red :weight bold))))
         `(doom-modeline-battery-error ((,class (:foreground ,tokyodark-red :weight bold))))
         `(doom-modeline-time ((,class (:foreground ,tokyodark-grey))))
         `(doom-modeline-compilation ((,class (:foreground ,tokyodark-orange :weight bold))))

;;;;; elfeed
         `(elfeed-search-date-face ((,class (:foreground ,tokyodark-cyan))))
         `(elfeed-search-title-face ((,class (:foreground ,tokyodark-grey))))
         `(elfeed-search-unread-title-face ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(elfeed-search-feed-face ((,class (:foreground ,tokyodark-blue))))
         `(elfeed-search-tag-face ((,class (:foreground ,tokyodark-cyan))))
         `(elfeed-search-last-update-face ((,class (:foreground ,tokyodark-grey))))
         `(elfeed-search-unread-count-face ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(elfeed-search-filter-face ((,class (:foreground ,tokyodark-purple :weight bold))))

;;;;; lsp-mode
         `(lsp-face-highlight-textual ((,class (:background ,tokyodark-bg-highlight))))
         `(lsp-face-highlight-read ((,class (:background ,tokyodark-bg-highlight))))
         `(lsp-face-highlight-write ((,class (:background ,tokyodark-bg-highlight :weight bold))))

;;;;; lsp-ui
         `(lsp-ui-doc-background ((,class (:background ,tokyodark-bg-dark))))
         `(lsp-ui-doc-header ((,class (:foreground ,tokyodark-fg :background ,tokyodark-selection :weight bold))))
         `(lsp-ui-doc-highlight-hover ((,class (:background ,tokyodark-bg-highlight))))
         `(lsp-ui-doc-url ((,class (:foreground ,tokyodark-cyan :underline t))))
         `(lsp-ui-peek-peek ((,class (:background ,tokyodark-bg-dark))))
         `(lsp-ui-peek-list ((,class (:background ,tokyodark-bg-dark))))
         `(lsp-ui-peek-filename ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(lsp-ui-peek-line-number ((,class (:foreground ,tokyodark-grey))))
         `(lsp-ui-peek-highlight ((,class (:foreground ,tokyodark-red :weight bold :box (:line-width -1 :color ,tokyodark-red)))))
         `(lsp-ui-peek-header ((,class (:foreground ,tokyodark-fg :background ,tokyodark-selection :weight bold))))
         `(lsp-ui-peek-footer ((,class (:foreground ,tokyodark-fg :background ,tokyodark-selection))))
         `(lsp-ui-peek-selection ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-highlight :weight bold))))
         `(lsp-ui-sideline-symbol ((,class (:foreground ,tokyodark-grey :box (:line-width -1 :color ,tokyodark-grey)))))
         `(lsp-ui-sideline-current-symbol ((,class (:foreground ,tokyodark-fg :weight bold :box (:line-width -1 :color ,tokyodark-fg)))))
         `(lsp-ui-sideline-code-action ((,class (:foreground ,tokyodark-yellow))))
         `(lsp-ui-sideline-symbol-info ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(lsp-ui-sideline-global ((,class (:foreground ,tokyodark-grey))))

;;;;; smartparens
         `(sp-show-pair-match-face ((,class (:foreground ,tokyodark-purple :background ,tokyodark-bg-highlight :weight bold))))
         `(sp-show-pair-mismatch-face ((,class (:foreground ,tokyodark-red :background ,tokyodark-bg :weight bold :underline t))))
         `(sp-pair-overlay-face ((,class (:background ,tokyodark-bg-highlight))))
         `(sp-show-pair-match-content-face ((,class (:background ,tokyodark-bg-highlight))))

;;;;; treemacs
         `(treemacs-directory-face ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(treemacs-directory-collapsed-face ((,class (:foreground ,tokyodark-blue))))
         `(treemacs-window-background-face ((,class (:background ,tokyodark-bg-dark))))
         `(treemacs-hl-line-face ((,class (:background ,tokyodark-bg-highlight :extend t))))
         `(treemacs-file-face ((,class (:foreground ,tokyodark-fg))))
         `(treemacs-root-face ((,class (:foreground ,tokyodark-blue :weight bold :height 1.1))))
         `(treemacs-root-unreadable-face ((,class (:foreground ,tokyodark-red :weight bold :height 1.1))))
         `(treemacs-root-remote-face ((,class (:foreground ,tokyodark-purple :weight bold :height 1.1))))
         `(treemacs-root-remote-unreadable-face ((,class (:foreground ,tokyodark-red :slant italic :height 1.1))))
         `(treemacs-root-remote-disconnected-face ((,class (:foreground ,tokyodark-grey :weight bold :height 1.1))))
         `(treemacs-term-node-face ((,class (:foreground ,tokyodark-fg))))
         `(treemacs-git-unmodified-face ((,class (:foreground ,tokyodark-fg))))
         `(treemacs-git-modified-face ((,class (:foreground ,tokyodark-yellow))))
         `(treemacs-git-renamed-face ((,class (:foreground ,tokyodark-git-add))))
         `(treemacs-git-ignored-face ((,class (:foreground ,tokyodark-grey))))
         `(treemacs-git-untracked-face ((,class (:foreground ,tokyodark-orange))))
         `(treemacs-git-added-face ((,class (:foreground ,tokyodark-git-add))))
         `(treemacs-git-conflict-face ((,class (:foreground ,tokyodark-red :weight bold))))
         `(treemacs-tags-face ((,class (:foreground ,tokyodark-cyan))))
         `(treemacs-help-title-face ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(treemacs-help-column-face ((,class (:foreground ,tokyodark-blue))))
         `(treemacs-on-failure-pulse-face ((,class (:background ,tokyodark-diff-delete))))
         `(treemacs-on-success-pulse-face ((,class (:background ,tokyodark-diff-add))))
         `(treemacs-fringe-indicator-face ((,class (:foreground ,tokyodark-blue))))
         `(treemacs-header-button-face ((,class (:foreground ,tokyodark-fg :background ,tokyodark-bg-highlight :box (:line-width -1 :color ,tokyodark-bg5)))))
         `(treemacs-marked-file-face ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(treemacs-git-commit-diff-face ((,class (:foreground ,tokyodark-grey))))
         `(treemacs-async-loading-face ((,class (:foreground ,tokyodark-grey :slant italic))))

;;;;; web-mode
         `(web-mode-error-face ((,class (:foreground ,tokyodark-red :underline t))))
         `(web-mode-warning-face ((,class (:foreground ,tokyodark-yellow :underline t))))
         `(web-mode-preprocessor-face ((,class (:foreground ,tokyodark-cyan))))
         `(web-mode-block-delimiter-face ((,class (:foreground ,tokyodark-grey))))
         `(web-mode-block-control-face ((,class (:foreground ,tokyodark-purple))))
         `(web-mode-builtin-face ((,class (:foreground ,tokyodark-blue))))
         `(web-mode-symbol-face ((,class (:foreground ,tokyodark-orange))))
         `(web-mode-doctype-face ((,class (:foreground ,tokyodark-grey))))
         `(web-mode-html-tag-face ((,class (:foreground ,tokyodark-red))))
         `(web-mode-html-tag-custom-face ((,class (:foreground ,tokyodark-red))))
         `(web-mode-html-tag-unclosed-face ((,class (:foreground ,tokyodark-red :underline t))))
         `(web-mode-html-tag-namespaced-face ((,class (:foreground ,tokyodark-red))))
         `(web-mode-html-tag-bracket-face ((,class (:foreground ,tokyodark-fg))))
         `(web-mode-html-attr-name-face ((,class (:foreground ,tokyodark-purple))))
         `(web-mode-html-attr-custom-face ((,class (:foreground ,tokyodark-purple :slant italic))))
         `(web-mode-html-attr-engine-face ((,class (:foreground ,tokyodark-purple))))
         `(web-mode-html-attr-equal-face ((,class (:foreground ,tokyodark-fg))))
         `(web-mode-html-attr-value-face ((,class (:foreground ,tokyodark-green))))
         `(web-mode-block-attr-name-face ((,class (:foreground ,tokyodark-purple))))
         `(web-mode-block-attr-value-face ((,class (:foreground ,tokyodark-green))))
         `(web-mode-variable-name-face ((,class (:foreground ,tokyodark-fg))))
         `(web-mode-css-selector-face ((,class (:foreground ,tokyodark-cyan))))
         `(web-mode-css-selector-class-face ((,class (:foreground ,tokyodark-green))))
         `(web-mode-css-selector-tag-face ((,class (:foreground ,tokyodark-cyan))))
         `(web-mode-css-pseudo-class-face ((,class (:foreground ,tokyodark-blue))))
         `(web-mode-css-at-rule-face ((,class (:foreground ,tokyodark-purple))))
         `(web-mode-css-property-name-face ((,class (:foreground ,tokyodark-blue))))
         `(web-mode-css-color-face ((,class (:foreground ,tokyodark-orange))))
         `(web-mode-css-priority-face ((,class (:foreground ,tokyodark-orange :weight bold))))
         `(web-mode-css-function-face ((,class (:foreground ,tokyodark-cyan))))
         `(web-mode-css-variable-face ((,class (:foreground ,tokyodark-fg))))
         `(web-mode-function-name-face ((,class (:foreground ,tokyodark-green))))
         `(web-mode-filter-face ((,class (:foreground ,tokyodark-cyan))))
         `(web-mode-function-call-face ((,class (:foreground ,tokyodark-green))))
         `(web-mode-string-face ((,class (:foreground ,tokyodark-yellow))))
         `(web-mode-block-string-face ((,class (:foreground ,tokyodark-yellow))))
         `(web-mode-part-string-face ((,class (:foreground ,tokyodark-yellow))))
         `(web-mode-javascript-string-face ((,class (:foreground ,tokyodark-yellow))))
         `(web-mode-css-string-face ((,class (:foreground ,tokyodark-yellow))))
         `(web-mode-json-key-face ((,class (:foreground ,tokyodark-cyan))))
         `(web-mode-json-context-face ((,class (:foreground ,tokyodark-purple))))
         `(web-mode-json-string-face ((,class (:foreground ,tokyodark-yellow))))
         `(web-mode-comment-face ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(web-mode-block-comment-face ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(web-mode-part-comment-face ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(web-mode-json-comment-face ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(web-mode-javascript-comment-face ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(web-mode-css-comment-face ((,class (:foreground ,tokyodark-grey :slant italic))))
         `(web-mode-annotation-face ((,class (:foreground ,tokyodark-grey))))
         `(web-mode-annotation-tag-face ((,class (:foreground ,tokyodark-grey))))
         `(web-mode-annotation-type-face ((,class (:foreground ,tokyodark-blue))))
         `(web-mode-annotation-value-face ((,class (:foreground ,tokyodark-green))))
         `(web-mode-annotation-html-face ((,class (:foreground ,tokyodark-grey))))
         `(web-mode-constant-face ((,class (:foreground ,tokyodark-orange))))
         `(web-mode-type-face ((,class (:foreground ,tokyodark-blue))))
         `(web-mode-keyword-face ((,class (:foreground ,tokyodark-red))))
         `(web-mode-param-name-face ((,class (:foreground ,tokyodark-fg))))
         `(web-mode-whitespace-face ((,class (:foreground ,tokyodark-red :background ,tokyodark-diff-delete))))
         `(web-mode-inlay-face ((,class (:background ,tokyodark-bg-dark))))
         `(web-mode-block-face ((,class (:background ,tokyodark-bg-dark))))
         `(web-mode-part-face ((,class (:background ,tokyodark-bg-dark))))
         `(web-mode-script-face ((,class (:background ,tokyodark-bg-dark))))
         `(web-mode-style-face ((,class (:background ,tokyodark-bg-dark))))
         `(web-mode-folded-face ((,class (:foreground ,tokyodark-grey :underline t))))
         `(web-mode-current-element-highlight-face ((,class (:background ,tokyodark-bg-highlight))))
         `(web-mode-current-column-highlight-face ((,class (:background ,tokyodark-bg-dark))))
         `(web-mode-comment-keyword-face ((,class (:foreground ,tokyodark-purple :weight bold))))
         `(web-mode-sql-keyword-face ((,class (:foreground ,tokyodark-cyan))))
         `(web-mode-html-entity-face ((,class (:foreground ,tokyodark-orange))))

;;;;; centaur-tabs
         `(centaur-tabs-default ((,class (:background ,tokyodark-bg-dark :foreground ,tokyodark-grey))))
         `(centaur-tabs-selected ((,class (:background ,tokyodark-bg :foreground ,tokyodark-fg :weight bold))))
         `(centaur-tabs-unselected ((,class (:background ,tokyodark-bg-dark :foreground ,tokyodark-grey))))
         `(centaur-tabs-selected-modified ((,class (:background ,tokyodark-bg :foreground ,tokyodark-orange :weight bold))))
         `(centaur-tabs-unselected-modified ((,class (:background ,tokyodark-bg-dark :foreground ,tokyodark-orange))))
         `(centaur-tabs-active-bar-face ((,class (:background ,tokyodark-blue))))
         `(centaur-tabs-modified-marker-selected ((,class (:foreground ,tokyodark-orange))))
         `(centaur-tabs-modified-marker-unselected ((,class (:foreground ,tokyodark-orange))))

;;;;; git-gutter
         `(git-gutter:added ((,class (:foreground ,tokyodark-git-add))))
         `(git-gutter:deleted ((,class (:foreground ,tokyodark-git-delete))))
         `(git-gutter:modified ((,class (:foreground ,tokyodark-git-change))))
         `(git-gutter:unchanged ((,class (:background ,tokyodark-bg-highlight))))

;;;;; git-gutter-fr
         `(git-gutter-fr:added ((,class (:foreground ,tokyodark-git-add))))
         `(git-gutter-fr:deleted ((,class (:foreground ,tokyodark-git-delete))))
         `(git-gutter-fr:modified ((,class (:foreground ,tokyodark-git-change))))

;;;;; highlight-numbers
         `(highlight-numbers-number ((,class (:foreground ,tokyodark-orange))))

;;;;; multiple-cursors
         `(mc/cursor-face ((,class (:inverse-video nil :background ,tokyodark-bg-highlight :foreground ,tokyodark-fg))))
         `(mc/cursor-bar-face ((,class (:background ,tokyodark-fg :height 1))))
         `(mc/region-face ((,class (:inherit region))))

;;;;; neotree
         `(neo-banner-face ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(neo-header-face ((,class (:foreground ,tokyodark-fg))))
         `(neo-root-dir-face ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(neo-dir-link-face ((,class (:foreground ,tokyodark-blue))))
         `(neo-file-link-face ((,class (:foreground ,tokyodark-fg))))
         `(neo-expand-btn-face ((,class (:foreground ,tokyodark-grey))))
         `(neo-vc-default-face ((,class (:foreground ,tokyodark-fg))))
         `(neo-vc-up-to-date-face ((,class (:foreground ,tokyodark-fg))))
         `(neo-vc-edited-face ((,class (:foreground ,tokyodark-git-change))))
         `(neo-vc-needs-merge-face ((,class (:foreground ,tokyodark-orange))))
         `(neo-vc-added-face ((,class (:foreground ,tokyodark-git-add))))
         `(neo-vc-conflict-face ((,class (:foreground ,tokyodark-red :weight bold))))
         `(neo-vc-missing-face ((,class (:foreground ,tokyodark-red))))
         `(neo-vc-ignored-face ((,class (:foreground ,tokyodark-grey))))

;;;;; nerd-icons
         `(nerd-icons-red ((,class (:foreground ,tokyodark-red))))
         `(nerd-icons-lred ((,class (:foreground ,tokyodark-red))))
         `(nerd-icons-dred ((,class (:foreground ,tokyodark-red))))
         `(nerd-icons-green ((,class (:foreground ,tokyodark-green))))
         `(nerd-icons-lgreen ((,class (:foreground ,tokyodark-green))))
         `(nerd-icons-dgreen ((,class (:foreground ,tokyodark-green))))
         `(nerd-icons-yellow ((,class (:foreground ,tokyodark-yellow))))
         `(nerd-icons-lyellow ((,class (:foreground ,tokyodark-yellow))))
         `(nerd-icons-dyellow ((,class (:foreground ,tokyodark-orange))))
         `(nerd-icons-blue ((,class (:foreground ,tokyodark-blue))))
         `(nerd-icons-lblue ((,class (:foreground ,tokyodark-cyan))))
         `(nerd-icons-dblue ((,class (:foreground ,tokyodark-blue))))
         `(nerd-icons-maroon ((,class (:foreground ,tokyodark-red))))
         `(nerd-icons-lmaroon ((,class (:foreground ,tokyodark-red))))
         `(nerd-icons-dmaroon ((,class (:foreground ,tokyodark-red))))
         `(nerd-icons-purple ((,class (:foreground ,tokyodark-purple))))
         `(nerd-icons-lpurple ((,class (:foreground ,tokyodark-purple))))
         `(nerd-icons-dpurple ((,class (:foreground ,tokyodark-purple))))
         `(nerd-icons-orange ((,class (:foreground ,tokyodark-orange))))
         `(nerd-icons-lorange ((,class (:foreground ,tokyodark-orange))))
         `(nerd-icons-dorange ((,class (:foreground ,tokyodark-orange))))
         `(nerd-icons-cyan ((,class (:foreground ,tokyodark-cyan))))
         `(nerd-icons-lcyan ((,class (:foreground ,tokyodark-blue))))
         `(nerd-icons-dcyan ((,class (:foreground ,tokyodark-cyan))))
         `(nerd-icons-pink ((,class (:foreground ,tokyodark-red))))
         `(nerd-icons-lpink ((,class (:foreground ,tokyodark-red))))
         `(nerd-icons-dpink ((,class (:foreground ,tokyodark-red))))
         `(nerd-icons-silver ((,class (:foreground ,tokyodark-fg))))
         `(nerd-icons-lsilver ((,class (:foreground ,tokyodark-fg))))
         `(nerd-icons-dsilver ((,class (:foreground ,tokyodark-grey))))

;;;;; perspective
         `(persp-selected-face ((,class (:foreground ,tokyodark-blue :weight bold))))

;;;;; solaire
         `(solaire-default-face ((,class (:background ,tokyodark-bg-dark :foreground ,tokyodark-fg))))
         `(solaire-minibuffer-face ((,class (:background ,tokyodark-bg-dark :foreground ,tokyodark-fg))))
         `(solaire-hl-line-face ((,class (:background ,tokyodark-bg-highlight))))
         `(solaire-line-number-face ((,class (:background ,tokyodark-bg-dark :foreground ,tokyodark-grey))))
         `(solaire-mode-line-face ((,class (:background ,tokyodark-bg-dark))))
         `(solaire-mode-line-inactive-face ((,class (:background ,tokyodark-black))))
         `(solaire-org-hide-face ((,class (:foreground ,tokyodark-bg-dark))))

;;;;; undo-tree
         `(undo-tree-visualizer-active-branch-face ((,class (:foreground ,tokyodark-fg :weight bold))))
         `(undo-tree-visualizer-current-face ((,class (:foreground ,tokyodark-red))))
         `(undo-tree-visualizer-default-face ((,class (:foreground ,tokyodark-grey))))
         `(undo-tree-visualizer-register-face ((,class (:foreground ,tokyodark-yellow))))
         `(undo-tree-visualizer-unmodified-face ((,class (:foreground ,tokyodark-cyan))))

;;;;; vundo
         `(vundo-node ((,class (:foreground ,tokyodark-grey))))
         `(vundo-stem ((,class (:foreground ,tokyodark-grey))))
         `(vundo-branch-stem ((,class (:foreground ,tokyodark-bg5))))
         `(vundo-highlight ((,class (:foreground ,tokyodark-blue :weight bold))))
         `(vundo-saved ((,class (:foreground ,tokyodark-green))))
         `(vundo-last-saved ((,class (:foreground ,tokyodark-green :weight bold))))
         `(vundo-diff-highlight ((,class (:foreground ,tokyodark-orange :weight bold))))

;;;;; volatile-highlights
         `(vhl/default-face ((,class (:background ,tokyodark-selection))))

;;;;; wgrep
         `(wgrep-face ((,class (:foreground ,tokyodark-green :background ,tokyodark-diff-add))))
         `(wgrep-delete-face ((,class (:foreground ,tokyodark-red :background ,tokyodark-diff-delete))))
         `(wgrep-done-face ((,class (:foreground ,tokyodark-blue))))
         `(wgrep-file-face ((,class (:foreground ,tokyodark-grey))))
         `(wgrep-reject-face ((,class (:foreground ,tokyodark-red :weight bold)))))

        (custom-theme-set-variables
         theme-name

;;;;; ansi-color
         `(ansi-color-names-vector
           [,tokyodark-bg-dark ,tokyodark-red ,tokyodark-green ,tokyodark-yellow
            ,tokyodark-blue ,tokyodark-purple ,tokyodark-cyan ,tokyodark-fg])

;;;;; pdf-view
         `(pdf-view-midnight-colors '(,tokyodark-fg . ,tokyodark-bg)))))))

;;; Hooks

(defcustom tokyodark-after-load-hook nil
  "Hook run after the Tokyo Dark theme is loaded.
Each function is called with the theme name (a symbol) as its
sole argument.  Useful for applying additional customizations
that depend on theme colors being set."
  :type 'hook
  :group 'tokyodark)

;;; Palette API

(defun tokyodark-get-color (name)
  "Return the hex color value for NAME from the Tokyo Dark palette.
NAME is a string like \"tokyodark-blue\".  User overrides from
`tokyodark-override-colors-alist' are respected."
  (let ((merged (append tokyodark-override-colors-alist tokyodark-colors-alist)))
    (cdr (assoc name merged))))

;;;###autoload
(defmacro tokyodark-with-colors (&rest body)
  "Bind all palette colors and evaluate BODY.
Inside BODY, each palette color is available as a local variable,
e.g. `tokyodark-blue', `tokyodark-bg', etc.

Example:
  (tokyodark-with-colors
    (set-face-attribute \\='some-face nil :foreground tokyodark-blue))"
  (declare (indent 0))
  `(let* ((--tokyodark-palette
            (append tokyodark-override-colors-alist tokyodark-colors-alist))
          ,@(mapcar (lambda (entry)
                      `(,(intern (car entry))
                        (cdr (assoc ,(car entry) --tokyodark-palette))))
                    tokyodark-colors-alist))
     ,@body))

;;; Interactive Palette Viewer

(defun tokyodark-list-colors ()
  "Display all palette colors for the Tokyo Dark theme."
  (interactive)
  (let* ((merged (append tokyodark-override-colors-alist tokyodark-colors-alist))
         (buf (get-buffer-create "*Tokyo Dark Palette*")))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert "Tokyo Dark Palette\n\n")
        (dolist (entry merged)
          (let ((name (car entry))
                (color (cdr entry)))
            (insert (format "  %-30s  %s  " name color))
            (insert (propertize "  sample  "
                                'face `(:foreground ,color)))
            (insert (propertize "  sample  "
                                'face `(:background ,color
                                        :foreground ,(if (< (tokyodark--relative-luminance color) 0.5)
                                                         "#ffffff" "#000000"))))
            (insert "\n")))
        (goto-char (point-min)))
      (special-mode))
    (pop-to-buffer buf)))

(defun tokyodark--relative-luminance (hex)
  "Return the relative luminance of HEX color string.
Uses the WCAG 2.0 formula."
  (let* ((rgb (color-name-to-rgb hex))
         (r (nth 0 rgb))
         (g (nth 1 rgb))
         (b (nth 2 rgb))
         (adjust (lambda (c)
                   (if (<= c 0.03928)
                       (/ c 12.92)
                     (expt (/ (+ c 0.055) 1.055) 2.4)))))
    (+ (* 0.2126 (funcall adjust r))
       (* 0.7152 (funcall adjust g))
       (* 0.0722 (funcall adjust b)))))

;;; User Commands

;;;###autoload
(defun tokyodark-reload ()
  "Reload the Tokyo Dark theme.
Useful after changing `tokyodark-override-colors-alist' or
`tokyodark-scale-headings' without having to call `load-theme'
manually."
  (interactive)
  (if (memq 'tokyodark custom-enabled-themes)
      (progn
        (load-theme 'tokyodark t)
        (run-hook-with-args 'tokyodark-after-load-hook 'tokyodark))
    (user-error "Tokyo Dark theme is not currently active")))

(provide 'tokyodark)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:

;;; tokyodark.el ends here
