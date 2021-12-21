;; The name is up to you.
(module dotfiles.init
  {autoload {a aniseed.core
             nvim aniseed.nvim
             mapping dotfiles.mapping
             cmp dotfiles.cmp
             }})

(mapping.setup)

(set nvim.g.maplocalleader ",")
(set nvim.o.termguicolors true)
(set nvim.o.mouse "a")

;; Colours for floating window
(nvim.ex.highlight "NormalFloat ctermbg=grey guibg=black")

;; Telescope
(nvim.set_keymap :n :<leader>ff ":lua require('telescope.builtin').git_files({ hidden = false })<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fa ":lua require('telescope.builtin').find_files({ hidden = true })<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fg ":lua require('telescope.builtin').live_grep()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fb ":lua require('telescope.builtin').buffers()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fh ":lua require('telescope.builtin').help_tags()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fc ":lua require('telescope.builtin').commands()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fd ":lua require('telescope.builtin').file_browser()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fz ":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fr ":lua require('telescope.builtin').resume()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fp ":lua require'telescope'.extensions.project.project{}<CR>" {:noremap true :silent true})
(nvim.set_keymap :n :<leader>fs ":lua require('session-lens').search_session()<CR>" {:noremap true :silent true})

;; Sessions
(set vim.o.sessionoptions "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal")

;; Sexp
(set nvim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet")

;; (nvim.command "echo \"hi\"")

(defn test-function [] 
  (vim.api.cmd "norm viw"))

; (nvim.command ":norm vi(")
; (vim.cmd "norm diw")
; (vim.cmd "<C-U> norm viw")


; (nvim.exec ":norm $")

; (vim.api.normal "viw")

; function! Foo()
;     execute "normal! vi)\<Esc>"
;     '<,'>s/abc/def/g
; endfunction

(defn aa [] 

  (vim.api.nvim_exec "normal! vi)\\<Esc>" true))

(defn replace-in-parens [] 

  (vim.api.nvim_exec "normal! va)\\<Esc>" true)
  (vim.api.nvim_command "s/bb/cc/g")
  
  )


(defn replace-injection []
  
  ;;(vim.api.nvim_command "norm va<\\<Esc>")
(vim.api.nvim_command "norm viwd")
  ;;(vim.api.nvim_command "norm viwdvatva<gr")
  )

(nvim.set_keymap :n :<leader>fi ":lua replace_injection()<CR>" {:noremap true :silent true})

(comment

  (replace-injection)

  <%= aaa %>

  (aa)

  (bb)
  
  (vim.api.nvim_command "norm va)\\<Esc>")

  )


