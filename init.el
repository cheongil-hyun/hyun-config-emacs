;; ----------------------------------------------------------------------------
;; adding the package sources
;; ("marmalade" . "http://marmalade-repo.org/packages/") 
;; ----------------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< 
emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
  )
(package-initialize)

;; ----------------------------------------------------------------------------
;; adding better-defaults.el
;; ----------------------------------------------------------------------------
(load-library "~/.emacs.d/better-defaults.el")
(require 'better-defaults)

;; ----------------------------------------------------------------------------
;; Bootstrap use-package
;; Install use-package if it's not already installed.
;; use-package is used to configure the reset of the packages
;; ----------------------------------------------------------------------------
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
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
;; ediff-trees.elff
;; ----------------------------------------------------------------------------
;; (load-file "~/.emacs.d/packages/ediff-trees.el")

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
			(unless (or (file-exists-p "makefile")
						(file-exists-p "Makefile"))
			  (set (make-local-variable 'compile-command)
				   (concat "g++ "
						   (buffer-file-name)
						   " -std=c++11 && ./a.out")))
            (setq default-tab-width 4)
			(setq c-basic-offset 4)
            (setq indent-tabs-mode t) ;; no tab
            ))

(delete-selection-mode 1)		;
(setq-default truncate-lines t) ;


;; ----------------------------------------------------------------------------
;; setting for company
;; ----------------------------------------------------------------------------
(use-package company
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode)
  (add-hook 'c++-mode-hook 'company-mode)

  :config
  (setq company-idle-delay 0.02)
  (setq company-minimum-prefix-lenght 1)
  (setq company-show-numbers t)
  (setq company-selection-wrap-around t)
  (setq company-transformers '(company-sort-by-occurrence company-sort-by-backend-importance))
  (setq company-tooltip-limit 20)
  (setq company-dabbrev-downcase nil)
  (setq company-dabbrev-ignore-case t)
  (setq company-dabbrev-code-ignore-case t)
  (setq company-dabbrev-code-everywhere t)
)

;;------------------------------------------------------------------------
;; org mode Settings
;;------------------------------------------------------------------------
(use-package org
  :ensure t
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (add-hook 'org-mode-hook
			(lambda ()
			  (org-indent-mode t)
			  (auto-fill-mode 1)
			  )
			t)
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)

  :config
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
)

;; ----------------------------------------------------------------------------
;; adding xcscope.el
;; ----------------------------------------------------------------------------
;; (use-package xcscope
;;   :load-path "~/.emacs.d/packages/"
;;   :defer t
;;   :init
;;   (setq cscope-do-not-update-database t)  ;; do not update the cscope files
;; )
(load-library "~/.emacs.d/packages/xcscope.el")
(require 'xcscope)
(setq cscope-do-not-update-database t)  ;; do not update the cscope files

;; ----------------------------------------------------------------------------
;; configuration for etags select
;; ----------------------------------------------------------------------------
;; (use-package etags-select
;;   :load-path "~/.emacs.d/packages/"
;;   :defer t
;;   :init
;;   (global-set-key "\M-?" 'etags-select-find-tag-at-point)
;;   (global-set-key "\M-." 'etags-select-find-tag)
;; )
(load-file "~/.emacs.d/packages/etags-select.el")
(require 'etags-select)
(global-set-key "\M-?" 'etags-select-find-tag-at-point)
(global-set-key "\M-." 'etags-select-find-tag)
;; ----------------------------------------------------------------------------
;; C coding style setting now linux
;; (setq c-default-style "k&r")
;; (setq c-default-style "cc-mode")
;; (setq c-default-style "gnu")
;; (setq c-default-style "bsd")
;; (setq c-default-style "stroustrup")
;; (setq c-default-style "whitesmith")
;; ----------------------------------------------------------------------------
(setq c-default-style "linux")

;; ----------------------------------------------------------------------------
;; (set-language-environment "Korean")
;; ----------------------------------------------------------------------------
(setq default-input-method "korean-hangul")

;; ----------------------------------------------------------------------------
;; configuration for enablling the recurive deleting directory
;; ----------------------------------------------------------------------------
(setq dired-recursive-deletes 'top)	;; dired - recursive delete directory

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
;; (use-package shell-pop
;;   :load-path  "~/.emacs.d/packages/"
;;   :defer t
;;   :config
;;   (shell-pop-set-internal-mode "eshell")
;;   (shell-pop-set-internal-mode-shell "/bin/bash")
;;   (shell-pop-set-window-height 60) ; the number for the percentage of the selected window.
;;   (global-set-key [f10] 'shell-pop)
;; )
(load-file "~/.emacs.d/packages/shell-pop.el")
(require 'shell-pop)
(shell-pop-set-internal-mode "eshell")
(shell-pop-set-internal-mode-shell "/bin/bash")
(shell-pop-set-window-height 60) ; the number for the percentage of the selected window.
(global-set-key [f10] 'shell-pop)

;;------------------------------------------------------------------------
;; shell-switcher
;;------------------------------------------------------------------------
(use-package shell-switcher
  :ensure t
  :defer t
  :init
  (setq shell-switcher-mode t)
)

;;------------------------------------------------------------------------
;; mo-git-blame
;;------------------------------------------------------------------------
(use-package mo-git-blame
  :ensure t
  :defer t
  :init
  (global-set-key [?\C-c ?g ?c] 'mo-git-blame-current)
  (global-set-key [?\C-c ?g ?f] 'mo-git-blame-file)
)
;;------------------------------------------------------------------------
;; magit speed up
;;------------------------------------------------------------------------
(use-package magit
  :ensure t
  :defer t
  :init
  (setq magit-highlight-indentation nil)
  (setq magit-highlight-trailing-whitespace nil)
  (setq magit-highlight-whitespace nil)
  (setq magit-diff-refine-hunk nil)
  (setq magit-backup-untracked nil)
  (setq magit-have-graph nil)
)
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
;; (global-set-key [?\C-x f10] 'compile)
(global-set-key [f4] 'compile)
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
