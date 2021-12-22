(module config.plugin.telescope
  {autoload {nvim aniseed.nvim
             telescope telescope}})

(telescope.setup {:defaults {:file_ignore_patterns ["node_modules"]}
                  :pickers {:find_files {:find_command ["rg" "--files" "--iglob" "!.git" "--hidden"]}}
                  :extensions {:fzf {:fuzzy true
                                     :override-generic-sorter true
                                     :override-file-sorter true
                                     :case-mode "smart_case"}
                               :tele_tabby { :use_highlighter true }
                               :project {
                                  :base_dirs  ["~/repos" "~/source/repos"  "C:/repos"]
                                  :hidden_files true }}})

(telescope.load_extension "fzf")
(telescope.load_extension "project")

(nvim.set_keymap :n :<leader>ff ":lua require('telescope.builtin').find_files()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fg ":lua require('telescope.builtin').live_grep()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fi ":lua require('telescope.builtin').command_history()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fb ":lua require('telescope.builtin').buffers()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fh ":lua require('telescope.builtin').help_tags()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fc ":lua require('telescope.builtin').commands()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fz ":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fr ":lua require('telescope.builtin').resume()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fp ":lua require'telescope'.extensions.project.project{}<CR>" {:noremap true :silent true})
(nvim.set_keymap :n :<leader>ft ":lua require('telescope').extensions.tele_tabby.list()<CR>" {:noremap true :silent true})
(nvim.set_keymap :n :- ":lua require('telescope').extensions.vinegar.file_browser()<cr>" {:noremap true})
(nvim.set_keymap :n :<leader>fs ":lua require('session-lens').search_session()<CR>" {:noremap true})



;; disable netrw
; vim.g['loaded_netrw'] = 1

(set nvim.g.loaded_netrw 1)

;;- create function to open file browser when opening a directory

(fn pl-is-dir []
  (let [pl (require "plenary.path")
        path (vim.fn.expand "%:p")
        new-thing (pl.new path) ]
    (new-thing:is_dir)))

(set _G.browse_if_dir
     (fn []
       (if (pl-is-dir)
         (let [buf (vim.api.nvim_get_current_buf)]
           (vim.api.nvim_buf_set_option buf "buftype" "nofile")
           (vim.api.nvim_buf_set_option buf "buflisted" false)
           (vim.api.nvim_buf_set_option buf "swapfile" false)
           (vim.api.nvim_buf_set_option buf "bufhidden" "hide")
           (telescope.extensions.vinegar.file_browser)
           ))))


; _G.browse_if_dir = function()
;   if require('plenary.path'):new(vim.fn.expand('%:p')):is_dir() then
;     local buf = vim.api.nvim_get_current_buf()
;     vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
;     vim.api.nvim_buf_set_option(buf, 'buflisted', false)
;     vim.api.nvim_buf_set_option(buf, 'swapfile', false)
;     vim.api.nvim_buf_set_option(buf, 'bufhidden', 'hide')
;     require('telescope').extensions.vinegar.file_browser()
;   end
; end

;; autocommand to run the above function when launching
(vim.api.nvim_command "au VimEnter * call v:lua.browse_if_dir()")
