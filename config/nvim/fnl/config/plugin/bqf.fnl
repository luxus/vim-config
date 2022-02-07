(module config.plugin.bqf
  {autoload {bqf bqf}})

(vim.cmd "    hi BqfPreviewBorder guifg=#50a14f ctermfg=71
    hi link BqfPreviewRange Search
")

((. (require :bqf) :setup) {:auto_enable true
                            :preview {:win_height 12
                                      :win_vheight 12
                                      :delay_syntax 80
                                      :border_chars {1 "┃"
                                                     2 "┃"
                                                     3 "━"
                                                     4 "━"
                                                     5 "┏"
                                                     6 "┓"
                                                     7 "┗"
                                                     8 "┛"
                                                     9 "█"}
                                      :should_preview_cb (fn [bufnr]
                                                           (var ret true)
                                                           (local bufname
                                                                  (vim.api.nvim_buf_get_name bufnr))
                                                           (local fsize
                                                                  (vim.fn.getfsize bufname))
                                                           (if (> fsize
                                                                  (* 100 1024))
                                                               (set ret false)
                                                               (bufname:match "^fugitive://")
                                                               (set ret false))
                                                           ret)}
                            :func_map {:drop :o
                                       :openc :O
                                       :split :<C-s>
                                       :tabdrop :<C-t>
                                       :tabc ""
                                       :ptogglemode "z,"}
                            :filter {:fzf {:action_for {:ctrl-s :split
                                                        :ctrl-t "tab drop"}
                                           :extra_opts {1 :--bind
                                                        2 "ctrl-o:toggle-all"
                                                        3 :--prompt
                                                        4 "> "}}}})	
