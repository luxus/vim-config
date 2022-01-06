(module config.init
  {autoload {core aniseed.core
             nvim aniseed.nvim
             util config.util
             str aniseed.string}})

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (nvim.set_keymap mode from to {:noremap true}))

;generic mapping leaders configuration
(nvim.set_keymap :n :<space> :<nop> {:noremap true})
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")
(vim.cmd "nnoremap gp `[v`]")
(vim.cmd "vmap y y`]")
(vim.cmd "filetype plugin indent on")
(set vim.o.scrolloff 7)
(set vim.o.tabstop 4)
(set vim.o.shiftwidth 4)
(set vim.o.softtabstop 4)
(set vim.o.expandtab true)

;; cursor highlighting
(set vim.o.cursorline true)
; Wrap lines on word
(vim.cmd ":set wrap lbr")

;;(vim.cmd "autocmd FileType cs setlocal commentstring=// %s")

(vim.cmd "
  function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv\"sy
    let @/ = '\\V' . substitute(escape(@s, a:cmdtype.'\\'), '\\n', '\\\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
         ")

; shared clipboard (neither work yet)
(set vim.o.clipboard :unnamedplus)
(vim.api.nvim_exec ":set clipboard=unnamedplus" true)


; source config
(nvim.set_keymap :n :<leader>sv ":source $MYVIMRC<CR>" {:noremap true})
; normal mode key
(noremap :i :jk :<esc>)
; mouse mode
(set nvim.o.mouse "a")

;don't wrap lines
(nvim.ex.set :nowrap)

;sets a nvim global options
(let [options
      {;settings needed for compe autocompletion
       :completeopt "menuone,noselect"
       ;case insensitive search
       :ignorecase true
       ;smart search case
       :smartcase true
       ;shared clipboard with linux
       :clipboard "unnamedplus"}]
  (each [option value (pairs options)]
    (core.assoc nvim.o option value)))

;import plugin.fnl
(require :config.plugin)
