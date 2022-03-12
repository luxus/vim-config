(module config.plugin.vs
  {autoload {nvim aniseed.nvim
             astring aniseed.string
             autil aniseed.nvim.util
             path plenary.path }})



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

;; TODO: Don't run this config if not on windows with powershell

;; TODO: move this into comment module for sharing
(defn get-lua-cmd [func-name params]
  (.. ":lua require('" *module-name* "')['" func-name "']('" (astring.join ", " params) "')<CR>"))

(defn open-in-vs [] 
  (vim.api.nvim_command 
    ;; '&' executes the string containing the path to the devenv executable
    (.. "silent !& \"C:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/devenv.exe\" /Edit "
        (vim.fn.expand "%"))))

(defn setup [config] 
  
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
  (vim.api.nvim_command (.. "silent !New-Item -Path '~/.nvim-listen-address' -Force -ItemType File -Value '" 
                            (get-nvim-listen-address) 
                            "'"))

  (nvim.set_keymap :n :<leader>ov (get-lua-cmd "open-in-vs" []) {:nowait true :noremap true})

  )
