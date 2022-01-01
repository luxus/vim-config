# Todo
[x] which-key
[x] command history
[x] save session
[x] sexp
[x] auto-pairs
[x] vim-vinegar
[z] terryma/vim-expand-region
[x] multicursor
[x] search history

[x] use mouse
[x] map key to undotree
[x] js
[x] csharp
[x] tree sitter textobj setup
[x] keymaps to go to prev and next tab
  - Already existed
[] eyebrowse in vim for workspaces
[] shared clipboard
[x] tcd for telescope-project (how to set the tab directory)
  - Changed to project-nvim
[] autocommand (autocmd) to choose between lsp or coc bindings
[] git integration
[x] chadtree
[x] search for selection
[x] live grep search hidden folders
[x] builtin.grep_string({opts})                            *builtin.grep_string()*
[x] repeat
[] romgrk/nvim-treesitter-context
[] DAP 
  - Send multiple lines to repl
  - Better keybindings
[] whichkey configure names for mappings
[] learn to use cfdo cdo
[] Configure multicursor to recognise the camelcase words

```viml
  " Vscode neovim
  " Search for selection
  unction! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

```

[ ] :h persistent-undo

## coc.nvim
## actions vs commands?

## clangd

Creating the `compile_commands.json` file from platformio
https://docs.platformio.org/en/latest/integration/compile_commands.html

```bash
pio run -t compiledb
```

Cannot have a blank string as an arugment



-[] modeline


require'telescope.builtin'.live_grep{ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '-u' } }
require'telescope.builtin'.live_grep{ vimgrep_arguments = { 'rg',  '-u' } }
lua require'telescope.builtin'.live_grep{ vimgrep_arguments = { 'rg',  '-u' } }
lua require'telescope.builtin'.live_grep{ vimgrep_arguments = { 'rg',  '--hidden' } }

