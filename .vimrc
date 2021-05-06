" Plug {{{
" Install vim-plug if missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

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
" Plug 'andymass/vim-matchup'

" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }


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