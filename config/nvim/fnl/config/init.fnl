(module config.init
  {autoload {core aniseed.core
             nvim aniseed.nvim
             util config.util
             autil aniseed.nvim.util
             str aniseed.string
             indent-blankline config.plugin.indent-blankline}})

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

(vim.keymap.set :n :n :nzz {:noremap true})
(vim.keymap.set :n :N :Nzz {:noremap true})

;; No whitespace in diff
(vim.cmd " set diffopt+=iwhiteall")

(comment
 (vim.opt.diffexpr)
 (vim.opt.diffopt)
 )

;; whitespace characters
(indent-blankline.setup-whitespace-opts)


;; cmdline height
;; After updating to nvim 0.7 cmdheight was set to 24 for unknown reasons
(set vim.opt_global.cmdheight 1)
;; (vim.cmd "set cmdheight=1")

; font 
(set vim.o.guifont "FiraCode NF:h11")

;; next and previous tab keymaps
(nvim.set_keymap :n "]t" "<cmd>tabnext<CR>" {:nowait true :silent true :noremap true})
(nvim.set_keymap :n "[t" "<cmd>tabprevious<CR>" {:nowait true :silent true :noremap true})
(nvim.set_keymap :n "<leader>tc" "<cmd>tabclose<CR>" {:nowait true :silent true :noremap true})
(nvim.set_keymap :n "<leader>tn" "<cmd>tabnew<CR>" {:nowait true :silent true :noremap true})

(nvim.set_keymap :n "<leader>ql" "<cmd>call setloclist(0, [], ' ', {'items': get(getqflist({'items': 1}), 'items')}) | lopen<CR>" {:nowait true :silent true :noremap true})


;; cursor highlighting
(set vim.o.cursorline true)
; Wrap lines on word
(vim.cmd ":set wrap lbr")
(set vim.go.breakindent true)
(vim.cmd "let &showbreak= ' '")
(set vim.go.wrap true)
(vim.cmd ":windo set wrap")


; Copy filename to clipboard
(vim.api.nvim_create_user_command "FilenameToClipboard" (fn [] (vim.fn.setreg "+" (vim.fn.expand "%:t"))) {}))

;; lua vim.fn.setreg('"', vim.fn.expand("%:t"))

; Set filetype to HTML for CSHTML files
(vim.cmd "autocmd BufNewFile,BufRead *.cshtml set filetype=html")

; Set filetype for .h files to be pure C with doxygen
; https://www.alexeyshmalko.com/2014/using-vim-as-c-cpp-ide/
(vim.cmd
 "
 augroup project
 autocmd!
 autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
 augroup END
 ")

(nvim.set_keymap :n :\c ":checktime<CR>" {:nowait true :silent true :noremap true})

; https://www.reddit.com/r/neovim/comments/f0qx2y/automatically_reload_file_if_contents_changed/
(vim.cmd
 "
 \" trigger `autoread` when files changes on disk
 set autoread
 autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
 \" notification after file change
 autocmd FileChangedShellPost *
 \\ echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None
 ")
 

(vim.cmd "
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END")

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

; Movement
(vim.cmd
  "
  nnoremap <expr> j v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'j' : 'gj'
  nnoremap <expr> k v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'k' : 'gk'
  ")


;; Turning diagnostics off and then on seems to cause excessive RAM usage and freezing
;; (var diagnostics-active true)
;; (vim.keymap.set :n :<leader>dd (fn [] 
;;                                 (set diagnostics-active (not diagnostics-active))
;;                                 (print (.. "Diagnostics " (if diagnostics-active "active" "inactive")))
;;                                 (if diagnostics-active
;;                                   (vim.diagnostic.show)
;;                                   (vim.diagnostic.hide)))
;;                                 {:noremap true
;;                                  :silent true 
;;                                  :desc "Toggle diagnostics"})
  

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


;; treesitter folder
;; (set vim.opt.foldmethod "expr")
;; (set vim.opt.foldexpr "nvim_treesitter#foldexpr()")
;; (vim.cmd "autocmd BufReadPost,FileReadPost * normal zR")

;; There are multiple python versions installed on WSL2 Ubuntu... so set the version we want to use
(when (= (vim.fn.has :unix) 1)
  (set vim.g.python3_host_prog "/usr/bin/python3.8"))

;import plugin.fnl
(require :config.plugin)
