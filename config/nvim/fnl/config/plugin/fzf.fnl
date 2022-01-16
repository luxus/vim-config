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

(defn- get-this-full-filename [] 
  (vim.fn.expand "%"))

(defn- remove-leading-slash [x]
  (string.gsub x "^\\" ""))

(defn- get-this-filename []
  (let [fullpath (get-this-full-filename)
        base (fs.basename fullpath)
        temp (-> (string.gsub fullpath base "")
                 ;; remove leading slash
                 (remove-leading-slash)
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

(defn- get-parent [full-filename]
  (let [base1 (fs.basename full-filename)
        base2 (fs.basename base1)
        parent (-> (string.gsub base1 base2 "")
                   (remove-leading-slash))]
          parent))

(def- file-suffixes
  [{:suffix "Controller"} 
   {:suffix "ViewComponent"} 
   {:suffix "ViewModel"} 
   {:suffix "Model"} 
   {:match "Default"
    :callback-fn (lambda [filename full-filename] 
                   (get-parent full-filename))}])

(defn- get-suffix-pattern [x]
  (core.str x "$"))

(defn- remove-suffix [filename suffix]
  (string.gsub filename (get-suffix-pattern suffix) ""))

(defn- get-common-name [filename full-filename]
  (or (->> file-suffixes
        (core.map 
          #(let [{:suffix suffix-str
                  :match match-str
                  :callback-fn callback-fn} $]
             
             (if 
               suffix-str ; Remove suffix
               (remove-suffix filename suffix-str)
               
               match-str ; Callback fn
               (if (= match-str filename)
                 (callback-fn filename full-filename))))) 

        (core.filter 
          #(not (or (= filename $) ; Remove anything equal to orig name
                    (core.nil? $)))) 

        (core.first)) ; use the first result

        filename))

(get-this-full-filename)

(comment
  (get-common-name "Default" "config\\nvim\\fnl\\config\\plugin\\Default.fnl")
  (get-common-name "xxxViewComponent")
  (get-common-name "xxx"))

(defn fzf-file-query [query]
  (vim.fn.fzf#vim#files "." (vim.fn.fzf#vim#with_preview {:options ["--query" query "--layout=reverse" "--info=inline" ]})))

(defn fzf-this-file []
  (let [this-file (get-this-filename)
        this-full-filename (get-this-full-filename)
        common-name (get-common-name this-file this-full-filename)]
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
