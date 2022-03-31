(module config.plugin.vs
  {autoload {nvim aniseed.nvim
             astring aniseed.string
             acore aniseed.core
             autil aniseed.nvim.util
             path plenary.path
             job plenary.job
             uv vim.loop ;; This doesn't seem to actually work
             }})



(defn get-nvim-listen-address []
  ;; (vim.fn.expand "$NVIM_LISTEN_ADDRESS")
  (vim.api.nvim_eval "v:servername"))


(comment
  ;; Was unsuccessfully trying to set an environment variable in powershell
 (vim.api.nvim_command (.. "!$env:NVIM_LISTEN_ADDRESS = '" 
                           (get-nvim-listen-address) 
                           "aaa'"))


 (vim.api.nvim_command (.. "!$env:NVIM_LISTEN_ADDRESS = '" 
                           (get-nvim-listen-address) 
                           "aaa'"))
 
 )

(defn get-lua-cmd [func-name params]
  (.. ":lua require('" *module-name* "')['" func-name "']('" (astring.join ", " params) "')<CR>"))


(defn open-in-vs-pwsh [devenv-path] 
  (let [current-file (vim.fn.expand "%")]
    (vim.api.nvim_command 
      ;; '&' executes the string containing the path to the devenv executable
      (.. "silent !& \"" devenv-path "\" /Edit "
          current-file))))

(defn- open-in-vs [devenv-path]
  "WIP for opening current file in VS using uv"
 (let [uv vim.loop ;; Requiring this as part of the module did not seem to work... not sure why
       stdin (uv.new_pipe false)
       stdout (uv.new_pipe false)
       stderr (uv.new_pipe false)
       current-file (vim.fn.expand "%")
       handle (uv.spawn devenv-path
                        {:args [:/Edit current-file] :stdio [stdin stdout stderr]}
                        (fn []))]

   (uv.read_start stdout (fn [err data]
                           (assert (not err) err)
                           (when data
                             (print (vim.inspect data)))))
   (uv.read_start stderr (fn []))
   (uv.shutdown stdin (fn []
                        (uv.close handle (fn []))))))

(comment
  (open-in-vs "C:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/devenv.exe")
  )

(defn- get-full-nvim-listen-address-path [base]
  (vim.fn.expand (.. base "/.nvim-listen-address")))

(comment
  (get-full-nvim-listen-address-path "~")
  )

(defn- write-nvim-listen-address [path]
  (acore.spit path (get-nvim-listen-address)))

(comment 
  
  (let [nvim-listen-address-path "~"]
    (-> (get-full-nvim-listen-address-path nvim-listen-address-path)
        (write-nvim-listen-address)))
  
  )

(defn- write-nvim-listen-address-pwsh []
  "Write the address using :! and powershell. Kept for reference only"
  ;; execute shell commands silently: https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently
  (vim.api.nvim_command (.. "silent !New-Item -Path '~/.nvim-listen-address' -Force -ItemType File -Value '" 
                             (get-nvim-listen-address) 
                             "'")))




(defn setup [config] 
  (let [{:devenv-path devenv-path
         :nvim-listen-address-base nvim-listen-address-base} config]

   ;; Use powershell (:h shell-powershell)
   (vim.cmd 
     "
     let &shell = has('win32') ? 'powershell' : 'pwsh'
     let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
     let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
     let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
     set shellquote= shellxquote=
     " )

   ;; Store the NVIM_LISTEN_ADDRESS in home dir
   ;; Add location of this file to config, default to home
   (-> (get-full-nvim-listen-address-path nvim-listen-address-base)
       (write-nvim-listen-address))
   
   (nvim.set_keymap :n :<leader>ov (get-lua-cmd "open-in-vs-pwsh" [devenv-path]) {:nowait true :noremap true})
   ))
