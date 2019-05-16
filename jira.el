;;; Jira --- A simple wrapper around go-jira

;;; Commentary:

;;; Emacs integration for go-jira[1].
;;; [1]: https://github.com/Netflix-Skunkworks/go-jira)

;;; Code:

(provide 'jira)
(require 'transient)

(defun jira-list ()
  "Insert Jira issues."
  (interactive)
  (insert (shell-command-to-string "jira list")))

(defun jira-mine ()
  "Insert Jira issues assigned to you."
  (interactive)
  (insert (shell-command-to-string "jira mine")))

(defun jira-view ()
  "Prompt for a Jira issue and display details for it."
  (interactive)
  (let ((ticket (read-string "Ticket: ")))
    (insert (shell-command-to-string
             (format "jira view %s" ticket)))))

(defun jira-epic ()
  "Prompt for a Jira epic and display it's issues."
  (interactive)
  (let ((ticket (read-string "Epic: ")))
    (insert (shell-command-to-string
             (format "jira epic list %s" ticket)))))

(define-transient-command jira ()
  "Invoke a Jira command from a list of available commands."
  ["Available commands"
   [("l" "List" jira-list)
    ("m" "Mine" jira-mine)
    ("v" "View" jira-view)
    ("e" "Epic" jira-epic)]])

;;; jira.el ends here
