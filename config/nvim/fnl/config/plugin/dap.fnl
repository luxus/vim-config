(module config.plugin.dap
  {autoload {dap dap
             dap-ui dapui
             nvim-dap-virtual-text nvim-dap-virtual-text
             nvim aniseed.nvim}})

; NOT IN USE

(dap-ui.setup)
(nvim-dap-virtual-text.setup)
; (set vim.g.dap_virtual_text true)

(set dap.adapters.chrome
     {:type :executable
      :command :node
      :args [ (.. (os.getenv :HOME)
                    :/repos/vscode-chrome-debug/out/src/chromeDebug.js)]

      ; {1 (.. (os.getenv :HOME)
      ;              :/path/to/vscode-chrome-debug/out/src/chromeDebug.js)}
      })

(set dap.configurations.javascript
     {1 {:type :chrome
         :request :attach
         :program "${file}"
         :cwd (vim.fn.getcwd)
         :sourceMaps true
         :protocol :inspector
         :port 9222
         :webRoot "${workspaceFolder}"}})
(set dap.configurations.typescriptreact
     {1 {:type :chrome
         :request :attach
         :program "${file}"
         :cwd (vim.fn.getcwd)
         :sourceMaps true
         :protocol :inspector
         :port 9222
         :webRoot "${workspaceFolder}"}})	

(fn dap-chrome [] (dap.attach "chrome" dap.configurations.javascriptreact))



; local utils = require('utils')

(nvim.set_keymap :n "<leader>dct" "<cmd>lua require'dap'.continue()<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>dsv" "<cmd>lua require'dap'.step_over()<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>dsi" "<cmd>lua require'dap'.step_into()<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>dso" "<cmd>lua require'dap'.step_out()<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>dtb" "<cmd>lua require'dap'.toggle_breakpoint()<CR>" {:noremap true})

(nvim.set_keymap :n "<leader>dsc" "<cmd>lua require'dap.ui.variables'.scopes()<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>dhh" "<cmd>lua require'dap.ui.variables'.hover()<CR>" {:noremap true})
(nvim.set_keymap :v "<leader>dhv"
          "<cmd>lua require'dap.ui.variables'.visual_hover()<CR>" {:noremap true})

(nvim.set_keymap :n "<leader>duh" "<cmd>lua require'dap.ui.widgets'.hover()<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>duf"
          "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>" {:noremap true})

(nvim.set_keymap :n "<leader>dsbr"
          "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>dsbm"
          "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>dro" "<cmd>lua require'dap'.repl.open()<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>drl" "<cmd>lua require'dap'.repl.run_last()<CR>" {:noremap true})


; nvim-dap-ui
(nvim.set_keymap :n "<leader>dui" "<cmd>lua require'dapui'.toggle()<CR>" {:noremap true})
(nvim.set_keymap :v :<M-k> "<Cmd>lua require('dapui').eval()<CR>" {:noremap true})


;; Telescope bindings

(nvim.set_keymap :n "<leader>dcc"
          "<cmd>lua require'telescope'.extensions.dap.commands{}<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>dco"
          "<cmd>lua require'telescope'.extensions.dap.configurations{}<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>dlb"
          "<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>dv"
          "<cmd>lua require'telescope'.extensions.dap.variables{}<CR>" {:noremap true})
(nvim.set_keymap :n "<leader>df"
          "<cmd>lua require'telescope'.extensions.dap.frames{}<CR>" {:noremap true})
