" Plug {{{
" Install vim-plug if missing
 " shellescape(fnamemodify('~/.vim/autoload/plug.vim', ':p'))
if empty(shellescape(fnamemodify('~/.vim/autoload/plug.vim', ':p')))
  silent !curl -fLo shellescape(fnamemodify('~/.vim/autoload/plug.vim', ':p')) --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(shellescape(fnamemodify('~/.vim/autoload/plug.vim', ':p')))

" LSP
" Plug 'neovim/nvim-lsp'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rakr/vim-one'
" Plug 'terryma/vim-multiple-cursors'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}


" Use release branch (recommend)
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'asvetliakov/vim-easymotion'
Plug 'lfilho/cosco.vim'
Plug 'chamindra/marvim'
Plug 'unblevable/quick-scope'

Plug 'vim-scripts/ReplaceWithRegister'

call plug#end()

:set background=light
:set smartcase
:set ignorecase
" colorscheme one

nnoremap gp `[v`]
vmap y y`]

nnoremap <leader><CR> i<CR><Esc>
:set scrolloff=10

let g:camelcasemotion_key = '<leader>'


" Search for selection
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

:set clipboard=unnamedplus


xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

nnoremap gp `[v`]

autocmd FileType javascript,css nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon)
autocmd FileType javascript,css imap <silent> <Leader>; <c-o><Plug>(cosco-commaOrSemiColon)


" Marvim
let g:marvim_find_key = '<Space>' " change find key from <F2> to 'space'
let g:marvim_store_key = 'ms'     " change store key from <F3> to 'ms'

" Quick scope - Make highlight groups work in vscode
highlight QuickScopePrimary guifg='#6B9F1E' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#075B9F' gui=underline ctermfg=81 cterm=underline
