;; ----------------------------------------------------------------------------
;; adding better-defaults.el
;; ----------------------------------------------------------------------------
(load-library "~/.emacs.d/better-defaults.el")
(require 'better-defaults)

;; ----------------------------------------------------------------------------
;; display the column number on bottom bar
;; ----------------------------------------------------------------------------
(column-number-mode 1) ; display column number on status bar

;; ----------------------------------------------------------------------------
;; disable the backup
;; ----------------------------------------------------------------------------
(setq backup-inhibited t)

;; ----------------------------------------------------------------------------
;; disable auto save files
;; ----------------------------------------------------------------------------
(setq auto-save-default nil)

;; ----------------------------------------------------------------------------
;; adding xcscope.el
;; ----------------------------------------------------------------------------
(load-library "~/.emacs.d/packages/xcscope.el")

;; ----------------------------------------------------------------------------
;; ediff-trees.elff
;; ----------------------------------------------------------------------------
(load-file "~/.emacs.d/packages/ediff-trees.el")

;; tab, indent
(setq-default tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48))
(setq-default indent-tabs-mode t)   ;tab default setting

;; C mode tab
(add-hook 'c-mode-hook'
          (lambda ()
            (c-set-style "bsd")
            (setq default-tab-width 4)
            (setq c-basic-offset 4) ;; indent use only 2 blank
            (setq indent-tabs-mode t) ;; no tab
            ))

;; C++ mode tab
(add-hook 'c++-mode-hook'
          (lambda ()
            (setq default-tab-width 4)
            (setq indent-tabs-mode t) ;; no tab
            ))

(delete-selection-mode 1)		; 
(setq-default truncate-lines t) ; 

;; ----------------------------------------------------------------------------
;; configuration for etags select
;; ----------------------------------------------------------------------------
(load-file "~/.emacs.d/packages/etags-select.el")
(require 'etags-select)
(global-set-key "\M-?" 'etags-select-find-tag-at-point)
(global-set-key "\M-." 'etags-select-find-tag)

;; ----------------------------------------------------------------------------
;; configuration for enablling the recurive deleting directory
;; ----------------------------------------------------------------------------
(setq dired-recursive-deletes 'top)	;; dired - recursive delete directory

;; ----------------------------------------------------------------------------
;; emacs server settings
;; ----------------------------------------------------------------------------
(if (not (equal window-system 'nil))
	(require 'server) (when (and (= emacs-major-version 23) (= emacs-minor-version 4) (equal window-system 'w32)) (defun server-ensure-safe-dir (dir) "Noop" t))
	;; Suppress error directory ~/.emacs.d/server is unsafe on windows.
	(server-start)
)

;; ----------------------------------------------------------------------------
;; Cygwin Setting for cygwin-mount.el
;; ----------------------------------------------------------------------------
;; (setenv "PATH" (concat "c:/cygwin/bin;" (getenv "PATH")))
;; (setq exec-path (cons "c:/cygwin/bin/" exec-path))
;; (require 'cygwin-mount)
;; (cygwin-mount-activate)

;; Replace the dos command window to bash of cygwin
;; (add-hook 'comint-output-filter-functions
;; 		  'shell-strip-ctrl-m nil t)
;; (add-hook 'comint-output-filter-functions
;; 		  'comint-watch-for-password-prompt nil t)
;; (setq explicit-shell-file-name "bash.exe")
;; For subprocesses invoked via the shell
;; (e.g., "shell -c command")
;; (setq shell-file-name explicit-shell-file-name)

;;------------------------------------------------------------------------
;; org mode Settings
;;------------------------------------------------------------------------
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
;; setting org files for org-agenda
(setq org-agenda-files (list "~/org/Task.org" "~/org/Schedule.org" "~/org/notes.org"))

(setq org-directory "~/org/")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/Task.org" "Tasks")
		 "* TODO %?\n  %i\n  %a")
        ("i" "Ideas" entry (file+datetree "~/org/notes.org")
		 "* %?\nIdeas %U\n  %i\n  %a")))

;;------------------------------------------------------------------------
;; Dired+ Setting
;;------------------------------------------------------------------------
(toggle-diredp-find-file-reuse-dir 1)

;;------------------------------------------------------------------------
;; naver dictionary Settings
;;------------------------------------------------------------------------
(defun search-naver-dic ()
  (interactive)
  (browse-url (concat "http://endic.naver.com/search.naver?mode=all&x=0&y=0&query="
                      (thing-at-point 'word))))
(define-key mode-specific-map "d" 'search-naver-dic)