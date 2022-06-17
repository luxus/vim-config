(module config.plugin.vim-slime
    {autoload {vim-slime vim-slime}})

(set vim.g.slime_target :neovim)
(set vim.g.slime_last_channel 21)
(set vim.g.slime_python_ipython 0)

;; There was a viml function called _EscapeText_python previously but was causing errors on start (malformed string). This note is here as a reminder to look it up again if I try vim-slime in the future

(vim.cmd "
fun! StartREPL(repl)
  execute 'terminal '.a:repl
  setlocal nonumber
  let t:term_id = b:terminal_job_id
  wincmd p
  execute 'let b:slime_config = {\"jobid\": \"'.t:term_id . '\"}'
endfun

         ")

(vim.keymap.set :n :<leader>ts ":vsplit<bar>:call StartREPL('python -m IPython')<CR>" {:noremap true :silent true})
