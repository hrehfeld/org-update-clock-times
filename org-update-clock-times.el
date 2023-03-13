;;; package --- Summary  -*- lexical-binding: t; -*-
;;; Author: Hauke Rehfeld <emacs@haukerehfeld.de>
;;; Version: 0.1
;;; Package-Requires: (org)
;;; Keywords: convenience
;;; URL: https://github.com/hrehfeld/org-update-clock-times
;;; Commentary:

;;; Code:
(defun org-update-clock-times-map (fun)
  "Map FUN over all clock times in the buffer.

FUN is called with no arguments."
  (save-excursion
    (let ((doc (org-element-parse-buffer)))
      (org-element-map doc 'clock (lambda (e)
                                    (let ((begin (org-element-property :begin e))
                                          (end (org-element-property :end e)))
                                      ;;(message "my-org-update-clock-times: %S %S %s" begin end (buffer-substring-no-properties begin end))
                                      ;; go to middle between begin and end
                                      (goto-char (+ begin (round (- end begin) 2)))
                                      (funcall fun)))))))

(defun org-update-clock-times ()
  "Update clock times in the current buffer."
  (interactive)
  (cl-assert (derived-mode-p 'org-mode))
  (message "updating clock times, this might take a while...")
  (org-update-clock-times-map #'org-clock-update-time-maybe))

(provide 'org-update-clock-times)
;;; org-update-clock-times.el ends here
