;;; tokyodark-theme.el --- Tokyo Dark theme -*- lexical-binding: t; -*-

;; Copyright (C) 2026

;; Author: koftamainee

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

;; The Tokyo Dark theme for Emacs, ported from eneriaa/tokyo-dark.nvim.
;; See `tokyodark.el' for the shared infrastructure.

;;; Code:

(require 'tokyodark)

(deftheme tokyodark "A dark theme inspired by Tokyo, ported from tokyodark.nvim.")

(tokyodark--apply-theme 'tokyodark tokyodark-colors-alist)

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'tokyodark)

(provide 'tokyodark-theme)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:

;;; tokyodark-theme.el ends here
