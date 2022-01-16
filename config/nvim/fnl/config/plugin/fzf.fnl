(module config.plugin.fzf
  {autoload {nvim aniseed.nvim
             core aniseed.core
             astring aniseed.string
             fs aniseed.fs
             scandir plenary.scandir
             path plenary.path
             fzf fzf
             which-key which-key}})

;;(vim.fn.fzf#install)

(if (vim.fn.executable "rg")
  (set vim.o.grepprg "rg --vimgrep"))

(defn get-rg-expanded-cmd [x]
  (let [expanded (vim.fn.expand x)
        ;escaped (vim.fn.shellescape expanded)
        ]
    
    (core.str ":Rg " expanded)))

(defn rg-expand [x] 
  (vim.cmd (get-rg-expanded-cmd x)))

(comment 
 (rg-expand "<cword>"))

(defn get-lua-cmd [func-name params]
  (.. ":lua require('" *module-name* "')['" func-name "']('" (astring.join ", " params) "')<CR>"))

; start search with word 
; (nvim.set_keymap :n :<leader>fwg ":lua require'config.plugin.fzf'['get-rg-cword-cmd']()" {:noremap true})
(nvim.set_keymap :n :<leader>fwg (get-lua-cmd "rg-expand" ["<cword>"]) {:noremap true})
(nvim.set_keymap :n :<leader>fWg (get-lua-cmd "rg-expand" ["<cWORD>"]) {:noremap true})
; (nvim.set_keymap :n :<leader>fWg ":lua require'config.plugin.fzf'['get-rg-cWORD-cmd']()<CR>" {:noremap true})

(print rg-expand)

(nvim.set_keymap :n :<leader>fwh ":call fzf#vim#tags(expand('<cword>'))<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fWh ":call fzf#vim#tags(expand('<cWORD>'))<CR>" {:noremap true})

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

(def- file-suffixes ["Controller" "ViewComponent" "ViewModel" "Model" "Default"])

(defn- get-suffix-pattern [x]
  (core.str x "$"))

(defn- get-common-name [filename]
  (let [filename-exact-pattern (core.str "^" filename "$")] ; Check for exact match
    ;; If a "more comon" name cannot be found, use original name
    (or (->> file-suffixes
        (core.map #(string.gsub filename (get-suffix-pattern $) "")) ; Remove suffix
        (core.filter #(not (= $ filename))) ; Remove anything equal to orig name
        (core.first)) ; use the first result

        filename)))

(comment
  (get-common-name "xxxViewComponent")
  (get-common-name "xxx"))

(defn fzf-file-query [query]
  (vim.fn.fzf#vim#files "." (vim.fn.fzf#vim#with_preview {:options ["--query" query "--layout=reverse" "--info=inline" ]})))

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

;; Disable preview window as it interferes with input on work machine
(set vim.g.fzf_preview_window "")
