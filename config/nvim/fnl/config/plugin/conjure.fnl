(module config.plugin.conjure
  {autoload {nvim aniseed.nvim
             core aniseed.core
             path plenary.path}})

(set nvim.g.conjure#mapping#doc_word "K")
(set nvim.g.conjure#client#clojure#nrepl#eval#auto_require false)
(set nvim.g.conjure#client#clojure#nrepl#connection#auto_repl#enabled false)


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

(vim.keymap.set :n :<localleader>cs clerk-show {:noremap true})


(defn wrap-dbg []
  (vim.api.nvim_command "norm ,wd/dbg"))

(vim.keymap.set :n :<localleader>db wrap-dbg {:noremap true})

(defn wrap-dbgn []
  (vim.api.nvim_command "norm ,wd/dbgn"))

(vim.keymap.set :n :<localleader>dn wrap-dbg {:noremap true})

