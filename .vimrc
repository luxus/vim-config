
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
Plug 'chrisbra/SudoEdit.vim'

Plug 'romgrk/github-light.vim'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-startify'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

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

"colour schemes
Plug 'romgrk/doom-one.vim'
Plug 'bluz71/vim-nightfly-guicolors'

if !exists('g:vscode')
  Plug 'folke/which-key.nvim'
  Plug 'akinsho/toggleterm.nvim'
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
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'rmagatti/auto-session'
Plug 'rmagatti/session-lens'

Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-sexp'

Plug 'Olical/aniseed', { 'tag': 'v3.23.0' }
Plug 'Olical/conjure', {'tag': 'v4.25.0'}

Plug 'hrsh7th/cmp-buffer'
Plug 'PaterJason/cmp-conjure'
Plug 'hrsh7th/nvim-cmp'

Plug 'coddingtonbear/neomake-platformio'

call plug#end()



" Non-plugin config
:let maplocalleader = ','

" colorscheme gruvbox
" colorscheme github-light
" :set background=light
colorscheme nightfly
:set background=dark
:set smartcase
:set smartindent
:set autoindent
:set ignorecase
:set scrolloff=10
:set clipboard=unnamedplus
:set inccommand=nosplit
:set expandtab
:set tabstop=8
:set softtabstop=0
:set shiftwidth=4
:set smarttab
"
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

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> ga <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>



lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
-- You dont need to set any of these options. These are the default ones. Only

-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    project = {
      base_dirs = {
        'C:/repos',
        '~/source/repos',
      },
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')



require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim 
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
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

