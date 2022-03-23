(module config.plugin.close-buffers
  {autoload {nvim aniseed.nvim
             close_buffers close_buffers}})

(close_buffers.setup {:filetype_ignore {}
                      :file_glob_ignore {}
                      :file_regex_ignore {}
                      :preserve_window_layout {1 :this
                                               2 :nameless}
                      :next_buffer_cmd nil})

(nvim.set_keymap :n :<leader>bdh
                         "<CMD>lua require('close_buffers').delete({type = 'hidden'})<CR>"
                         {:noremap true :silent true})
(nvim.set_keymap :n :<leader>bdu
                         "<CMD>lua require('close_buffers').delete({type = 'nameless'})<CR>"
                         {:noremap true :silent true})
(nvim.set_keymap :n :<leader>bdt
                         "<CMD>lua require('close_buffers').delete({type = 'this'})<CR>"
                         {:noremap true :silent true})	
