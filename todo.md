# Todo

[ ] Plugin idea - named norm - save norm command for later and recall with telescope

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
[x] git integration
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
[x] number of lines before and after cursor
[] set correct indentation for filetype=cs (csharp)
[] treesitter using telescope
[] get project to recognise top level apps directory and ignore others
[x] sources used for cmp on cmdline
[x] vim impatient
[ ] Harpoon
[x] go through history of fzf input
[ ] make filepaths shorter in telescope prompts, or change layout to make it easier to read?


h 27.58
w 50.96
l 150+

## treesitter

- select statement (or block)
- next function

## vim visual multi

[ ] https://github.com/mg979/vim-visual-multi/wiki/5.-Operators#select-operator

## cmp
- [ ] Disable buffer completions, but keep cmdline completions
  - Have changed config to try do this

## Feline

- [ ] Truncate the branch name instead of the buffer name
- [ ] 


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


[ ] Write a plugin that looks up files with similar names to the current file or in the same dir


- Profiling
  - :h :profile
