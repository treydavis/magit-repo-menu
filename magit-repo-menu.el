(define-derived-mode repo-menu-mode tabulated-list-mode "Repo Menu" 
  "Major mode repo-menu-mode, for displaying a list of repos, sourced from a special file"
  (setq tabulated-list-format [("repo" 40 nil)
                               ("location" 12 nil)])
  (setq tabulated-list-padding 2)
  (tabulated-list-init-header)
  (define-key repo-menu-mode-map (kbd "RET") 'magit-connect)
  (define-key repo-menu-mode-map (kbd "g") 'print-list))

(defun magit-connect ()
  (interactive)
  (message (concat "current line ID is: " (tabulated-list-get-id)))
  (magit-status (tabulated-list-get-id)))

(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun emacs-path (p)
  (format "%s%s" user-emacs-directory p))

(defun print-list ()
  (interactive)
  (setq tabulated-list-entries (read (get-string-from-file (emacs-path "reposlist"))))
  (tabulated-list-print t))

(defun magit-repo-menu ()
  (interactive)
  (pop-to-buffer "*REPO MENU MODE*" nil)
  (repo-menu-mode)
  (print-list))
