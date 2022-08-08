(module config.plugin.toggleterm 
    {autoload {toggleterm toggleterm }
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
(vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()")

(vim.cmd "command! -count=1 TermWestTest  lua require'toggleterm'.exec(\"west build -b native_posix -t run\",    <count>, 12)")

(defn send-cri-inspect-cmd [expr count]
  (toggleterm.exec (.. "Runtime.evaluate({expression: '" expr "'})") count 12))

(defn get-visual-selection []
  (let [[_ line_start column_start _] (vim.fn.getpos "'<")
        [_ line_end column_end _] (vim.fn.getpos "'>")
        lines (vim.fn.getline line_start line_end)
        len (length lines)]
    (print line_start line_end)
    (print column_start column_end)
    (print (vim.inspect lines))
    (if (= len 0) 
      ""
      (let [is-inclusive (= vim.o.selection "inclusive")
            end-str (string.sub 
                      (. lines len) ;; last lines
                      1 ;; beginning of line
                      (- (+ column_end 1) (if is-inclusive 1 2)) ;; end of line
                      )
            start-str (string.sub 
                        (. lines 1) ;; first line
                        column_start ;; start
                        -1) ;; end
            ] 
        (do 
          (print (vim.inspect lines))
          (tset lines 1 start-str)
          (tset lines len end-str)
          (print (vim.inspect lines))
          (vim.fn.join lines "\n"))))))

(comment
 (string.sub "abcd" 1 -2) ; "abc"
 )

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
