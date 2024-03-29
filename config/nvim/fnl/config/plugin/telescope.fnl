(module config.plugin.telescope
  {autoload {nvim aniseed.nvim
             telescope telescope
             builtin telescope.builtin
             putils telescope.previewers.utils
             telescope-actions telescope.actions
             project project_nvim
             nvim-web-devicons nvim-web-devicons
             themes telescope.themes}})


(nvim-web-devicons.setup {:default true})

; Issue regarding freezing on min.js files: https://github.com/nvim-telescope/telescope.nvim/issues/1379
(defn is-minified-file [filepath]
  "Check if the file name is indicative of a minified js or css file"
  (let [excluded (vim.tbl_filter 
                   (fn [ending] 
                     (filepath:match ending)) 
                   [".*%.min.js" ".*%.min.css"])

        is-minified (not (vim.tbl_isempty excluded))]
    
    is-minified))

(comment 
  
  (vim.inspect (is-minified-file "C:/repos/file.min.js")) ;; Returns true
  (vim.inspect (is-minified-file "C:/repos/other.js"))) ;; Returns false



(defn show-is-minified-preview-msg [filename bufnr opts]
  "Displays a message inidicating that the file is minified"
  (putils.set_preview_message bufnr opts.winid
                              (string.format "%s is minifed" filename)))

(telescope.setup {:defaults {:file_ignore_patterns ["node_modules" "wwwroot/lib/*"] 
                             ;;:vimgrep_arguments ["rg" "--color=never" "--no-heading" "--with-filename" "--line-number" "--column" "--smart-case" "--hidden"]
                             :mappings {:i {"<C-Down>" (. telescope-actions :cycle_history_next) 
                                            "<C-Up>" (. telescope-actions :cycle_history_prev)
                                            "<C-l>" (. telescope-actions :send_to_loclist)
                                            "<M-l>" (. telescope-actions :send_selected_to_loclist)}}
                             :preview {:treesitter false
                                       :filetype_hook (fn [filepath bufnr opts] 
                                                        (not (is-minified-file filepath)))}
                             :layout_strategy :horizontal
                             :wrap_results :true
                             ;; Note - you can set path_display to a function
                             :path_display {:truncate 1 
                                            ;; :shorten 1 
                                            ;; :tail 2
                                            }}

                  :pickers {:grep_string {:theme :ivy}
                            :live_grep {:theme :ivy}
                            :git_branches {:theme :ivy}
                            :current_buffer_fuzzy_find {:theme :ivy}
                            :find_files {:theme :ivy
                                         :find_command ["rg" "--files" "--iglob" "!.git" "--hidden"]}

                            ; Ivy theme for everything lsp
                            :lsp_references {:theme :ivy 
                                             :trim_text :true
                                              :path_display [:shorten :truncate :tail] 
                                             ;; There is an `fname_width` setting for setting the width of the filename section
                                             }
                            :lsp_document_symbols {:theme :ivy}
                            :lsp_workspace_symbols {:theme :ivy}
                            :lsp_workspace_symbols {:theme :ivy}
                            :diagnostics {:theme :ivy}
                            :lsp_implementations {:theme :ivy}
                            :lsp_definitions {:theme :ivy}
                            :lsp_type_definitions {:theme :ivy}
                            :command_history {:theme :ivy}
                            :commands {:theme :ivy}
                            :help_tags {:theme :ivy}}

                  :extensions {:fzf {:fuzzy true
                                     :override-generic-sorter true
                                     :override-file-sorter true
                                     :case-mode "smart_case"}
                               :tele_tabby {:use_highlighter true}
                               :ui-select [(themes.get_cursor)]}})

                               ; :project {
                               ;    :base_dirs  ["~/repos" "~/source/repos"  "C:/repos"]
                               ;    :hidden_files true }

(comment 
  
;; actions.send_selected_to_loclist({prompt_bufnr}) *telescope.actions.send_selected_to_loclist()*
;;     Sends the selected entries to the location list, replacing the previous
;;     entries.
;;
;;
;;     Parameters: ~
;;         {prompt_bufnr} (number)  The prompt bufnr
  )
                               

