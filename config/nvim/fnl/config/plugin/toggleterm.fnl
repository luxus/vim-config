(module config.plugin.toggleterm 
    {autoload {toggleterm toggleterm}})

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
