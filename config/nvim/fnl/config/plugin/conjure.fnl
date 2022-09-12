(module config.plugin.conjure
  {require {conjure-python config.plugin.conjure-python}
   autoload {nvim aniseed.nvim
             core aniseed.core
             path plenary.path}})

(set nvim.g.conjure#mapping#doc_word "K")
(set nvim.g.conjure#client#clojure#nrepl#eval#auto_require false)
(set nvim.g.conjure#client#clojure#nrepl#connection#auto_repl#enabled false)
(set nvim.g.conjure#log#wrap true)


;; function! ClerkShow()
;;   exe "w"
;;   exe "ConjureEval (nextjournal.clerk/show! \"" . expand("%:p") . "\")"
;; endfunction

;; nmap <silent>  :execute ClerkShow()<CR>

;; (path.absolute "C:\\Users\\carlk\\repos\\vim-config\\config\\nvim\\fnl\\config\\plugin\\conjure.fnl")
;; (path.normalize "C:\\Users\\carlk\\repos\\vim-config\\config\\nvim\\fnl\\config\\plugin\\conjure.fnl")
;; (path.make_relative (vim.fn.expand "%:p"))
;;
(defn clerk-show []
  (let [path (vim.fn.expand "%:p")
        full-cmd  (.. "ConjureEval (nextjournal.clerk/show! \"" path "\")")]
    (print (vim.inspect path))
    (print (vim.inspect full-cmd))
    (vim.api.nvim_command "w")
    (vim.api.nvim_command full-cmd)))

;; Undo commenting this
;; (vim.keymap.set :n :<localleader>cs clerk-show {:noremap true})

(defn wrap-fnl-dbg []
  (vim.api.nvim_command "norm ,wdbg"))

(defn wrap-clj-dbg []
  (vim.api.nvim_command "norm ,wd/dbg"))

(defn wrap-clj-dbgn []
  (vim.api.nvim_command "norm ,wd/dbgn"))

(let [group (vim.api.nvim_create_augroup "WrapDebugMacro" {:clear true})]
     (vim.api.nvim_create_autocmd 
       "FileType"
       {:pattern ["fennel"]
        :group group
        :callback (fn [] 
                    (vim.schedule 
                      (fn [] (print "Adding fennel keymaps")))
                    (vim.keymap.set :n :<localleader>db wrap-fnl-dbg {:noremap true :buffer true :desc "Wrap debug"}))})
        
     (vim.api.nvim_create_autocmd
       "FileType"
       {:pattern ["clojure"]
        :group group
        :callback (fn [] 
                     (vim.schedule 
                       (fn [] (print "Adding clojure keymaps")))
                     (vim.keymap.set :n :<localleader>db wrap-clj-dbg {:noremap true :buffer true :desc "Wrap debug"})
                     (vim.keymap.set :n :<localleader>dn wrap-clj-dbgn {:noremap true :buffer true :desc "Wrap nested debug"}))}))
        

;; How to map this with autocommand based on filetype??

(local repl-options [:server :app])
(var current-repl-index 0)

(defn toggle-shadow-repl []
  (vim.cmd "ConjureEval :repl/quit")
  ;; Increment index
  (set current-repl-index (% (+ current-repl-index 1) 2))
  (vim.cmd (.. "ConjureShadowSelect " (. repl-options (+ current-repl-index 1)))))

(let [group (vim.api.nvim_create_augroup "ShadowCljs" {:clear true})]
  (vim.api.nvim_create_autocmd 
       "FileType"
       {:pattern ["clojure"]
        :group group
        :callback (fn [] 
                    (vim.schedule 
                      (fn [] (print "Adding clojure keymaps")))
                    (vim.keymap.set :n :<localleader>rt toggle-shadow-repl {:noremap true :buffer true :desc "Toggle Shadow Repl"}))}))
