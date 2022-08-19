(module config.plugin.fzf
  {autoload {nvim aniseed.nvim
             autil aniseed.nvim.util
             core aniseed.core
             astring aniseed.string
             fs aniseed.fs
             scandir plenary.scandir
             path plenary.path
             fzf fzf
             which-key which-key
             fennel fennel}
             
   require-macros [config.debug-macros]})


;; let g:fzf_force_24_bit_colors=1
(set vim.g.fzf_force_termguicolors 1)

;;(vim.fn.fzf#install)

; FZF layout set to bottom of screen
(set vim.g.fzf_layout {:down "40%"})

; <M-R> reg to paspte contexts of register into terminal (which is where fzf is run)
(vim.cmd 
  "if has('nvim')
      tnoremap <expr> <M-r> '<C-\\><C-N>\"'.nr2char(getchar()).'pi'
  endif")

;; Copy selection into h register, Open RG terminal, paste contexts of h register into terminal
;; (nvim.set_keymap :v :<c-f> "\"hy:Rg<Enter><M-r>h" {})

;; Copy selection into h register, open command mode, type Rg command, paste contents of h register, enter
(nvim.set_keymap :v :<c-f> "\"hy:Rg <c-r>h<cr>" {})



(if (vim.fn.executable "rg")
  (set vim.o.grepprg "rg --vimgrep"))

;; Enable command history
(set vim.g.fzf_history_dir "~/.local/share/fzf-history")

(defn get-rg-expanded-cmd [x]
  (let [expanded (vim.fn.expand x)]
        ;escaped (vim.fn.shellescape expanded)
        
    
    (core.str ":Rg " expanded)))

; RG from git root
(vim.cmd
 "
command! -bang -nargs=* GGrep
\\ call fzf#vim#grep(
\\   'git grep --line-number -- '.shellescape(<q-args>), 0,
\\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
")
(nvim.set_keymap :n :<leader>fk ":GGrep<CR>" {:noremap true})

(defn rg-expand [x] 
  (vim.cmd (get-rg-expanded-cmd x)))

(comment 
 (rg-expand "<cword>"))

(defn fzf-root []
  (let [expanded (.. (vim.fn.expand "%:p:h") ";")
        path (vim.fn.finddir ".git" expanded)
        subbed (vim.fn.substitute path ".git" "" "")
        result (vim.fn.fnamemodify subbed ":p:h")]
      
      result))

(vim.keymap.set :n :<leader>fu (fn [] 
                                 (vim.cmd (.. ":Files " (fzf-root)))) {:noremap true})

(defn get-lua-cmd [func-name params]
  (.. ":lua require('" *module-name* "')['" func-name "']('" (astring.join ", " params) "')<CR>"))

; start search with word 
(nvim.set_keymap :n :<leader>fwg (get-lua-cmd "rg-expand" ["<cword>"]) {:noremap true})
(nvim.set_keymap :n :<leader>fWg (get-lua-cmd "rg-expand" ["<cWORD>"]) {:noremap true})

(nvim.set_keymap :n :<leader>fwh ":call fzf#vim#tags(expand('<cword>'))<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fWh ":call fzf#vim#tags(expand('<cWORD>'))<CR>" {:noremap true})

;; Create getVisualSelection() function
(defn getVisualSelection []
  
  (vim.api.nvim_exec
   "
   function! s:getVisualSelection()
     let [line_start, column_start] = getpos(\"'<\")[1:2]
     let [line_end, column_end] = getpos(\"'>\")[1:2]
     let lines = getline(line_start, line_end)

     if len(lines) == 0
     return \"\"
     endif

     let lines[-1] = lines[-1][:column_end - (&selection == \"inclusive\" ? 1 : 2)]
     let lines[0] = lines[0][column_start - 1:]

     return join(lines, \"\\n\")
   endfunction

   call s:getVisualSelection()
   "
   true))
  

(defn get-escaped-visual-selection [])
 ;; (print (vim.inspect (vim.fn.substitute (getVisualSelection) "[" "AAA" "")))
 ;;(vim.fn.substitute (getVisualSelection) "[" "\\\\$1" "")
                                             

(comment 
  
  (vim.fn.substitute "abc" "(a)" "\\1aaa" ""))
  

(nvim.set_keymap :v :<leader>fn (get-lua-cmd "get-escaped-visual-selection" []) {:noremap true})

;; (vim.api.nvim_exec "call s:getVisualSelection()" true)

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

(def- file-patterns
  [{:suffix "Controller"} 
   {:suffix "ViewComponent"} 
   {:suffix "ViewModel"} 
   {:suffix "Model"} 
   {:suffix "Page"} 
   {:match "Default"
    :callback-fn (lambda [filename full-filename] 
                   (get-parent full-filename))}])

(defn- get-suffix-pattern [x]
  (core.str x "$"))

(defn- remove-suffix [filename suffix]
  (string.gsub filename (get-suffix-pattern suffix) ""))

(defn get-file-pattern-result [filename full-filename pattern]
   (let [{:suffix suffix-str
          :match match-str
          :callback-fn callback-fn} pattern]
     
     (if 
       suffix-str ; Remove suffix
       (remove-suffix filename suffix-str)
       
       match-str ; Callback fn
       (if (= match-str filename)
         (callback-fn filename full-filename)))))


(defn- get-common-name [filename full-filename]
  (or (->> file-patterns
           (core.map 
             #(get-file-pattern-result filename full-filename $)) 

           (core.filter 
             #(not (or (= filename $) ; Remove anything equal to orig name
                       (core.nil? $)))) 

           (core.first)) ; use the first result

      ; If nothing, use original filename
      filename))

(get-this-full-filename)

(comment
  (get-common-name "Default" "config\\nvim\\fnl\\config\\plugin\\Default.fnl")
  (get-common-name "xxxViewComponent")
  (get-common-name "xxx"))

(defn fzf-file-query [query]
  (vim.fn.fzf#vim#gitfiles "." (vim.fn.fzf#vim#with_preview {:options ["--query" query 
                                                                       ;; "--layout=reverse" 
                                                                       "--info=inline"]})))

(defn fzf-this-file []
  (let [this-file (get-this-filename)
        this-full-filename (get-this-full-filename)
        common-name (get-common-name this-file this-full-filename)]
    (fzf-file-query common-name)))

(vim.keymap.set :n :<leader>fF fzf-this-file {:noremap true :silent false})

(comment
   (nvim.set_keymap :n :<leader>fF ":lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})<cr>" {:noremap true :silent false})
   (vim.cmd ":lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})")
   (vim.api.nvim_command "lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})")
   (vim.api.nvim_exec ":lua vim.fn['fzf#vim#files']('.', {options={'--query=aaa', '--layout=reverse', '--info=inline'}})" true))

   

(nvim.set_keymap :n :<leader>fg "<cmd>Rg<CR>" {:noremap true})

;; Disable preview window as it interferes with input on work machine
(set vim.g.fzf_preview_window "")


;; Debugging fzf plugin
(comment 
  (vim.cmd "call executable('fzf')")
  (vim.api.nvim_exec "echo executable('fzf')" true) ; "1"
  (vim.api.nvim_exec "echo exepath('fzf')" true) ; "C:\\bin\\fzf.EXE"
  (vim.api.nvim_exec "echo fzf#shellescape('fzf') . ' --version'" true) 
  (vim.api.nvim_exec "echo fzf#shellescape('fzf')" true) ; "^\"fzf^\""

  (vim.api.nvim_exec "echo systemlist(fzf#shellescape('fzf') . ' --version')" true) 
; "['^fzf^ : The term ''^fzf^'' is not recognized as the name of a cmdlet, function, script file, or operable program. Check \r', 'the spelling of the name, or if a path was included, verify that the path is correct and try again.\r', 'At line:1 char:82\r', '+ ... onsole]::OutputEncoding=[System.Text.Encoding]::UTF8; ^\"fzf^\" --versi ...\r', '+                                                           ~~~~~~~\r', '    + CategoryInfo          : ObjectNotFound: (^fzf^:String) [], CommandNotFoundException\r', '    + FullyQualifiedErrorId : CommandNotFoundException\r', ' \r']"


  ;; 3b7a962dc6db227d18faecb25c793431ce7e8640
  (vim.api.nvim_exec "execute('fzf --version')" true) ; "1"
  (vim.api.nvim_exec "call executable('fzf')" true) ; ""
  )


(defn set-rg-match-color [color] 
 "Sets the rg foreground color for matches 
 color: red, blue, green, cyan, magenta, yellow, white and black OR r,g,b string"
  (vim.cmd
    (.. 
      "command! -bang -nargs=* Rg "
      "call fzf#vim#grep("
      "'rg "
      "--colors match:fg:" color " "
      "--column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,"
      "fzf#vim#with_preview(), <bang>0)")))

(defn set-rg-match-color-rbg [r g b]
  (set-rg-match-color (.. r "," g "," b)))

(set-rg-match-color-rbg 0 255 128)

(comment 
 (set-rg-match-color "blue")
 )
