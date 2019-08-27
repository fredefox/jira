;;; Jira --- A simple wrapper around go-jira

;;; Commentary:

;;; Emacs integration for go-jira[1].
;;; [1]: https://github.com/Netflix-Skunkworks/go-jira)

;;; Code:

(provide 'jira)
(require 'transient)

(defun jira-list (beg end)
  "Insert all Jira issues.

Insert it between BEG and END."
  (interactive "r")
  (shell-command-on-region beg end "jira list" nil t))

(defun jira-mine (beg end)
  "Insert Jira issues assigned.

Insert it between BEG and END."
  (interactive "r")
  (shell-command-on-region beg end "jira mine" nil t))

(defun jira-view (beg end)
  "Prompt for a Jira issue and display details for it.

Insert it between BEG and END."
  (interactive "r")
  (let ((ticket (read-string "Ticket: ")))
    (insert (shell-command-to-string
             (format "jira view %s" ticket)))))

(defun jira-epic (beg end)
  "Prompt for a Jira epic and display it's issues.

Insert it between BEG and END."
  (interactive "r")
  (let ((ticket (read-string "Epic: ")))
    (shell-command-on-region beg end (format "jira epic list %s" ticket) nil t)))


(defun jira-reopen ()
  "Prompt for a Jira issue and reopens it."

  (interactive)
  (let ((ticket (read-string "Ticket: ")))
    (shell-command (format "jira reopen %s" ticket))))

(defun jira-close ()
  "Prompt for a Jira issue and closes it."

  (interactive)
  (let ((ticket (read-string "Ticket: ")))
    (shell-command (format "jira close %s" ticket))))

(define-transient-command jira ()
  "Invoke a Jira command from a list of available commands."
  ["Displaying tickets"
   [("l" "List" jira-list)
    ("m" "Mine" jira-mine)
    ("v" "View" jira-view)
    ("e" "Epic" jira-epic)]]
  ["Modifying tickets"
   ("o" "Reopen" jira-reopen)
   ("c" "Close" jira-close)])

;;; jira.el ends here
