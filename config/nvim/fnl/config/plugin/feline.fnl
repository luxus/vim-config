(module config.plugin.feline
  {autoload {nvim aniseed.nvim
             feline feline}})

(set nvim.o.termguicolors true)

;; Using default preset found in \nvim-data\site\pack\packer\start\feline.nvim\lua\feline\presets\default.lua with a small modication to still show file properties in inactive buffers
(local vi-mode-utils (require :feline.providers.vi_mode))

(local M {:active {} :inactive {}})

(tset M.active 1
      [{:provider "▊ " :hl {:fg :skyblue}}
       {:provider :vi_mode
        :hl (fn []
              {:name (vi-mode-utils.get_mode_highlight_name)
               :fg (vi-mode-utils.get_mode_color)
               :style :bold})}
       {:provider {:name :file_info
                   :opts {:type :unique}}

        :hl {:fg :white :bg :oceanblue :style :bold}
        :left_sep [:slant_left_2
                   {:str " " :hl {:bg :oceanblue :fg :NONE}}]
        :right_sep [{:str " " :hl {:bg :oceanblue :fg :NONE}}
                    :slant_right_2
                    " "]}
       {:provider :file_size
        :right_sep [" " {:str :slant_left_2_thin :hl {:fg :fg :bg :bg}}]}
       {:provider :position
        :left_sep " "
        :right_sep [" " {:str :slant_right_2_thin :hl {:fg :fg :bg :bg}}]}
       {:provider :diagnostic_errors :hl {:fg :red}}
       {:provider :diagnostic_warnings :hl {:fg :yellow}}
       {:provider :diagnostic_hints :hl {:fg :cyan}}
       {:provider :diagnostic_info :hl {:fg :skyblue}}])
(tset M.active 2
      [
       ; Git branch was obscuring the filename when there are many windows
       ; {:provider :git_branch
       ;  :hl {:fg :white :bg :black :style :bold}
       ;  :right_sep {:str " " :hl {:fg :NONE :bg :black}}}
       {:provider :git_diff_added :hl {:fg :green :bg :black}}
       {:provider :git_diff_changed :hl {:fg :orange :bg :black}}
       {:provider :git_diff_removed
        :hl {:fg :red :bg :black}
        :right_sep {:str " " :hl {:fg :NONE :bg :black}}}
       {:provider :line_percentage
        :hl {:style :bold}
        :left_sep "  "
        :right_sep " "}
       {:provider :scroll_bar :hl {:fg :skyblue :style :bold}}])

(tset M.inactive 1 
      [{:provider "▊ " :hl {:fg :skyblue}}
       {:provider :vi_mode
        :hl (fn []
              {:name (vi-mode-utils.get_mode_highlight_name)
               :fg (vi-mode-utils.get_mode_color)
               :style :bold})}
       {:provider :file_info
        :hl {:fg :white :bg :oceanblue :style :bold}
        :left_sep [:slant_left_2
                   {:str " " :hl {:bg :oceanblue :fg :NONE}}]
        :right_sep [{:str " " :hl {:bg :oceanblue :fg :NONE}}
                    :slant_right_2
                    " "]}
       {:provider :file_size
        :right_sep [" " {:str :slant_left_2_thin :hl {:fg :fg :bg :bg}}]}
       {:provider :position
        :left_sep " "
        :right_sep [" " {:str :slant_right_2_thin :hl {:fg :fg :bg :bg}}]}
       {:provider :diagnostic_errors :hl {:fg :red}}
       {:provider :diagnostic_warnings :hl {:fg :yellow}}
       {:provider :diagnostic_hints :hl {:fg :cyan}}
       {:provider :diagnostic_info :hl {:fg :skyblue}}])


(feline.setup {:components M})

