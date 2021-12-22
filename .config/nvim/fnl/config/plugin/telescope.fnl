(module config.plugin.telescope
  {autoload {nvim aniseed.nvim
             telescope telescope}})

(telescope.setup {:defaults {:file_ignore_patterns ["node_modules"]}
                  :pickers {:find_files {:find_command ["rg" "--files" "--iglob" "!.git" "--hidden"]}}
                  :extensions {:fzf {:fuzzy true
                                     :override-generic-sorter true
                                     :override-file-sorter true
                                     :case-mode "smart_case"}
                               :project {
                                  :base_dirs  ["~/repos"]
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