(telescope.load_extension "fzf")
(telescope.load_extension "projects")
(telescope.load_extension "file_browser")
(telescope.load_extension "env")
(telescope.load_extension "ui-select")
;; (telescope.load_extension "coc")
;; (telescope.load_extension "dap")

(project.setup {:manual_mode true
                :exclude_dirs ["~/source/repos/fairplayams/"
                               "~/source/repos/fairplayams2/"
                               "C:/"
                               "c:/"]
                               
                :detection_methods ["lsp"
                                    "pattern"]
                :silent_chdir true
                :patterns [ ".git" "_darcs" ".hg" ".bzr" ".svn" "Makefile" "package.json" "deps.edn"
                           ; "*.csproj" 
                            ".west"
                           ; "!^AMSApp"
                           "!>AMSApp"
                           ; "=Applications"
                           ">Applications"
                          ; "=AMSApp"
                          ; "=Applications/AMSApp"
                          ; "=Applications/AMS"
                           "*.sln"]}) 
                           

(vim.cmd "autocmd User TelescopePreviewerLoaded setlocal wrap")

;;(nvim.set_keymap :n :<leader>fg ":lua require('telescope.builtin').live_grep()<CR>" {:noremap true}) ;; Removed in favour of fzf

(defn set-proj-root [] (vim.cmd "ProjectRoot"))
(defn find-files-in-current-proj []
  (set-proj-root)
  (builtin.find_files))

;; (vim.keymap.set :n :<leader>ff find-files-in-current-proj {:noremap true :desc "files"})
(vim.keymap.set :n :<leader>ff builtin.find_files {:noremap true :desc "files"})
(nvim.set_keymap :n :<leader>fa ":Telescope<CR>" {:noremap true :desc "all"})
(nvim.set_keymap :x :<leader>fv ":lua require('telescope.builtin').grep_string()<CR>" {:desc "grep string"})
(nvim.set_keymap :n :<leader>fv ":lua require('telescope.builtin').grep_string()<CR>" {:noremap true :desc "grep string"})
(nvim.set_keymap :n :<leader>fi ":lua require('telescope.builtin').command_history()<CR>" {:noremap true :desc "command history"})
(nvim.set_keymap :x :<leader>fi ":lua require('telescope.builtin').command_history()<CR>" {:noremap true :desc "command history"})
(nvim.set_keymap :n :<leader>fb ":lua require('telescope.builtin').buffers()<CR>" {:noremap true :desc "buffers"})
(nvim.set_keymap :n :<leader>fh ":lua require('telescope.builtin').help_tags()<CR>" {:noremap true :desc "help tags"})
(nvim.set_keymap :n :<leader>fd ":lua require('telescope').extensions.file_browser.file_browser()<CR>" {:noremap true :desc "file browser"})

(nvim.set_keymap :n :<leader>fc ":lua require('telescope.builtin').commands()<CR>" {:noremap true :desc "commands"})
(nvim.set_keymap :x :<leader>fc ":lua require('telescope.builtin').commands()<CR>" {:noremap true :desc "commands"})

(nvim.set_keymap :n :<leader>fz ":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>" {:noremap true :desc "buf fuzzy find"})
(nvim.set_keymap :n :<leader>fr ":lua require('telescope.builtin').resume()<CR>" {:noremap true :desc "resume"})
(nvim.set_keymap :n :<leader>fp ":lua require'telescope'.extensions.projects.projects{}<CR>" {:noremap true :silent true :desc "projs"})
(nvim.set_keymap :n :<leader>ft ":lua require('telescope').extensions.tele_tabby.list()<CR>" {:noremap true :silent true :desc "tabs"})
(nvim.set_keymap :n :<leader>fs ":lua require('telescope.builtin').git_status()<CR>" {:noremap true :desc "git status"})
(nvim.set_keymap :n :<leader>ss ":lua require('session-lens').search_session()<CR>" {:noremap true :desc "session"})
(vim.keymap.set :n :<leader>pr set-proj-root {:noremap true :desc "proj root"})
