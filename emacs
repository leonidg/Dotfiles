;; Don't show startup screen
(setq inhibit-splash-screen t)

;; Enable multiple minibuffers
(setq minibuffer-max-depth nil)

;; Show column numbers
(column-number-mode 1)

;; Don't make the stupid file~ backup files
(setq make-backup-files nil) 

;; Use K&R
(setq c-default-style
      '((other . "k&r")))
(setq-default indent-tabs-mode nil) ;; use spaces instead of tabs
(setq c-basic-offset 4) ;; set 4-space indentation as default

;; Various mode hooks
(setq auto-mode-alist  (cons '(".rhtml$" . html-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.htacces\\'" . apache-conf-generic-mode))
(add-hook 'java-mode-hook (lambda ()
                                (setq c-basic-offset 4
                                      tab-width 4
                                      indent-tabs-mode nil)))

(add-hook 'c-mode-hook (lambda ()
			 (setq c-basic-offset 4
			       tab-width 4
			       indent-tabs-mode nil)))

;; Show comments as red
(set-face-foreground 'font-lock-comment-face "red")

;; Match parens
(show-paren-mode t) 

;; Allow y/n for yes/no prompts
(fset 'yes-or-no-p 'y-or-n-p)

;; Enable certain "advanced" commands
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Highlight region between mark and pointer
(transient-mark-mode 1)

;; Shortcut to display word count
(defun word-count nil "Count words in buffer" (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))
(global-set-key "" 'word-count)

;; Nice shortcut for enabling auto-fill-mode
(global-set-key "" 'auto-fill-mode)


;; Stupid little functions for creating ASCII underlines

(defun underline (char)
  "Underlines the previous line by placing the supplied CHARACTER underneath each character of the line.
In principle, the character can be a string, a number or anything
else. However, this function is not intended to be run by the
user, so it shouldn't be an issue"
  (defun print-a-lot (remain)
    "Prints the CHARACTER given to the parent (underline...) the
NUMBER of times supplied by 'remainder'"
    (if (> remain 0)
        (save-excursion
         (insert char)
         (print-a-lot (- remain 1)))
      (newline)))
  (save-excursion
    (previous-line)
    (end-of-line)
    (let ((end (point)))
      (beginning-of-line)
      (let ((length (- end (point))))
        (next-line)
        (beginning-of-line)
        (print-a-lot length))))
  (next-line))

(defun wide-underline ()
  "Makes wide underline (=)"
  (interactive)
  (underline "="))

(defun narrow-underline ()
  "Makes narrow underline (-)"
  (interactive)
  (underline "-"))

(global-set-key "=" 'wide-underline)
(global-set-key "-" 'narrow-underline)


;; Navigation shortcuts
;; This is actually pretty non-portable and should detect the
;; OS... I'm too lazy to do it right, though.
(define-key global-map "O1;5A"   [C-up])
(define-key global-map "O1;5B"   [C-down])
(define-key global-map "O1;5D"   [C-left])
(define-key global-map "O1;5C"   [C-right])

(global-set-key "[1;5A" 'backward-paragraph)
(global-set-key "[1;5B" 'forward-paragraph)
(global-set-key "[1;5C" 'forward-word)
(global-set-key "[1;5D" 'backward-word)

(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

(global-set-key "#" 'comment-region)
(global-set-key "\\" 'uncomment-region)

;; Enable generic mode
;; Useful for a lot of common filetypes
(require 'generic-x)

;; Disable alarms
(setq ring-bell-function 'ignore)

;; Load site-specific configuration options
(load "~/.emacs_local" t)
