;;; Pacote contendo funcionalidades para lidar com notas em vaults obsidian -*- lexical-binding: t; -*-

(defun fill-template (template-text title)
  "Replace {{title}} and {{date}} placeholders in TEMPLATE-TEXT."
  (let* ((step1 (replace-regexp-in-string "{{title}}" title template-text))
         (step2 (replace-regexp-in-string "{{date}}" (format-time-string "%Y-%m-%d") step1)))
    step2))


(defun read-file-as-string (path)
  "Return the contents of the file at PATH as a string."
  (with-temp-buffer
    (insert-file-contents path)
    (buffer-string)))


;;;###autoload
(defun new-note-from-template ()
  "Create a new note from a template, filling in title and date."
  (interactive)
  (let* ((template-path (read-file-name "Template: " "~/Documents/Pessoal/0 Recursos/Modelos/"))
         (title (read-string "Note title: "))
         (template-text (read-file-as-string template-path))
         (filled-text (fill-template template-text title))
         (target-path (expand-file-name (concat title ".md") "~/temp/")))
    (write-region filled-text nil target-path)
    (find-file target-path)))

(provide 'obsidi.el)
