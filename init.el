(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(require 'use-package)

;; Better defaults
;;(add-to-list 'load-path "~/.emacs.d/better-defaults")
;;(require 'better-defaults)

(defun restore-menu-bar()
  (interactive)
  (if (fboundp 'menu-bar-mode) (menu-bar-mode 1)))

(restore-menu-bar)

;; Helm mode
(use-package helm
  :ensure t
  :init
  (setq helm-mode 1))

;; LSP mode
(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package helm-lsp
  :ensure t
  :commands helm-lsp-workspace-symbol)

(use-package dap-mode
  :ensure t)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language
(use-package dap-python)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))  ; or lsp-deferred

;; M-x lsp-install-server RET jsts-ls RET.
;; npm i -g javascript-typescript-langserver

;; M-x lsp-install-server RET json-ls RET.
;; Automatic or manual by npm i -g vscode-langservers-extracted

;; M-x lsp-install-server RET dockerfile-ls RET.
;; npm install -g dockerfile-language-server-nodejs

;; Company mode
(use-package company
  :after lsp-mode
  :ensure t
             :hook (prog-mode . company-mode)
             :bind (:map company-active-map
                         ("<tab>" . company-complete-selection))
             (:map lsp-mode-map
                   ("<tab>" . company-indent-or-complete-common))
             :custom
             (company-minimum-prefix-length 1)
             (company-idle-delay 0.0))
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-backends '((company-capf company-dabbrev-code)))
(setq global-display-line-numbers-mode t)
(setq global-flycheck-mode t)


;; Flycheck mode
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Apheleia mode
(use-package apheleia
	     :ensure t
	     :init (apheleia-global-mode))

;; Projectile
(use-package projectile
  :ensure t)
;; Recommended keymap prefix on Windows/Linux
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)
(setq projectile-project-search-path '("~/Projects/" ))

;; Rainbow delimeters
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; Minimap mode
(use-package minimap
  :ensure t)
(minimap-mode 1)
(add-to-list 'minimap-major-modes 'html-mode)
(add-to-list 'minimap-major-modes 'org-mode)

;; Aggresive indent
(use-package aggressive-indent
  :ensure t)
(global-aggressive-indent-mode 1)

;; Bracket closing behaviour
(electric-pair-mode t)
(add-hook 'c-mode-common-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))

;; Ido setup
(require 'ido)
(ido-mode t)

;; Org babel setup
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (shell . t)
   (css . t)
   (latex . t)
   (js . t)
   (python . t)
   (sql . t)))

(use-package pyvenv
  :ensure t
  :init
  (setq venv-initialize-interactive-shells t) ;; if you want interactive shell support
  (setq venv-initialize-eshell t) ;; if you want eshell support
  (setq venv-location "/home/faruk/.virtualenvs/"))

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'material t)

;; Set highlight colur for the minimap in dark themes.
(custom-set-faces
  '(minimap-active-region-background
    ((((background dark)) (:background "#5F345F"))
      (t (:background "#F19BF1")))
    "Face for the active region in the minimap.
By default, this is only a different background color."
    :group 'minimap))

(global-display-line-numbers-mode)
(setq default-directory "/path/to/documents/directory/")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(tide company))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(org-confirm-babel-evaluate nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
