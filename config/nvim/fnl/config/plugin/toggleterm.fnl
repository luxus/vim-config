(module config.plugin.toggleterm 
    {autoload {toggleterm toggleterm
               log conjure.log}
     require-macros [config.debug-macros]})

(macro cdbgn [form]
  (list (sym :dbgn) form {:print-fn (sym :log.dbg)}))

(toggleterm.setup {})

(fn _G.set_terminal_keymaps []
    (let [opts {:buffer 0}]
        (vim.keymap.set "t" "<esc>" "<C-\\><C-n>" opts)
        (vim.keymap.set "t" "jk" "<C-\\><C-n>" opts)
        (vim.keymap.set "t" "<C-h>" "<Cmd>wincmd h<CR>" opts)
        (vim.keymap.set "t" "<C-j>" "<Cmd>wincmd j<CR>" opts)
        (vim.keymap.set "t" "<C-k>" "<Cmd>wincmd k<CR>" opts)
        (vim.keymap.set "t" "<C-l>" "<Cmd>wincmd l<CR>" opts)))


;; if you only want these mappings for toggle term use term://*toggleterm#* instead
(vim.cmd "autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

(vim.cmd "command! -count=1 TermWestTest  lua require'toggleterm'.exec(\"west build -b native_posix -t run\",    <count>, 12)")

(defn send-cri-inspect-cmd [expr count]
  (toggleterm.exec (.. "Runtime.evaluate({expression: '" expr "'})") count 12))

(do 
  (defn trim-lines [lines column-start column-end is-inclusive]
    (let [len (length lines)] 
      (if (= len 0) 
        ""
        (let [end-str (string.sub 
                        (. lines len) ;; last lines
                        1 ;; beginning of line
                        (- (+ column-end 1) (if is-inclusive 1 2)) ;; end of line
                        )

              _ (tset lines len end-str) ;; replace end line

              start-str (string.sub 
                          (. lines 1) ;; first line
                          column-start ;; start
                          -1) ;; end
              ] 
          (do 
            (tset lines 1 start-str) ;; replace end line
            
            (dbgn (vim.inspect lines))
            (vim.fn.join lines "\n"))))))

   (trim-lines [" (string.sub \"abcd\" 1 -2) ; \"abc\""] 3 12 true) ; "string.sub"

   (trim-lines ["(comment" " (string.sub \"abcd\" 1 -2) ; \"abc\""] 2 12 true)
; "comment
;  (string.sub"

  )


(defn get-visual-selection []
  (let [[_ line-start column-start _] (vim.fn.getpos "'<")
        [_ line-end column-end _] (vim.fn.getpos "'>")
        lines (vim.fn.getline line-start line-end)
        len (length lines)]
    (print line-start line-end)
    (print column-start column-end)
    (dbgn (vim.inspect lines))
    (trim-lines lines column-start column-end (= vim.o.selection "inclusive"))))

(comment
 (string.sub "abcd" 1 -2) ; "abc"
 )

;; (print ((. (require :fennel) :view) ["aa" "bb"]))

(vim.api.nvim_create_user_command 
  "GetVisualSelection"
  (fn [opts] (get-visual-selection))
  {:range true})

(vim.api.nvim_create_user_command 
  "TermCRI"
  (fn [opts] (send-cri-inspect-cmd "1 + 300" opts.count))
  {})

(comment
 (send-cri-inspect-cmd "1 + 2")
 )
