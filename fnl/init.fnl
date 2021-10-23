;; The name is up to you.
(module dotfiles.init
  {autoload {a aniseed.core
             nvim aniseed.nvim
             mapping dotfiles.mapping
             }})

(mapping.setup)

(set nvim.g.maplocalleader ",")
(set nvim.o.termguicolors true)
(set nvim.o.mouse "a")

;; Colours for floating window
(nvim.ex.highlight "NormalFloat ctermbg=grey guibg=grey")

;; Telescope
(nvim.set_keymap :n :<leader>ff ":lua require('telescope.builtin').find_files()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fg ":lua require('telescope.builtin').live_grep()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fb ":lua require('telescope.builtin').buffers()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fh ":lua require('telescope.builtin').help_tags()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fc ":lua require('telescope.builtin').commands()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fd ":lua require('telescope.builtin').file_browser()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fz ":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>" {:noremap true})
(nvim.set_keymap :n :<C-p>      ":lua require'telescope'.extensions.project.project{}<CR>" {:noremap true :silent true})
(nvim.set_keymap :n :<leader>fs ":lua require('session-lens').search_session()<CR>" {:noremap true :silent true})

;; Sessions
(set vim.o.sessionoptions "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal")

;; Sexp
(set nvim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet")

(a.println "Fennel init loaded")

