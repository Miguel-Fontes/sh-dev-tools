;;; init.el --- Emacs para editar o vault-tech-assistant  -*- lexical-binding: t; -*-

;; --- Isola o ruído do Customize num arquivo separado ---
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; --- Fonte de pacotes ---
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(require 'use-package)
(setopt use-package-always-ensure t)

;; --- Configurações Globais ---
(global-display-line-numbers-mode 1)

;; --- Keybindings ---
(use-package org
  :ensure nil
  :bind ("C-c a" . org-agenda)
  :config (require 'org-tempo))

;; yasnippet: snippets de texto
(use-package yasnippet
  :config (yas-global-mode 1))

;; ---  Centraliza backups/auto-saves para não sujarem os repositórios ---
(make-directory "~/.emacs.d/backups/" t)
(make-directory "~/.emacs.d/auto-saves/" t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups/"))
      auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-saves/" t)))

;; --- Completação: UI incremental + fuzzy estilo fzf ---
(use-package vertico
  :init (vertico-mode))
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))
(use-package marginalia
  :init (marginalia-mode))

;; --- Markdown: base para editar o vault ---
(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode)
  :custom (markdown-enable-wiki-links t))

(use-package which-key
  :ensure nil
  :init (which-key-mode))

;; --- obsidian.el: vault estilo Obsidian dentro do Emacs ---
(use-package obsidian
  :demand t
  :custom
  (obsidian-directory "~/dev/vault-tech-assistant/vault")
  (obsidian-inbox-directory "calendar")
  :config
  (global-obsidian-mode t)
  ;; painel de backlinks fica ON-DEMAND (não ocupa tela por padrão) — liga/desliga com C-c b
  :bind (:map obsidian-mode-map
              ("C-c C-o" . obsidian-follow-link-at-point)
              ("C-c C-b" . obsidian-backlink-jump)
              ("C-c C-p" . obsidian-jump)
              ("C-c C-l" . obsidian-insert-wikilink)
              ("C-c b"   . obsidian-backlinks-mode)))


;; -- Racket dev de racket (racket-mode + REPL conectado) ---
(use-package racket-mode
  :mode ("\\.rkt\\'" . racket-mode)
  :hook (racket-mode . racket-xp-mode)) ; análise em background xref, docs (C-c C-d), erros on-the-fly

(use-package paredit
  :hook ((racket-mode           . enable-paredit-mode)
	 (racket-repl-mode      . enable-paredit-mode)
	 (emacs-lisp-mode       . enable-paredit-mode)
	 (list-interaction-mode . enable-paredit-mode)))
		      
;; --- Magit: Git no Emacs
(use-package magit
  :bind ("C-x g" . magit-status)) ; ponto de entrada: status do repositório

;; --- org-babel + ob-racket: rodar blocos racket dentro de .org ---
(use-package ob-racket
  :after org
  :vc (:url "https://github.com/hasu/emacs-ob-racket" :rev :newest)
  :config
  (add-hook 'ob-racket-pre-runtime-library-load-hook
            #'ob-racket-raco-make-runtime-library)
  (org-babel-do-load-languages
   'org-babel-load-languages
   (append org-babel-load-languages '((racket . t)))))

;; --- Treino de digitação - Utilitários

;; speed-type: treinar digitação dentro do emacs -> M-x speed-type-text
(use-package speed-type)

;; guru-mode: desmama das setas/Home/End/Delete, forçando os binds nativos
(use-package guru-mode
  :init (guru-global-mode +1))

;; keyfreq: mede os comandos mais usados -> M-x keyfreq-show
(use-package keyfreq
  :init
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

;; -- Kitty Keyboard Protocol: modificadores completos no terminal ---
(use-package kkp
  :demand t
  :config (global-kkp-mode +1))
