(module config.plugin.vs
  {autoload {nvim aniseed.nvim
             astring aniseed.string
             acore aniseed.core
             autil aniseed.nvim.util
             path plenary.path
             job plenary.job
             uv vim.loop}})



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

;; TODO: move this into comment module for sharing
(defn get-lua-cmd [func-name params]
  (.. ":lua require('" *module-name* "')['" func-name "']('" (astring.join ", " params) "')<CR>"))


;; Do this with plenary jobs?
(defn open-in-vs-pwsh [devenv-path] 
  (let [current-file (vim.fn.expand "%")]
    (vim.api.nvim_command 
      ;; '&' executes the string containing the path to the devenv executable
      (.. "silent !& \"" devenv-path "\" /Edit "
          current-file))))

(let [
      uv vim.loop
      stdin (uv.new_pipe false)
      stdout (uv.new_pipe false)
      stderr (uv.new_pipe false)
      current-file (vim.fn.expand "%")
      ;; handle (uv.spawn :rg
      ;;                    {:args {1 :--files} :stdio {1 stdin 2 stdout 3 stderr}}
      ;;                    (fn []))
      ;; handle (uv.spawn :rg
      ;;                    {:args [:--files] :stdio [stdin stdout stderr]}
      ;;                    (fn []))
      handle (uv.spawn "C:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/devenv.exe"
                         {:args [:/Edit current-file] :stdio [stdin stdout stderr]}
                         (fn []))
      ]

  (uv.read_start stdout (fn [err data]
                          (assert (not err) err)
                          (when data
                            (print (vim.inspect data)))))
  (uv.read_start stderr (fn []))
  (uv.shutdown stdin (fn []
                       (uv.close handle (fn []))))  
 )

(do
  (defn open-in-vs [devenv-path] 
    (let [current-file (vim.fn.expand "%")
          devenv-job 
          (job:new {:command "C:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/devenv.exe"
                    :args [:/Edit current-file]
                    :cwd "C:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE"
                    :env {:a :b}
                    :on_exit (fn [j return-val]
                               (print return-val)
                               (print (j:result)))})
          ]

      (acore.pr "JOB" devenv-job)
      ;; (job:sync devenv-job)
      (devenv-job:sync)
      ;;(: devenv-job :start)
      )) 
  
  (open-in-vs "C:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/devenv.exe"))


(do 
  
  (fn test [directory]
    (let [finder (job:new {:command :find
                           :args {1 directory
                                  2 :-type
                                  3 :f
                                  4 :-name
                                  5 :*_spec.lua}})]
      (vim.tbl_map path.new (finder:sync))))


  (test)
  )

(defn- get-full-nvim-listen-address-path [base]
  (vim.fn.expand (.. base "/.nvim-listen-address")))

(defn- write-nvim-listen-address [path]
  (acore.spit path (get-nvim-listen-address)))

(defn- write-nvim-listen-address-pwsh []
  "Write the address using :! and powershell. Kept for reference only"
  ;; execute shell commands silently: https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently
  (vim.api.nvim_command (.. "silent !New-Item -Path '~/.nvim-listen-address' -Force -ItemType File -Value '" 
                             (get-nvim-listen-address) 
                             "'")))

(comment 
  
  (get-full-nvim-listen-address-path "~")

  (let [nvim-listen-address-path "~"]
    (-> (get-full-nvim-listen-address-path nvim-listen-address-path)
        (write-nvim-listen-address)))
  
  )


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

   (acore.println "hi")
   (acore.pr devenv-path)
   (nvim.set_keymap :n :<leader>ov (get-lua-cmd "open-in-vs" [devenv-path]) {:nowait true :noremap true})))
