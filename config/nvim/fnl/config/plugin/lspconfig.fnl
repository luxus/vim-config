(module config.plugin.lspconfig
  {autoload {nvim aniseed.nvim
             c aniseed.core
             lsp lspconfig
             nvim-lsp-installer nvim-lsp-installer
             cmplsp cmp_nvim_lsp}})

;symbols to show for lsp diagnostics
(defn define-signs
  [prefix]
  (let [error (.. prefix "SignError")
        warn  (.. prefix "SignWarn")
        info  (.. prefix "SignInfo")
        hint  (.. prefix "SignHint")]
  (vim.fn.sign_define error {:text "x" :texthl error})
  (vim.fn.sign_define warn  {:text "!" :texthl warn})
  (vim.fn.sign_define info  {:text "i" :texthl info})
  (vim.fn.sign_define hint  {:text "?" :texthl hint})))

(if (= (nvim.fn.has "nvim-0.6") 1)
  (define-signs "Diagnostic")
  (define-signs "LspDiagnostics"))

;server features
(let [handlers {"textDocument/publishDiagnostics"
                (vim.lsp.with
                  vim.lsp.diagnostic.on_publish_diagnostics
                  {:severity_sort true
                   :update_in_insert false
                   :underline true
                   :virtual_text false})
                "textDocument/hover"
                (vim.lsp.with
                  vim.lsp.handlers.hover
                  {:border "single"})
                "textDocument/signatureHelp"
                (vim.lsp.with
                  vim.lsp.handlers.signature_help
                  {:border "single"})}
      capabilities (cmplsp.update_capabilities (vim.lsp.protocol.make_client_capabilities))
      on_attach (fn [client bufnr]
                  (do
                    (nvim.buf_set_keymap bufnr :n :gd "<Cmd>lua vim.lsp.buf.definition()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :K "<Cmd>lua vim.lsp.buf.hover()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>ld "<Cmd>lua vim.lsp.buf.declaration()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lt "<cmd>lua vim.lsp.buf.type_definition()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lh "<cmd>lua vim.lsp.buf.signature_help()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>ln "<cmd>lua vim.lsp.buf.rename()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>le "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lq "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lf "<cmd>lua vim.lsp.buf.formatting()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lj "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lk "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>" {:noremap true})
                    ;telescope
                    (nvim.buf_set_keymap bufnr :n :<leader>lo ":lua require('telescope.builtin').lsp_document_symbols()<cr>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>la ":lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor())<cr>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :v :<leader>la ":'<,'>:Telescope lsp_range_code_actions theme=cursor<cr>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lw ":lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>lr ":lua require('telescope.builtin').lsp_references()<cr>" {:noremap true})
                    (nvim.buf_set_keymap bufnr :n :<leader>li ":lua require('telescope.builtin').lsp_implementations()<cr>" {:noremap true})))]

  (nvim-lsp-installer.on_server_ready 
    (fn on-server-ready-handler [server]

      (let [opts {:on_attach on_attach
                  :handlers handlers
                  :capabilities capabilities}]
       
      ; Include additional filetypes for clangd as it does not recognise c.doxygen by default
        (when (= server.name "clangd")
          (c.assoc-in opts [:filetypes ] [ "c" "cpp" "objc" "objcpp" "c.doxygen"])
          ; Hard coded the clangd --compile-commands-dir argument
          (c.assoc-in opts [:cmd ] [ "clangd" "--compile-commands-dir" "./light_bulb_dongle/build-dk"]))

      (server:setup opts))))
  ;; Clojure
  ; (lsp.clojure_lsp.setup {:on_attach on_attach
  ;                         :handlers handlers
  ;                         :capabilities capabilities})
  )



;; (lsp.clangd.setup 
;;   {:on_init (fn [client]
;;               (set client.config.settings.cmd [ "clangd" "--compile-commands-dir" "./light_bulb_dongle/build-dk"])
;;               (client.notify :workspace/didChangeConfiguration)
;;               true)})	
