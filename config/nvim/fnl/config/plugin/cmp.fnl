(module config.plugin.cmp
  {autoload {nvim aniseed.nvim
             cmp cmp}})

;; Use VSCode snippets
(set vim.g.vsnip_snippet_dir "~/AppData/Roaming/Code/User/snippets")
;;(vim.fn.expand "~/AppData/Roaming/Code/User/snippets")

(def- cmp-src-menu-items
  {:buffer "buff"
   :conjure "conj"
   :nvim_lsp "lsp"})

(def- cmp-srcs
  [{:name :nvim_lsp}
   {:name :conjure}
   {:name :buffer}
   {:name :vsnip}
   {:name :nvim_lsp_signature_help}])

;; Setup cmp with desired settings
(cmp.setup {
            ;:completion {:autocomplete true}
            :snippet {:expand (fn [args] (vim.fn.vsnip#anonymous args.body))}
            :formatting
            {:format (fn [entry item]
                       (set item.menu (or (. cmp-src-menu-items entry.source.name) ""))
                       item)}
            :mapping {:<C-p> (cmp.mapping.select_prev_item)
                      :<C-n> (cmp.mapping.select_next_item)
                      :<C-b> (cmp.mapping.scroll_docs (- 4))
                      :<C-f> (cmp.mapping.scroll_docs 4)
                      :<C-Space> (cmp.mapping.complete)
                      :<C-e> (cmp.mapping.close)
                      :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Insert
                                                  :select true})}
            :sources cmp-srcs})


(cmp.setup.cmdline "/" 
  {:sources [ {:name :buffer} ]})

(cmp.setup.cmdline ":"
                   {:sources (cmp.config.sources 
                               [ {:name :path} ]
                               ;;[ {:name :buffer} ]
                               [ {:name :cmdline
                                  ;; https://github.com/hrsh7th/cmp-cmdline/issues/24
                                  :keyword_pattern "[^[:blank:]\\!]*"} ])})

;; Maximum number of items to show in the popup menu
(set vim.o.pumheight 15)
