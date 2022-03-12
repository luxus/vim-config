(module config.plugin.vs
  {autoload {nvim aniseed.nvim
             autil aniseed.nvim.util
             path plenary.path }})


;; echo v:servername
;; echo $NVIM_LISTEN_ADDRESS



;; Use powershell (:h shell-powershell)
(vim.cmd 
 "
 let &shell = has('win32') ? 'powershell' : 'pwsh'
 let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
 let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
 let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
 set shellquote= shellxquote=
 " )

(defn get-nvim-listen-address []
  ;; (vim.fn.expand "$NVIM_LISTEN_ADDRESS")
  (vim.api.nvim_eval "v:servername"))

;; Store the NVIM_LISTEN_ADDRESS in home dir
(vim.api.nvim_command (.. "!New-Item -Path '~/.nvim-listen-address' -Force -ItemType File -Value '" 
                          (get-nvim-listen-address) 
                          "'"))

(comment
 (vim.api.nvim_command (.. "!$env:NVIM_LISTEN_ADDRESS = '" 
                           (get-nvim-listen-address) 
                           "aaa'"))


 (vim.api.nvim_command (.. "!$env:NVIM_LISTEN_ADDRESS = '" 
                           (get-nvim-listen-address) 
                           "aaa'"))
 
 )


(defn open-in-vs [] 
  (vim.api.nvim_command 
    ;; '&' executes the string containing the path to the devenv executable
    (.. "!& \"C:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/devenv.exe\" /Edit "
        (vim.fn.expand "%"))))


(autil.fn-bridge "s:fzf_root" "config.plugin.fzf" "fzf-root")
(nvim.set_keymap :n ":lua ")


