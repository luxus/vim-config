(module config.plugin.lualine
  {autoload {nvim aniseed.nvim
             feline feline}})

(set nvim.o.termguicolors true)

;; Using default preset found in \nvim-data\site\pack\packer\start\feline.nvim\lua\feline\presets\default.lua with a small modication to still show file properties in inactive buffers
(local vi-mode-utils (require :feline.providers.vi_mode))

(local M {:active {} :inactive {}})

(tset M.active 1
      {1 {:provider "▊ " :hl {:fg :skyblue}}
       2 {:provider :vi_mode
          :hl (fn []
                {:name (vi-mode-utils.get_mode_highlight_name)
                 :fg (vi-mode-utils.get_mode_color)
                 :style :bold})}
       3 {:provider :file_info
          :hl {:fg :white :bg :oceanblue :style :bold}
          :left_sep {1 :slant_left_2
                     2 {:str " " :hl {:bg :oceanblue :fg :NONE}}}
          :right_sep {1 {:str " " :hl {:bg :oceanblue :fg :NONE}}
                      2 :slant_right_2
                      3 " "}}
       4 {:provider :file_size
          :right_sep {1 " " 2 {:str :slant_left_2_thin :hl {:fg :fg :bg :bg}}}}
       5 {:provider :position
          :left_sep " "
          :right_sep {1 " " 2 {:str :slant_right_2_thin :hl {:fg :fg :bg :bg}}}}
       6 {:provider :diagnostic_errors :hl {:fg :red}}
       7 {:provider :diagnostic_warnings :hl {:fg :yellow}}
       8 {:provider :diagnostic_hints :hl {:fg :cyan}}
       9 {:provider :diagnostic_info :hl {:fg :skyblue}}})
(tset M.active 2
      {1 {:provider :git_branch
          :hl {:fg :white :bg :black :style :bold}
          :right_sep {:str " " :hl {:fg :NONE :bg :black}}}
       2 {:provider :git_diff_added :hl {:fg :green :bg :black}}
       3 {:provider :git_diff_changed :hl {:fg :orange :bg :black}}
       4 {:provider :git_diff_removed
          :hl {:fg :red :bg :black}
          :right_sep {:str " " :hl {:fg :NONE :bg :black}}}
       5 {:provider :line_percentage
          :hl {:style :bold}
          :left_sep "  "
          :right_sep " "}
       6 {:provider :scroll_bar :hl {:fg :skyblue :style :bold}}})

(tset M.inactive 1 
      {1 {:provider "▊ " :hl {:fg :skyblue}}
       2 {:provider :vi_mode
          :hl (fn []
                {:name (vi-mode-utils.get_mode_highlight_name)
                 :fg (vi-mode-utils.get_mode_color)
                 :style :bold})}
       3 {:provider :file_info
          :hl {:fg :white :bg :oceanblue :style :bold}
          :left_sep {1 :slant_left_2
                     2 {:str " " :hl {:bg :oceanblue :fg :NONE}}}
          :right_sep {1 {:str " " :hl {:bg :oceanblue :fg :NONE}}
                      2 :slant_right_2
                      3 " "}}
       4 {:provider :file_size
          :right_sep {1 " " 2 {:str :slant_left_2_thin :hl {:fg :fg :bg :bg}}}}
       5 {:provider :position
          :left_sep " "
          :right_sep {1 " " 2 {:str :slant_right_2_thin :hl {:fg :fg :bg :bg}}}}
       6 {:provider :diagnostic_errors :hl {:fg :red}}
       7 {:provider :diagnostic_warnings :hl {:fg :yellow}}
       8 {:provider :diagnostic_hints :hl {:fg :cyan}}
       9 {:provider :diagnostic_info :hl {:fg :skyblue}}})


(feline.setup {:components M})

