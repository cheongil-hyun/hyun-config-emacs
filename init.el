;; ----------------------------------------------------------------------------
;; adding better-defaults.el
;; ----------------------------------------------------------------------------
(load-library "~/.emacs.d/better-defaults.el")
(require 'better-defaults)

;; ----------------------------------------------------------------------------
;; adding the package sources
;; ----------------------------------------------------------------------------
(if (< emacs-major-version 24)
	(load-library "~/.emacs.d/packages/package.el")
)
(require 'package)
;; (dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
;; 				  ("melpa" . "http://melpa.milkbox.net/packages/")))
;;   (add-to-list 'package-archives source t))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; ----------------------------------------------------------------------------
;; display the column number on bottom bar
;; ----------------------------------------------------------------------------
(column-number-mode 1) ; display column number on status bar

;; ----------------------------------------------------------------------------
;; setting for welcom screen : disable
;; ----------------------------------------------------------------------------
(setq inhibit-splash-screen t)

;; ----------------------------------------------------------------------------
;; Compilation output buffer auto scroll
;; ----------------------------------------------------------------------------
(setq compilation-scroll-output t)

;; ----------------------------------------------------------------------------
;; emacs auto reloading when file was changed from external program
;; ----------------------------------------------------------------------------
(global-auto-revert-mode 1)

;; ----------------------------------------------------------------------------
;; Yes and No
;; ----------------------------------------------------------------------------
(defalias 'yes-or-no-p 'y-or-n-p)

;; ----------------------------------------------------------------------------
;; disable the backup
;; ----------------------------------------------------------------------------
(setq backup-inhibited t)

;; ----------------------------------------------------------------------------
;; disable auto save files
;; ----------------------------------------------------------------------------
(setq auto-save-default nil)

;; ----------------------------------------------------------------------------
;; color theme setting for wombat
;; ----------------------------------------------------------------------------
(if (>= emacs-major-version 24)
    (load-theme 'wombat t)
)

;; ----------------------------------------------------------------------------
;; adding xcscope.el
;; ----------------------------------------------------------------------------
(load-library "~/.emacs.d/packages/xcscope.el")
(require 'xcscope)
(setq cscope-do-not-update-database t)  ;; do not update the cscope files

;; ----------------------------------------------------------------------------
;; ediff-trees.elff
;; ----------------------------------------------------------------------------
(load-file "~/.emacs.d/packages/ediff-trees.el")

;; ----------------------------------------------------------------------------
;; ediff set default to horizontally
;; ----------------------------------------------------------------------------
(setq ediff-split-window-function 'split-window-horizontally
      ediff-window-setup-function 'ediff-setup-windows-plain)

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

;; ----------------------------------------------------------------------------
;; enable the cwarn mode
;; ----------------------------------------------------------------------------
(global-cwarn-mode 1)

;; C++ mode tab
(add-hook 'c++-mode-hook'
          (lambda ()
            (setq default-tab-width 4)
            (setq indent-tabs-mode t) ;; no tab
            ))

(delete-selection-mode 1)		;
(setq-default truncate-lines t) ;


;; ----------------------------------------------------------------------------
;; org mode auto indent mode enable
;; ----------------------------------------------------------------------------
(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode t)
			(auto-fill-mode 1)
			)
          t)

;; ----------------------------------------------------------------------------
;; configuration for etags select
;; ----------------------------------------------------------------------------
(load-file "~/.emacs.d/packages/etags-select.el")
(require 'etags-select)
(global-set-key "\M-?" 'etags-select-find-tag-at-point)
(global-set-key "\M-." 'etags-select-find-tag)

;; ----------------------------------------------------------------------------
;; C coding style setting now linux
;; ----------------------------------------------------------------------------
(setq c-default-style "linux")
;; (setq c-default-style "k&r")
;; (setq c-default-style "cc-mode")
;; (setq c-default-style "gnu")
;; (setq c-default-style "bsd")
;; (setq c-default-style "stroustrup")
;; (setq c-default-style "whitesmith")

;; ----------------------------------------------------------------------------
;  korean font setting - cygwin emacs does not support
;; ----------------------------------------------------------------------------
(when window-system
  (set-fontset-font "fontset-default" '(#x1100 . #xffdc)  '("NanumGothicCoding" . "unicode-bmp"))
  (set-fontset-font "fontset-default" '(#xe0bc . #xf66e)  '("NanumGothicCoding" . "unicode-bmp"))
  (set-fontset-font "fontset-default" 'kana '("Meiryo" . "unicode-bmp"))
  (set-fontset-font "fontset-default" 'han '("Microsoft YaHei". "unicode-bmp"))
)

;; (set-language-environment "Korean")
(setq default-input-method "korean-hangul")

;; ----------------------------------------------------------------------------
;; configuration for yasnippet
;; should be loaded before auto complete so that they can work together
;; ----------------------------------------------------------------------------
(require 'yasnippet)
(yas-global-mode 1)

;; ----------------------------------------------------------------------------
;; configuration for auto complete mod
;; should be loaded after yasnippet so that they can work together
;; ----------------------------------------------------------------------------
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(global-auto-complete-mode t)
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; ----------------------------------------------------------------------------
;; configuration for enablling the recurive deleting directory
;; ----------------------------------------------------------------------------
(setq dired-recursive-deletes 'top)	;; dired - recursive delete directory

;; ----------------------------------------------------------------------------
;; emacs server settings
;; ----------------------------------------------------------------------------
(when (equal window-system 'w32)
  (require 'server)
  ;; Suppress error directory ~/.emacs.d/server is unsafe on windows.
  (if (equal window-system 'w32) (defun server-ensure-safe-dir (dir) "Noop" t))
  (server-start)
  (remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
)
;; ----------------------------------------------------------------------------
;; Cygwin Setting for cygwin-mount.el
;; ----------------------------------------------------------------------------
(when (eq window-system 'w32)
  ;; (setenv "PATH" (concat "c:/cygwin/bin;" (getenv "PATH")))
  ;; (setq exec-path (cons "c:/cygwin/bin/" exec-path))
  (require 'cygwin-mount)
  (cygwin-mount-activate)

  ;; Replace the dos command window to bash of cygwin
  (add-hook 'comint-output-filter-functions
			'shell-strip-ctrl-m nil t)
  (add-hook 'comint-output-filter-functions
			'comint-watch-for-password-prompt nil t)
  (setq explicit-shell-file-name "bash.exe")
  ;; For subprocesses invoked via the shell
  ;; (e.g., "shell -c command")
  (setq shell-file-name explicit-shell-file-name)
)
;; ----------------------------------------------------------------------------
;; configuration for coding system to unix default
;; ----------------------------------------------------------------------------
;; korean language setting
(when (equal window-system 'w32)
  (set-language-environment "Korean")
  ;; (set-default-coding-systems 'utf-8-unix)
  (prefer-coding-system 'euc-kr)
  (set-default-coding-systems 'euc-kr)
  (set-terminal-coding-system 'euc-kr)
  (set-keyboard-coding-system 'euc-kr)
  (set-selection-coding-system 'euc-kr)
  (setq-default buffer-coding-system 'euc-kr)
  (setq-default buffer-file-coding-system 'euc-kr)
  (setq-default file-name-coding-system 'euc-kr)
  (setq-default locale-coding-system 'euc-kr)
  (add-hook 'sh-mode-hook'
            (lambda ()
              (set-default-coding-systems 'utf-8-unix)
              ))
  (setenv "CYGWIN" "nodosfilewarning")
)

;;------------------------------------------------------------------------
;; org mode Settings
;;------------------------------------------------------------------------
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
;; setting org files for org-agenda
(setq org-agenda-files (list "~/org/Task.org" "~/org/Schedule.org" "~/org/notes.org" "~/org/project.org"))

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
;; (toggle-diredp-find-file-reuse-dir 1)

;;------------------------------------------------------------------------
;; naver dictionary Settings
;;------------------------------------------------------------------------
(defun search-naver-dic ()
  (interactive)
  (browse-url (concat "http://endic.naver.com/search.naver?mode=all&x=0&y=0&query="
                      (thing-at-point 'word))))
(define-key mode-specific-map "d" 'search-naver-dic)

;;------------------------------------------------------------------------
;; shell-pop
;;------------------------------------------------------------------------
(load-file "~/.emacs.d/packages/shell-pop.el")
(require 'shell-pop)
(shell-pop-set-internal-mode "eshell")
(shell-pop-set-internal-mode-shell "/bin/bash")
(shell-pop-set-window-height 60) ; the number for the percentage of the selected window.
(global-set-key [f10] 'shell-pop)

;;------------------------------------------------------------------------
;; shell-switcher
;;------------------------------------------------------------------------
(require 'shell-switcher)
(setq shell-switcher-mode t)

;;------------------------------------------------------------------------
;; mo-git-blame
;;------------------------------------------------------------------------
(require 'mo-git-blame)
(global-set-key [?\C-c ?g ?c] 'mo-git-blame-current)
(global-set-key [?\C-c ?g ?f] 'mo-git-blame-file)

;;------------------------------------------------------------------------
;; elpy settings for python mode
;; you should install first python, and pip
;; sudo apt-get install python-pip
;; sudo pip install elpy jedi rope
;;------------------------------------------------------------------------
(elpy-enable)
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)

;;------------------------------------------------------------------------
;; iedit mode
;;------------------------------------------------------------------------
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;;------------------------------------------------------------------------
;; magit speed up
;;------------------------------------------------------------------------
(setq magit-highlight-indentation nil)
(setq magit-highlight-trailing-whitespace nil)
(setq magit-highlight-whitespace nil)
(setq magit-diff-refine-hunk nil)
(setq magit-backup-untracked nil)
(setq magit-have-graph nil)

;;------------------------------------------------------------------------
;; my key settings
;;------------------------------------------------------------------------
(defalias 'em 'find-file)
(defalias 'emo 'find-file-other-window)
(defalias 'gg 'vc-git-grep)
(defalias 'ff 'find-name-dired)

;;------------------------------------------------------------------------
;; my key settings
;;------------------------------------------------------------------------
(global-set-key [f11] 'list-matching-lines)
(global-set-key [?\C-x f10] 'compile)
(global-set-key "\C-\]" 'vc-git-grep)

;;------------------------------------------------------------------------
;; window font setting
;;------------------------------------------------------------------------
(when (eq window-system 'w32)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))
)
