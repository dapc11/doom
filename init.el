;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a link to Doom's Module Index where all
;;      of our modules are listed, including what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

(doom! :input
       :completion
       (company +childframe)           ; the ultimate code completion backend
       (vertico +icons)          ; the search engine of the future

       :ui
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       indent-guides     ; highlighted indent columns
       ligatures         ; ligatures and symbols to make your code pretty again
       minimap           ; show a map of the code on the side
       modeline          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink cursor line after big motions
       neotree           ; a project drawer, like NERDTree for vim
       ophints           ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       tabs              ; a tab bar for Emacs
       ;;treemacs          ; a project drawer, like neotree but cooler
       (vc-gutter +pretty) ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       workspaces        ; tab emulation, persistence & separate workspaces

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       snippets          ; my elves. They type so I don't have to
       word-wrap         ; soft wrapping with language-aware indent
       format

       :emacs
       dired             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       vterm             ; the best terminal emulation in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget

       :tools
       (docker +lsp)
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       (lsp +eglot +peek)               ; M-x vscode
       magit             ; a git porcelain for Emacs
       ;;tmux              ; an API for interacting with tmux
       tree-sitter       ; syntax and parsing, sitting in a tree...

       :os
       (:if IS-MAC macos)  ; improve compatibility with macOS
       ;;tty               ; improve the terminal Emacs experience

       :lang
       emacs-lisp        ; drown in parentheses
       (go +lsp)         ; the hipster dialect
       (json + lsp)              ; At least it ain't XML
       (java +lsp)       ; the poster child for carpal tunnel syndrome
       (lua +lsp)               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
       (org
        +roam
        +pretty)               ; organize your plain life in plain text
       (python +lsp +pyright)            ; beautiful is better than ugly
       (sh +lsp)               ; she sells {ba,z,fi}sh shells on the C xor
       (yaml +lsp)              ; JSON, but readable

       :config
       ;;literate
       (default +bindings +smartparens))
