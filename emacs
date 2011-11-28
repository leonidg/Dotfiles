(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(LaTeX-command "pdflatex")
 '(TeX-output-view-style (quote (("^dvi$" ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$") "%(o?)dvips -t landscape %d -o && gv %f") ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "%(o?)dvips %d -o && gv %f") ("^dvi$" ("^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "^landscape$") "%(o?)xdvi %dS -paper a4r -s 0 %d") ("^dvi$" "^a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4$" "%(o?)xdvi %dS -paper a4 %d") ("^dvi$" ("^a5\\(?:comb\\|paper\\)$" "^landscape$") "%(o?)xdvi %dS -paper a5r -s 0 %d") ("^dvi$" "^a5\\(?:comb\\|paper\\)$" "%(o?)xdvi %dS -paper a5 %d") ("^dvi$" "^b5paper$" "%(o?)xdvi %dS -paper b5 %d") ("^dvi$" "^letterpaper$" "%(o?)xdvi %dS -paper us %d") ("^dvi$" "^legalpaper$" "%(o?)xdvi %dS -paper legal %d") ("^dvi$" "^executivepaper$" "%(o?)xdvi %dS -paper 7.25x10.5in %d") ("^dvi$" "." "%(o?)xdvi %dS %d") ("^pdf$" "." "okular %o") ("^html?$" "." "firefox %o"))))
 '(TeX-style-path (quote ("style" "auto" "/usr/share/emacs/site-lisp/auctex/style" "/var/auctex" "/home/hahafaha/latex")))
 '(c++-mode-hook (quote ((lambda nil (c-set-style "bsd")) (lambda nil (setq c-basic-offset 4)))))
 '(c-default-style (quote ((java-mode . "java") (other . "gnu"))))
 '(c-mode-hook (quote ((lambda nil (c-set-style "bsd")) (lambda nil (setq c-basic-offset 4)))))
 '(c-offsets-alist (quote ((inline-open . 4))))
 '(case-fold-search t)
 '(column-number-mode t)
 '(default-input-method "latin-1-prefix")
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(java-mode-hook (quote ((lambda nil (c-set-style "bsd")) (lambda nil (setq c-basic-offset 4)))))
 '(load-home-init-file t t)
 '(mouse-wheel-mode t nil (mwheel))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(tab-width 8)
 '(transient-mark-mode t)
 '(x-select-enable-clipboard t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;; Enable multiple minibuffers
(setq minibuffer-max-depth nil)

;; Show column numbers
(column-number-mode 1)

;; Don't make the stupid file~ backup files
(setq make-backup-files nil) 

;; Various mode hooks
(setq auto-mode-alist  (cons '(".rhtml$" . html-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.htacces\\'" . apache-conf-generic-mode))

;; Don't indent tabs
(setq-default indent-tabs-mode nil) 

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

;; Shortcut to disable word count
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

;; Enable generic mode
;; Useful for a lot of common filetypes
(require 'generic-x)

;; Load site-specific configuration options
(load "~/.emacs_local" t)
