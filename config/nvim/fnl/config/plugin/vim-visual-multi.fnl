(module config.plugin.nvim-visual-multi
  {autoload {nvim aniseed.nvim}})

(set vim.g.VM_maps {"Find Under" :<C-1>
                    "Find Subword Under" :<C-1>}) 

;; (vim.cmd "
;;
;; let g:VM_maps = {}
;; let g:VM_maps['Find Under']         = '<C-1>'
;; let g:VM_maps['Find Subword Under'] = '<C-1>'
;;
;;          ")

;; (vim.inspect vim.g.VM_maps)

