(module config.plugin.theme
  {autoload {nvim aniseed.nvim
             theme github-theme
             rose-pine rose-pine
             kanagawa kanagawa
             material material}

   require-macros [config.debug-macros]})


(comment

  (dbgn {:aa "aa"})

  (set vim.o.background :dark)

  ;; For github theme
  (set vim.o.background :light)
  (theme.setup {:theme_style "light"
                :comment_style "italic"})

  ;; (vim.api.nvim_set_hl 0 "Keyword" { :fg "#ffffff" :bg "#333333" })

  (nvim.ex.colorscheme :nightfly)
  (nvim.ex.colorscheme :nightfox)
  (nvim.ex.colorscheme :kanagawa)

  (nvim.ex.colorscheme :rose-pine)
  (nvim.ex.colorscheme :base16-rose-pine)
  (nvim.ex.colorscheme :base16-rose-pine)


  ;; Base 16
  (nvim.ex.colorscheme :base16-atelier-sulphurpool) ;; yas
  (nvim.ex.colorscheme :base16-embers) ;; easy on eyes
  (nvim.ex.colorscheme :base16-twilight) ;; easy on eyes
  )

(comment 
  
  (set-fzf-colors :falcon))

(defn set-fzf-colors [theme]
  (set vim.g.fzf_colors
       (match theme
         :falcon 
         {"fg"      ["fg" "Comment"]
          "bg"      ["bg" "PMenu"]
          "hl"      ["fg" "Normal"]
          "fg+"     ["fg" "CursorLine" "CursorColumn" "Normal"]
          "bg+"     ["bg" "PMenu" "PMenu"]
          "hl+"     ["fg" "Keyword"]
          "info"    ["fg" "PreProc"]
          "border"  ["fg" "Ignore"]
          "prompt"  ["fg" "Conditional"]
          "pointer" ["fg" "Question"]
          "marker"  ["fg" "Directory"]
          "spinner" ["fg" "Label"]
          "header"  ["fg" "Comment"]}

         ;; :rose-pine 
         ;; {"fg"      ["fg" "Normal"]
         ;;  "bg"      ["bg" "Normal"]
         ;;  "hl"      ["fg" "Comment"]
         ;;  "fg+"     ["fg" "RedrawDebugComposed" "CursorLine" "CursorColumn" "Normal"]
         ;;  "bg+"     ["bg" "RedrawDebugComposed" "CursorLine" "CursorColumn"]
         ;;  "hl+"     ["fg" "Statement"]
         ;;  "info"    ["fg" "PreProc"]
         ;;  "border"  ["fg" "Ignore"]
         ;;  "prompt"  ["fg" "Conditional"]
         ;;  "pointer" ["fg" "Exception"]
         ;;  "marker"  ["fg" "Keyword"]
         ;;  "spinner" ["fg" "Label"]
         ;;  "header"  ["fg" "Comment"]}

         _ ;; default
         {"fg"      ["fg" "Normal"]
          "bg"      ["bg" "Normal"]
          "hl"      ["fg" "Comment"]
          "fg+"     ["fg" "CursorLine" "CursorColumn" "Normal"]
          "bg+"     ["bg" "CursorLine" "CursorColumn"]
          "hl+"     ["fg" "Statement"]
          "info"    ["fg" "PreProc"]
          "border"  ["fg" "Ignore"]
          "prompt"  ["fg" "Conditional"]
          "pointer" ["fg" "Exception"]
          "marker"  ["fg" "Keyword"]
          "spinner" ["fg" "Label"]
          "header"  ["fg" "Comment"]})))

(defn set-theme [is-dark]
  (let [theme (if is-dark :github_dark :material)
        background (if is-dark :dark :light)]
    (print "Setting theme:" theme "-" background)
    (set-fzf-colors theme)

    ;; special setup for specific themes
    (match theme
      :material (do
                  (set vim.g.material_style :lighter)
                  (material.setup {:high_visibility {:lighter true}}))

      :kanagawa (kanagawa.setup {:commentStyle {:italic false}
                                 :keywordStyle {:italic false}
                                 :variablebuiltinStyle {:italic false}})

      :rose-pine (rose-pine.setup {:dark_variant "moon"
                                   :disable_italics true})

      :nightfox (vim.cmd "hi MatchParen cterm=bold gui=bold guifg=#dbc074 guibg=blue"))


    (nvim.ex.colorscheme theme)
    (set vim.o.background background)))

(comment 
  (set-fzf-colors :falcon)
  )

(set-theme true)

;; (defn set-theme [is-dark]
;;   (if is-dark
;;     (do 
;;       ;; (nvim.ex.colorscheme :falcon)
;;       (nvim.ex.colorscheme :kanagawa)
;;       (set vim.o.background :dark))
;;
;;     (do 
;;       (set vim.g.material_style :lighter)
;;       (material.setup {:high_visibility {:lighter true}})
;;       (nvim.ex.colorscheme :material)
;;       (set vim.o.background :light))
;;
;;     ;; (do 
;;     ;;   (theme.setup {:theme_style "light"
;;     ;;                 :comment_style "italic"})
;;     ;;   (set vim.o.background :light))
;;     ))


; Toggle theme
(vim.keymap.set :n :<leader>tt #(set-theme (-> vim.o.background (= "dark") not)) {:noremap true})


;; https://github.com/junegunn/fzf.vim/issues/1152
;; I'm another windows user experiencing strange and sometimes unusable fzf.vim colours (depending on the active theme) due to fzf.vim using 256 ANSI colors rather than 24-bit true colours on windows. My read of the issue is that the fix proposed by @blayz3r hasn't been merged in due to limitations of the old cmd.exe. Can I propose adding a global var like `g:fzf_force_24_bit_colors` so that users who are happy to  
