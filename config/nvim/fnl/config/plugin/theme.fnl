(module config.plugin.theme
  {autoload {nvim aniseed.nvim
             theme github-theme
             material material}

   require-macros [config.debug-macros]})


(comment

  (dbgn {:aa "aa"})

  ;; For github theme
  (set vim.o.background :light)
  (theme.setup {:theme_style "light"
                :comment_style "italic"})

  ;; (vim.api.nvim_set_hl 0 "Keyword" { :fg "#ffffff" :bg "#333333" })

  (nvim.ex.colorscheme :nightfly)
  (nvim.ex.colorscheme :nightfox)
  (nvim.ex.colorscheme :kanagawa)

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
  (let [theme (if is-dark :nightfox :material)
        background (if is-dark :dark :light)]
    (print "Setting theme:" theme "-" background)
    (set-fzf-colors theme)

    ;; special setup for specific themes
    (match theme
      :material (do
                  (set vim.g.material_style :lighter)
                  (material.setup {:high_visibility {:lighter true}})))

    (nvim.ex.colorscheme theme)
    (set vim.o.background background)))

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
