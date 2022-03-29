(module config.plugin.telescope
  {autoload {nvim aniseed.nvim
             telescope telescope
             putils telescope.previewers.utils
             telescope-actions telescope.actions
             project project_nvim
             workspaces workspaces
             nvim-web-devicons nvim-web-devicons}})


(nvim-web-devicons.setup {:default true})

(defn is-minified-file [filepath]
  (let [excluded (vim.tbl_filter 
                   (fn [ending] 
                     (filepath:match ending)) 
                   [".*%.min.js" ".*%.min.css"])

        is-minified (not (vim.tbl_isempty excluded))]
    
    is-minified))

(comment 
  
  (vim.inspect (is-minified-file "C:/repos/file.min.js")) ;; Returns true
  (vim.inspect (is-minified-file "C:/repos/other.js")) ;; Returns false
  )


(defn show-is-minified-preview-msg [filename bufnr opts]
  "Displays a message inidicating that the file is minified"
  (putils.set_preview_message bufnr opts.winid
                              (string.format "%s is minifed" filename)))

(telescope.setup {:defaults {:file_ignore_patterns ["node_modules" "wwwroot/lib/*"] 
                             ;;:vimgrep_arguments ["rg" "--color=never" "--no-heading" "--with-filename" "--line-number" "--column" "--smart-case" "--hidden"]
                             :mappings {:i {"<C-Down>" (. telescope-actions :cycle_history_next) 
                                            "<C-Up>" (. telescope-actions :cycle_history_prev) }}
                             :preview {:treesitter false
                                       :filetype_hook (fn [filepath bufnr opts] 
                                                        (not (is-minified-file filepath)))}
                             }

                  :pickers {:grep_string {:theme :ivy}
                            :current_buffer_fuzzy_find {:theme :ivy}
                            :find_files {:theme :ivy
                                         :find_command ["rg" "--files" "--iglob" "!.git" "--hidden"]}

                            ; Ivy theme for everything lsp
                            :lsp_references {:theme :ivy}
                            :lsp_document_symbols {:theme :ivy}
                            :lsp_workspace_symbols {:theme :ivy}
                            :lsp_workspace_symbols {:theme :ivy}
                            :diagnostics {:theme :ivy}
                            :lsp_implementations {:theme :ivy}
                            :lsp_definitions {:theme :ivy}
                            :lsp_type_definitions {:theme :ivy}}

                  :extensions {:fzf {:fuzzy true
                                     :override-generic-sorter true
                                     :override-file-sorter true
                                     :case-mode "smart_case"}
                               :tele_tabby {:use_highlighter true}

                               ; :project {
                               ;    :base_dirs  ["~/repos" "~/source/repos"  "C:/repos"]
                               ;    :hidden_files true }
                               }})
(workspaces.setup {
    :hooks {:open ["Telescope find_files"]}})


(telescope.load_extension "workspaces")
(telescope.load_extension "fzf")
(telescope.load_extension "projects")
(telescope.load_extension "dap")
(telescope.load_extension "file_browser")
(telescope.load_extension "env")
(telescope.load_extension "coc")

(project.setup {:manual_mode false
                :exclude_dirs ["~/source/repos/fairplayams/"
                               "~/source/repos/fairplayams2/"]
                :detection_methods [
                                    "pattern"
                                    ;; "lsp"
                                    ]
                :silent_chdir true
                :patterns [ ".git" "_darcs" ".hg" ".bzr" ".svn" "Makefile" "package.json" 
                           ; "*.csproj" 
                            ".west"
                           ; "!^AMSApp"
                           "!>AMSApp"
                           ; "=Applications"
                           ">Applications"
                          ; "=AMSApp"
                          ; "=Applications/AMSApp"
                          ; "=Applications/AMS"
                           "*.sln" 
                           ]})

(vim.cmd "autocmd User TelescopePreviewerLoaded setlocal wrap")

(nvim.set_keymap :n :<leader>ff ":lua require('telescope.builtin').find_files()<CR>" {:noremap true})
;;(nvim.set_keymap :n :<leader>fg ":lua require('telescope.builtin').live_grep()<CR>" {:noremap true}) ;; Removed in favour of fzf
(nvim.set_keymap :x :<leader>fv ":lua require('telescope.builtin').grep_string()<CR>" {})
(nvim.set_keymap :n :<leader>fv ":lua require('telescope.builtin').grep_string()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fi ":lua require('telescope.builtin').command_history()<CR>" {:noremap true})
(nvim.set_keymap :x :<leader>fi ":lua require('telescope.builtin').command_history()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fb ":lua require('telescope.builtin').buffers()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fh ":lua require('telescope.builtin').help_tags()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fd ":lua require('telescope').extensions.file_browser.file_browser()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fc ":lua require('telescope.builtin').commands()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fz ":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fr ":lua require('telescope.builtin').resume()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fp ":lua require'telescope'.extensions.projects.projects{}<CR>" {:noremap true :silent true})
(nvim.set_keymap :n :<leader>ft ":lua require('telescope').extensions.tele_tabby.list()<CR>" {:noremap true :silent true})
(nvim.set_keymap :n :<leader>fs ":lua require('session-lens').search_session()<CR>" {:noremap true})


;; telescope-dap
(nvim.set_keymap :n "<leader>dcc"
          "<cmd>lua require'telescope'.extensions.dap.commands{}<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>dco"
          "<cmd>lua require'telescope'.extensions.dap.configurations{}<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>dlb"
          "<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>dv"
          "<cmd>lua require'telescope'.extensions.dap.variables{}<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>df"
          "<cmd>lua require'telescope'.extensions.dap.frames{}<CR>" {:noremap true})
