(module config.plugin.scrach
    {autoload {nvim aniseed.nvim}})

(nvim.set_keymap :n :<leader>bs "<cmd>Scratch<CR>" {:noremap true :silent true})
