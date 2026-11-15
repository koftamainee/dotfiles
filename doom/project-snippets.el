;;; project-snippets.el --- Project-local file templates -*- lexical-binding: t; -*-

;; Generic support for project-local file templates.
;;
;; Templates are looked up in the current project root:
;;
;;   .snippets/<major-mode>/<trigger>
;;   .snippets/file-templates/<trigger>
;;
;; A trigger is the template's file name. For a file named `Foo.cpp' the
;; candidates are `__Foo.cpp', `__Foo', `__cpp' and `__'. Mode-specific
;; directories are searched before `file-templates', so the latter is useful
;; for templates that should apply regardless of the exact major mode (for
;; example, C++ headers that may open as either `c-mode' or `c++-mode').
;;
;; Each template is a regular yasnippet file; only the body after the `# --'
;; separator is used.

(defvar +project-file-templates-dir ".snippets"
  "Directory, relative to a project root, containing its file templates.")

(defun +project-file-templates--root (&optional file)
  "Return the project root for FILE, or nil."
  (when-let* ((file (or file buffer-file-name)))
    (or (doom-project-root (file-name-directory file))
        (locate-dominating-file file ".git"))))

(defun +project-file-templates--path-part (n)
  "Return the Nth component of the current file's project-relative path."
  (when-let* ((file buffer-file-name)
              (root (+project-file-templates--root file))
              (rel  (file-relative-name file root)))
    (nth n (split-string rel "/"))))

(defun +project-file-templates--triggers (file)
  "Return candidate trigger names for FILE, most specific first."
  (let ((base (file-name-nondirectory file))
        (stem (file-name-base file))
        (ext  (file-name-extension file)))
    (delete-dups
     (delq nil
           (list (concat "__" base)
                 (concat "__" stem)
                 (and ext (concat "__" ext))
                 "__")))))

(defun +project-file-templates--candidates (&optional file)
  "Return project-local template files for FILE, most specific first."
  (when-let* ((file (or file buffer-file-name))
              (root (+project-file-templates--root file))
              (base (expand-file-name +project-file-templates-dir root))
              (modes (delete-dups
                      (cons major-mode
                            (get major-mode 'derived-mode-extra-parents)))))
    (let ((triggers (+project-file-templates--triggers file)))
      (cl-loop for dir in (append
                           (mapcar (lambda (mode)
                                     (expand-file-name (symbol-name mode) base))
                                   modes)
                           (list (expand-file-name "file-templates" base)))
               when (file-directory-p dir)
               append (cl-loop for trigger in triggers
                               for path = (expand-file-name trigger dir)
                               when (file-readable-p path)
                               collect path)))))

(defun +project-file-templates--available-p (&optional file)
  "Return non-nil if a project-local file template exists for FILE."
  (car (+project-file-templates--candidates file)))

(defun +project-file-templates--body (file)
  "Return the yasnippet body from FILE."
  (with-temp-buffer
    (insert-file-contents file)
    (goto-char (point-min))
    (if (re-search-forward "^# --\\s-*\n" nil t)
        (buffer-substring-no-properties (point) (point-max))
      (buffer-substring-no-properties (point-min) (point-max)))))

(defun +project-file-templates--ensure-yas ()
  "Make sure yasnippet is active in the current buffer."
  (require 'yasnippet)
  (unless yas-minor-mode
    ;; Call `yas-minor-mode' directly: `yas-minor-mode-on' honours
    ;; `yas-dont-activate-functions', which would keep file templates from
    ;; expanding in otherwise valid file buffers.
    (yas-minor-mode 1))
  ;; `yas-minor-mode' only installs its post-command handler when it is first
  ;; enabled in a buffer, so make sure it is there before expanding.
  (unless (memq #'yas--post-command-handler post-command-hook)
    (add-hook 'post-command-hook #'yas--post-command-handler nil t)))

(defun +project-file-templates--expand ()
  "Expand the project-local file template for the current buffer."
  (if-let* ((file (+project-file-templates--available-p)))
      (progn
        (+project-file-templates--ensure-yas)
        (yas-expand-snippet (+project-file-templates--body file))
        (when (and (featurep 'evil) evil-local-mode)
          (evil-insert-state)))
    (user-error "No project-local file template for this buffer")))

(set-file-template! ""
  :when #'+project-file-templates--available-p
  :trigger #'+project-file-templates--expand)


;;
;; Project-level settings

;; Let projects define `find-sibling-rules' in their .dir-locals.el without
;; Emacs prompting about an unsafe local variable.
(put 'find-sibling-rules 'safe-local-variable
     (lambda (value)
       (and (listp value) (seq-every-p #'consp value))))

;; Let projects declare an apheleia formatter chain before apheleia itself is
;; loaded.  Its own definition has the same shape.
(put 'apheleia-formatter 'safe-local-variable
     (lambda (value)
       (or (symbolp value)
           (and (listp value) (seq-every-p #'symbolp value)))))

;; New, empty .h files should open as C++ rather than C. Doom only consults
;; this when its own heuristics fail, e.g. when there is no sibling .cpp.
(setq +cc-default-header-file-mode 'c++-mode)

;; Projects that ship Scripts/format_includes.py can chain it after
;; clang-format in apheleia (see the project's .dir-locals.el).  Register the
;; formatter with an absolute path per buffer so unrelated C++ projects are
;; unaffected.
(defun +project-includes--register ()
  "Register the project include formatter for the current C++ buffer."
  (when (and buffer-file-name
             (derived-mode-p 'c++-ts-mode 'c++-mode))
    (when-let* ((root (locate-dominating-file
                       buffer-file-name "Scripts/format_includes.py"))
                ((require 'apheleia-formatters nil t)))
      (let ((script (expand-file-name "Scripts/format_includes.py" root)))
        (unless (local-variable-p 'apheleia-formatters)
          (setq-local apheleia-formatters
                      (copy-tree apheleia-formatters)))
        (setf (alist-get 'project-includes apheleia-formatters)
              (list "python3" script "--stdin" 'filepath))
        (unless apheleia-formatter
          (setq-local apheleia-formatter
                      '(clang-format project-includes)))))))

(add-hook 'hack-local-variables-hook #'+project-includes--register)

;;; project-snippets.el ends here
