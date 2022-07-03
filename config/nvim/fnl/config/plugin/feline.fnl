(module config.plugin.feline
  {autoload {nvim aniseed.nvim
             feline feline}})

(set nvim.o.termguicolors true)

(local fmt string.format)
(fn hex [n]
  (when n
    (fmt "#%06x" n)))
(fn parse-style [style]
  (when (or (not style) (= style :NONE))
    (let [___antifnl_rtn_1___ {}]
      (lua "return ___antifnl_rtn_1___")))
  (local result {})
  (each [token (string.gmatch style "([^,]+)")]
    (tset result token true))
  result)
(fn get-highlight [name]
  (let [hl (vim.api.nvim_get_hl_by_name name true)]
    (when hl.link
      (let [___antifnl_rtns_1___ [(get-highlight hl.link)]]
        (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
    (local result (parse-style hl.style))
    (set result.fg (and hl.foreground (hex hl.foreground)))
    (set result.bg (and hl.background (hex hl.background)))
    (set result.sp (and hl.special (hex hl.special)))
    result))
(fn set-highlights [groups]
  (each [group opts (pairs groups)]
    (vim.api.nvim_set_hl 0 group opts)))
(fn generate-pallet-from-colorscheme []
  (let [color-map {:black {:index 0 :default "#393b44"}
                   :red {:index 1 :default "#c94f6d"}
                   :green {:index 2 :default "#81b29a"}
                   :yellow {:index 3 :default "#dbc074"}
                   :blue {:index 4 :default "#719cd6"}
                   :magenta {:index 5 :default "#9d79d6"}
                   :cyan {:index 6 :default "#63cdcf"}
                   :white {:index 7 :default "#dfdfe0"}}
        diagnostic-map {:hint {:hl :DiagnosticHint
                               :default color-map.green.default}
                        :info {:hl :DiagnosticInfo
                               :default color-map.blue.default}
                        :warn {:hl :DiagnosticWarn
                               :default color-map.yellow.default}
                        :error {:hl :DiagnosticError
                                :default color-map.red.default}}
        pallet {}]
    (each [name value (pairs color-map)]
      (local global-name (.. :terminal_color_ value.index))
      (tset pallet name (or (and (. vim.g global-name) (. vim.g global-name))
                            value.default)))
    (each [name value (pairs diagnostic-map)]
      (tset pallet name (or (. (get-highlight value.hl) :fg) value.default)))
    (set pallet.sl (get-highlight :StatusLine))
    (set pallet.sel (get-highlight :TabLineSel))
    pallet))
(set _G._generate_user_statusline_highlights
     (fn []
       (let [pal (generate-pallet-from-colorscheme)
             sl-colors {:Black {:fg pal.black :bg pal.white}
                        :Red {:fg pal.red :bg pal.sl.bg}
                        :Green {:fg pal.green :bg pal.sl.bg}
                        :Yellow {:fg pal.yellow :bg pal.sl.bg}
                        :Blue {:fg pal.blue :bg pal.sl.bg}
                        :Magenta {:fg pal.magenta :bg pal.sl.bg}
                        :Cyan {:fg pal.cyan :bg pal.sl.bg}
                        :White {:fg pal.white :bg pal.black}}
             colors {}]
         (each [name value (pairs sl-colors)]
           (tset colors (.. :User name) {:fg value.fg :bg value.bg :bold true})
           (tset colors (.. :UserRv name)
                 {:fg value.bg :bg value.fg :bold true}))
         (local status
                (or (and (= vim.o.background :dark)
                         {:fg pal.black :bg pal.white})
                    {:fg pal.white :bg pal.black}))
         (local groups
                {:UserSLHint {:fg pal.sl.bg :bg pal.hint :bold true}
                 :UserSLInfo {:fg pal.sl.bg :bg pal.info :bold true}
                 :UserSLWarn {:fg pal.sl.bg :bg pal.warn :bold true}
                 :UserSLError {:fg pal.sl.bg :bg pal.error :bold true}
                 :UserSLStatus {:fg status.fg :bg status.bg :bold true}
                 :UserSLFtHint {:fg pal.sel.bg :bg pal.hint}
                 :UserSLHintInfo {:fg pal.hint :bg pal.info}
                 :UserSLInfoWarn {:fg pal.info :bg pal.warn}
                 :UserSLWarnError {:fg pal.warn :bg pal.error}
                 :UserSLErrorStatus {:fg pal.error :bg status.bg}
                 :UserSLStatusBg {:fg status.bg :bg pal.sl.bg}
                 :UserSLAlt pal.sel
                 :UserSLAltSep {:fg pal.sl.bg :bg pal.sel.bg}
                 :UserSLGitBranch {:fg pal.yellow :bg pal.sl.bg}})
         (set-highlights (vim.tbl_extend :force colors groups)))))
(_G._generate_user_statusline_highlights)
(vim.api.nvim_create_augroup :UserStatuslineHighlightGroups {:clear true})
(vim.api.nvim_create_autocmd {1 :SessionLoadPost 2 :ColorScheme}
                             {:callback (fn []
                                          (_G._generate_user_statusline_highlights))})


(local vi {:text {:n :NORMAL
                  :no :NORMAL
                  :i :INSERT
                  :v :VISUAL
                  :V :V-LINE
                  "\022" :V-BLOCK
                  :c :COMMAND
                  :cv :COMMAND
                  :ce :COMMAND
                  :R :REPLACE
                  :Rv :REPLACE
                  :s :SELECT
                  :S :SELECT
                  "\019" :SELECT
                  :t :TERMINAL}
           :colors {:n :UserRvCyan
                    :no :UserRvCyan
                    :i :UserSLStatus
                    :v :UserRvMagenta
                    :V :UserRvMagenta
                    "\022" :UserRvMagenta
                    :R :UserRvRed
                    :Rv :UserRvRed
                    :r :UserRvBlue
                    :rm :UserRvBlue
                    :s :UserRvMagenta
                    :S :UserRvMagenta
                    "\019" :FelnMagenta
                    :c :UserRvYellow
                    :! :UserRvBlue
                    :t :UserRvBlue}
           :sep {:n :UserCyan
                 :no :UserCyan
                 :i :UserSLStatusBg
                 :v :UserMagenta
                 :V :UserMagenta
                 "\022" :UserMagenta
                 :R :UserRed
                 :Rv :UserRed
                 :r :UserBlue
                 :rm :UserBlue
                 :s :UserMagenta
                 :S :UserMagenta
                 "\019" :FelnMagenta
                 :c :UserYellow
                 :! :UserBlue
                 :t :UserBlue}})
(local icons {:locker ""
              :page "☰"
              :line_number ""
              :connected ""
              :dos ""
              :unix ""
              :mac ""
              :mathematical_L "𝑳"
              :vertical_bar "┃"
              :vertical_bar_thin "│"
              :left ""
              :right ""
              :block "█"
              :left_filled ""
              :right_filled ""
              :slant_left ""
              :slant_left_thin ""
              :slant_right ""
              :slant_right_thin ""
              :slant_left_2 ""
              :slant_left_2_thin ""
              :slant_right_2 ""
              :slant_right_2_thin ""
              :left_rounded ""
              :left_rounded_thin ""
              :right_rounded ""
              :right_rounded_thin ""
              :circle "●"})
(fn get-diag [str]
  (let [diagnostics (vim.diagnostic.get 0
                                        {:severity (. vim.diagnostic.severity
                                                      str)})
        count (length diagnostics)]
    (or (and (> count 0) (.. " " count " ")) "")))
(fn vi-mode-hl []
  (or (. vi.colors (vim.fn.mode)) :UserSLViBlack))
(fn vi-sep-hl []
  (or (. vi.sep (vim.fn.mode)) :UserSLBlack))
(fn file-info []
  (let [list {}]
    (when vim.bo.readonly
      (table.insert list "🔒"))
    (when vim.bo.modified
      (table.insert list "●"))
    (table.insert list
                  (vim.fn.fnamemodify (vim.api.nvim_buf_get_name 0) ":~:."))
    (table.concat list " ")))
(local c {:vimode {:provider (fn []
                               (fmt " %s " (. vi.text (vim.fn.mode))))
                   :hl vi-mode-hl
                   :right_sep {:str " " :hl vi-sep-hl}}
          :gitbranch {:provider :git_branch
                      :icon " "
                      :hl :UserSLGitBranch
                      :right_sep {:str "  " :hl :UserSLGitBranch}
                      :enabled (fn []
                                 (not= vim.b.gitsigns_status_dict nil))}
          :file_type {:provider (fn []
                                  (fmt " %s " (vim.bo.filetype:upper)))
                      :hl :UserSLAlt}
          :fileinfo {:provider {:name :file_info :opts {:type :relative}}
                     :hl :UserSLAlt
                     :left_sep {:str " " :hl :UserSLAltSep}
                     :right_sep {:str " " :hl :UserSLAltSep}}
          :file_enc {:provider (fn []
                                 (local os (or (. icons vim.bo.fileformat) ""))
                                 (fmt " %s %s " os vim.bo.fileencoding))
                     :hl :StatusLine
                     :left_sep {:str icons.left_filled :hl :UserSLAltSep}}
          :cur_position {:provider (fn []
                                     (fmt " %3d:%-2d "
                                          (unpack (vim.api.nvim_win_get_cursor 0))))
                         :hl vi-mode-hl
                         :left_sep {:str icons.left_filled :hl vi-sep-hl}}
          :cur_percent {:provider (fn []
                                    (.. " "
                                        ((. (require :feline.providers.cursor)
                                            :line_percentage))
                                        "  "))
                        :hl vi-mode-hl
                        :left_sep {:str icons.left :hl vi-mode-hl}}
          :default {:provider "" :hl :StatusLine}
          :lsp_status {:provider (fn []
                                   (or (and (= (vim.tbl_count (vim.lsp.buf_get_clients 0))
                                               0)
                                            "")
                                       " ◦ "))
                       :hl :UserSLStatus
                       :left_sep {:str ""
                                  :hl :UserSLStatusBg
                                  :always_visible true}
                       :right_sep {:str ""
                                   :hl :UserSLErrorStatus
                                   :always_visible true}}
          :lsp_error {:provider (fn []
                                  (get-diag :ERROR))
                      :hl :UserSLError
                      :right_sep {:str ""
                                  :hl :UserSLWarnError
                                  :always_visible true}}
          :lsp_warn {:provider (fn []
                                 (get-diag :WARN))
                     :hl :UserSLWarn
                     :right_sep {:str ""
                                 :hl :UserSLInfoWarn
                                 :always_visible true}}
          :lsp_info {:provider (fn []
                                 (get-diag :INFO))
                     :hl :UserSLInfo
                     :right_sep {:str ""
                                 :hl :UserSLHintInfo
                                 :always_visible true}}
          :lsp_hint {:provider (fn []
                                 (get-diag :HINT))
                     :hl :UserSLHint
                     :right_sep {:str ""
                                 :hl :UserSLFtHint
                                 :always_visible true}}
          :in_fileinfo {:provider :file_info :hl :StatusLine}
          :in_position {:provider :position :hl :StatusLine}
          :file_winbar {:provider file-info :hl :Comment}})
(local active {1 {1 c.vimode 2 c.gitbranch 3 c.fileinfo 4 c.default}
               2 {1 c.lsp_status
                  2 c.lsp_error
                  3 c.lsp_warn
                  4 c.lsp_info
                  5 c.lsp_hint
                  6 c.file_type
                  7 c.file_enc
                  8 c.cur_position
                  9 c.cur_percent}})
(local inactive {1 {1 c.in_fileinfo} 2 {1 c.in_position}})
((. (require :feline) :setup) {:components {: active : inactive}
                               :highlight_reset_triggers {}
                               :force_inactive {:filetypes {1 :NvimTree
                                                            2 :packer
                                                            3 :dap-repl
                                                            4 :dapui_scopes
                                                            5 :dapui_stacks
                                                            6 :dapui_watches
                                                            7 :dapui_repl
                                                            8 :LspTrouble
                                                            9 :qf
                                                            10 :help}
                                                :buftypes {1 :terminal}
                                                :bufnames {}}
                               :disable {:filetypes {1 :dashboard 2 :startify}}})	
