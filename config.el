;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
(setq user-full-name "Daniel Tingelöf"
      user-mail-address "Daniel.tingelof@ericsson.com")
(setq doom-theme 'doom-one)
(setq display-line-numbers-type 'relative)
(setq org-directory "~/org/")
(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      password-cache-expiry nil                   ; I can trust my computers ... can't I?
      ;; scroll-preserve-screen-position 'always     ; Don't have `point' jump around
      scroll-margin 2                             ; It's nice to maintain a little margin
      display-time-default-load-average nil)      ; I don't think I've ever found this useful

(display-time-mode 1)                             ; Enable time in the mode-line

(unless (string-match-p "^Power N/A" (battery))   ; On laptops...
  (display-battery-mode 1))                       ; it's nice to know how much power you have

(global-subword-mode 1)                           ; Iterate through CamelCase words

(add-to-list 'default-frame-alist '(height . 24))
(add-to-list 'default-frame-alist '(width . 80))

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(map!
 (:leader
  :desc "Verticae Split" :n "v" #'evil-window-vsplit
  :desc "Horizontal Split" :n "s" #'evil-window-split))

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

(map! :map evil-window-map
        "SPC" #'rotate-layout
        ;; Navigation
        "<left>"       #'evil-window-left
        "<down>"       #'evil-window-down
        "<up>"         #'evil-window-up
        "<right>"      #'evil-window-right

        ;; Swapping windows
        "C-<left>"     #'+evil/window-move-left
        "C-<down>"     #'+evil/window-move-down
        "C-<up>"       #'+evil/window-move-up
        "C-<right>"    #'+evil/window-move-right)

(map!
        "C-<left>"     #'evil-window-left
        "C-<down>"     #'evil-window-down
        "C-<up>"       #'evil-window-up
        "C-<right>"    #'evil-window-right)

(map!
        :n "<b"        #'next-buffer
        :n ">b"        #'previous-buffer
        :n "<w"        #'+workspace/switch-right
        :n ">w"        #'+workspace/switch-left
        :n "<c"        #'git-gutter:next-hunk
        :n ">c"        #'git-gutter:previous-hunk
        :n "<d"        #'next-error
        :n ">d"        #'previous-error)

(map! :leader
      (:desc "Quit Buffer" "q" #'evil-quit)
      (:desc "Quit All Buffers" "Q" #'evil-quit-all))

(evil-define-command +evil-buffer-org-new (count file)
  "Creates a new ORG buffer replacing the current window, optionally
   editing a certain FILE"
  :repeat nil
  (interactive "P<f>")
  (if file
      (evil-edit file)
    (let ((buffer (generate-new-buffer "*new org*")))
      (set-window-buffer nil buffer)
      (with-current-buffer buffer
        (org-mode)
        (setq-local doom-real-buffer-p t)))))

(map! :leader
      (:prefix "b"
       :desc "New empty Org buffer" "o" #'+evil-buffer-org-new))

;; Counsel
;; (map! "C-s" #'counsel-grep-or-swiper)
(map! "C-s" #'+default/search-buffer)
(setq counsel-rg-base-command
      "rg -zS -T jupyter -T svg -T lock -T license --no-heading --line-number --color never %s .")

(after! smartparens
  (defun zz/goto-match-paren (arg)
    "Go to the matching paren/bracket, otherwise (or if ARG is not
    nil) insert %.  vi style of % jumping to matching brace."
    (interactive "p")
    (if (not (memq last-command '(set-mark
                                  cua-set-mark
                                  zz/goto-match-paren
                                  down-list
                                  up-list
                                  end-of-defun
                                  beginning-of-defun
                                  backward-sexp
                                  forward-sexp
                                  backward-up-list
                                  forward-paragraph
                                  backward-paragraph
                                  end-of-buffer
                                  beginning-of-buffer
                                  backward-word
                                  forward-word
                                  mwheel-scroll
                                  backward-word
                                  forward-word
                                  mouse-start-secondary
                                  mouse-yank-secondary
                                  mouse-secondary-save-then-kill
                                  move-end-of-line
                                  move-beginning-of-line
                                  backward-char
                                  forward-char
                                  scroll-up
                                  scroll-down
                                  scroll-left
                                  scroll-right
                                  mouse-set-point
                                  next-buffer
                                  previous-buffer
                                  previous-line
                                  next-line
                                  back-to-indentation
                                  doom/backward-to-bol-or-indent
                                  doom/forward-to-last-non-comment-or-eol
                                  )))
        (self-insert-command (or arg 1))
      (cond ((looking-at "\\s\(") (sp-forward-sexp) (backward-char 1))
            ((looking-at "\\s\)") (forward-char 1) (sp-backward-sexp))
            (t (self-insert-command (or arg 1))))))
  (map! "%" 'zz/goto-match-paren))


;; Org mode
(after! org (setq org-hide-emphasis-markers t))
(after! org (setq org-insert-heading-respect-content nil))
(setq org-adapt-indentation t
      org-hide-leading-stars t
      org-odd-levels-only t)
(setq org-roam-directory "~/roam")


;; other
(map! :n [mouse-8] #'better-jumper-jump-backward
      :n [mouse-9] #'better-jumper-jump-forward)

(setq projectile-ignored-projects
      (list "~/" "/tmp" (expand-file-name "straight/repos" doom-local-dir)))

(setq projectile-project-root-files
      (list "bob" "pom.xml" ".git" "ruleset2.0.yaml"))
(setq projectile-project-search-path '("~/.config/doom" ("~/repos_personal" . 1)("~/repos" . 1)))
(defun projectile-ignored-project-function (filepath)
  "Return t if FILEPATH is within any of `projectile-ignored-projects'"
  (or (mapcar (lambda (p) (s-starts-with-p p filepath)) projectile-ignored-projects)))

(eval-after-load 'evil-vars
 '(define-key evil-insert-state-map (kbd "C-v") 'yank))

(eval-after-load 'evil-vars
 '(define-key evil-ex-completion-map (kbd "C-v") 'yank))
(require 'evil-multiedit)
(evil-multiedit-default-keybinds)

;; LSP
;; Python
(setq lsp-pylsp-plugins-flake8-enabled t)
(setq lsp-pylsp-plugins-black-enabled t)
(setq lsp-pylsp-plugins-pylint-enabled t)
(defun projectile-test-prefix (project-type)
  (cond
   ((member project-type '(python generic)) "test")))

;; Git
(defhydra git-hydra (:exit t)
  ("g" magit "Magit")
  ("b" magit-blame "Magit blame")
  ("l" magit-log "Magit log")
  ("t" git-timemachine-toggle "Git Time Machine toggle" :column "Time Machine")
  ("r" git-gutter:revert-hunk "Git Gutter revert hunk" :column "Gutter")
  ("a" git-gutter:stage-hunk "Git Gutter stage hunk"))

(map!
 (:leader
  (:desc "git" :n "g" #'git-hydra/body)))
