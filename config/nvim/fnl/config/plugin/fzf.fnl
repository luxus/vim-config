(module config.plugin.fzf
  {autoload {nvim aniseed.nvim
             core aniseed.core
             astring aniseed.string
             fs aniseed.fs
             scandir plenary.scandir
             path plenary.path
             fzf fzf}})

(if (vim.fn.executable "rg")
  (set vim.o.grepprg "rg --vimgrep"))


; (vim.fn.fzf#vim#files "." {:options ["--query=fnl" "--layout=reverse" "--info=inline" ]})
; (vim.fn.fzf#vim#files "." {:options []})


; :lua vim.fn["fzf#vim#files"](".", {options={"--query=fnl", "--layout=reverse", "--info=inline"}})
; (vim.api.nvim_exec "call fzf#vim#files('.', {'options': ['--query=aaa']})" false)
        
(defn- get-this-filename [] 
  (let [fullpath (vim.fn.expand "%")
        base (fs.basename fullpath)
        temp (-> (string.gsub fullpath base "")
                 ;; remove leading slash
                 (string.gsub "^\\" "")
                 ;; remove ext
                 (astring.split "%.") 
                 (core.first))]
    temp))

(defn get-files-in-dir []
  (scandir.scan_dir 
    (fs.basename (vim.fn.expand "%"))
    {:hidden true :depth 2}))

(defn get-similar-files [filename]
  (->> (get-files-in-dir)
       (core.filter (lambda [x] (string.match x filename)))
       (core.map (lambda [x] (print x)))))

(def- file-suffixes ["Controller" "ViewComponent" "Model" "Default"])

(defn- get-suffix-pattern [x] 
  (core.str x "$"))

(defn- get-common-name [filename] 
  (let [filename-exact-pattern (core.str "^" filename "$")]
    ;; If a "more comon" name cannot be found, use original name
    (or (->> file-suffixes
        (core.map (lambda [x] (string.gsub filename (get-suffix-pattern x) "")))
        (core.filter (lambda [x] (not (string.match x filename-exact-pattern))))
        (core.first))

        filename)))

(comment
  (get-common-name "xxxViewComponent")
  (get-common-name "xxx"))

(defn fzf-file-query [query]
  (let [ cmd-str (core.str  ":lua vim.fn['fzf#vim#files']('.', {options={'--query=" query"', '--layout=reverse', '--info=inline'}})")]
    (vim.cmd cmd-str)))

(defn fzf-this-file []
  (let [this-file (get-this-filename)
        common-name (get-common-name this-file)]
    (print "this-file: " this-file)
    (print "common-name: " common-name)
    (fzf-file-query common-name)))

(nvim.set_keymap :n :<leader>fF ":lua require'config.plugin.fzf'['fzf-this-file']()<cr>" {:noremap true :silent false})

(comment
   (nvim.set_keymap :n :<leader>fF ":lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})<cr>" {:noremap true :silent false})
   (vim.cmd ":lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})")
   (vim.api.nvim_command "lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})")
   (vim.api.nvim_exec ":lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})" true)
   
   )

(nvim.set_keymap :n :<leader>fg "<cmd>Rg<CR>" {:noremap true})
