(module config.plugin.close-buffers
  {autoload {nvim aniseed.nvim
             close_buffers close_buffers}})

(close_buffers.setup {:filetype_ignore {}
                      :file_glob_ignore {}
                      :file_regex_ignore {}
                      :preserve_window_layout {1 :this
                                               2 :nameless}
                      :next_buffer_cmd nil})

