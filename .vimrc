
" Install vim-plug if missing
 " shellescape(fnamemodify('~/.vim/autoload/plug.vim', ':p'))
" if empty(shellescape(fnamemodify('~/AppData/Local/nvim/autoload/plug.vim', ':p')))
"   silent !curl -fLo shellescape(fnamemodify('~/AppData/Local/nvim/autoload/plug.vim', ':p')) --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

" call plug#begin('~/AppData/Local/nvim/autoload')
call plug#begin('~/.vim/plugged')

" LSP
" Plug 'neovim/nvim-lsp'
" Plug 'rakr/vim-one'
" Plug 'terryma/vim-multiple-cursors'

Plug 'morhetz/gruvbox'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Use release branch (recommend)
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'asvetliakov/vim-easymotion'
Plug 'lfilho/cosco.vim'
Plug 'chamindra/marvim'
Plug 'unblevable/quick-scope'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'AndrewRadev/sideways.vim'
Plug 'terryma/vim-expand-region'
" Plug 'andymass/vim-matchup'
Plug 'tpope/vim-unimpaired'

if !exists('g:vscode')
  Plug 'folke/which-key.nvim'
  
else

endif

" Clojure
Plug 'tpope/vim-dispatch'
Plug 'clojure-vim/vim-jack-in'
" Only in Neovim:
Plug 'radenling/vim-dispatch-neovim'

Plug 'tpope/vim-vinegar'

Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fannheyward/telescope-coc.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'rmagatti/auto-session'
Plug 'rmagatti/session-lens'

Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-sexp'

Plug 'Olical/aniseed', { 'tag': 'v3.23.0' }
Plug 'Olical/conjure', {'tag': 'v4.25.0'}

call plug#end()



" Non-plugin config
:let maplocalleader = ','

" :set background=light
colorscheme gruvbox
:set background=dark
:set smartcase
:set ignorecase
:set scrolloff=10
:set clipboard=unnamedplus
:set inccommand=nosplit
" colorscheme one

" Non-plugin keymapping
let g:camelcasemotion_key = '<leader>'
nnoremap gp `[v`]
vmap y y`]
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader><CR> i<CR><Esc>
:imap jk <Esc>


" Aniseed
let g:aniseed#env = v:true

" Cosco
autocmd FileType javascript,css nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon)
autocmd FileType javascript,css imap <silent> <Leader>; <c-o><Plug>(cosco-commaOrSemiColon)

" Marvim
let g:marvim_find_key = '<Space>' " change find key from <F2> to 'space'
let g:marvim_store_key = 'ms'     " change store key from <F3> to 'ms'

" Quick scope - Make highlight groups work in vscode
highlight QuickScopePrimary guifg='#6B9F1E' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#075B9F' gui=underline ctermfg=81 cterm=underline

" Sideways
nnoremap <, :SidewaysLeft<cr>
nnoremap >, :SidewaysRight<cr>
" nnoremap <c-l> :SidewaysRight<cr>
" nnoremap <c-l> :SidewaysRight<cr>
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI
nmap <leader>si <Plug>SidewaysArgumentInsertBefore
nmap <leader>sa <Plug>SidewaysArgumentAppendAfter
nmap <leader>sI <Plug>SidewaysArgumentInsertFirst
nmap <leader>sA <Plug>SidewaysArgumentAppendLast

" Vscode

" :command! OpenInVSCode exe "silent !code --goto '" . expand("%") . ":" . line(".") . ":" . col(".") . "'" | redraw!

if !exists('g:vscode')

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

else

  " Vscode neovim
  " Search for selection
  function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine

    " Find in files
  command! FindInFileS call VSCodeNotify('workbench.action.findInFiles', {'query': @p})
  xnoremap <silent> <Leader>f "py<Esc>:FindInFileS<CR>

  command! FindVSCode call VSCodeNotify('actions.find', {'query': @p})
  xnoremap <silent> <C-f> "py<Esc>:FindVSCode<CR>

  " command! ReplaceVSCode call VSCodeNotify('editor.action.startFindReplaceAction', {'query': @p})
  " xnoremap <silent> <C-h> "py<Esc>:ReplaceVSCode<CR>

  " command! EvalulateInDebugConsoleVscode call VSCodeNotify('editor.debug.action.selectionToRepl', {'query': @p})
  " xnoremap <silent> <Leader>d "py<Esc>:EvalulateInDebugConsoleVscode<CR>

  function! s:openVSCodeCommandsInVisualMode()
      normal! gv
      let visualmode = visualmode()
      if visualmode == "V"
          let startLine = line("v")
          let endLine = line(".")
          call VSCodeNotifyRange("actions.find", startLine, endLine, 1)
      else
          let startPos = getpos("v")
          let endPos = getpos(".")
          call VSCodeNotifyRangePos("actions.find", startPos[1], endPos[1], startPos[2], endPos[2], 1)
      endif
  endfunction

  function! s:openVSCodeCommandsInVisualModeAction(action)
      echom :action
      normal! gv
      let visualmode = visualmode()
      if visualmode == "V"
          let startLine = line("v")
          let endLine = line(".")
          call VSCodeNotifyRange(a:action, startLine, endLine, 1)
      else
          let startPos = getpos("v")
          let endPos = getpos(".")
          call VSCodeNotifyRangePos(a:action, startPos[1], endPos[1], startPos[2], endPos[2], 1)
      endif
  endfunction

  xnoremap <silent> <Leader>` :<C-u>call <SID>openVSCodeCommandsInVisualModeAction('editor.debug.action.selectionToRepl')<CR>

  xnoremap <silent> <C-h> :<C-u>call <SID>openVSCodeCommandsInVisualMode()<CR>

endif


