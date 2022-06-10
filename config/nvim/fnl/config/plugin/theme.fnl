(module config.plugin.theme
  {autoload {nvim aniseed.nvim
             theme github-theme
             material material}})

;; For github theme
;; (set vim.o.background :light)
;; (theme.setup {:theme_style "light"
;;               :comment_style "italic"})

;; (nvim.ex.colorscheme :nightfly)
;; (nvim.ex.colorscheme :embark)
;; 

(comment
 ;; (nvim.ex.colorscheme :base16-gruvbox-dark-soft)
 ;; (nvim.ex.colorscheme :base16-spacemacs)
 ;; (nvim.ex.colorscheme :base16-apathy)
 (nvim.ex.colorscheme :base16-tomorrow-night)
 )




;; (nvim.ex.colorscheme :kanagawa)

(defn set-theme [is-dark]
  (if is-dark
    (do 
      ;; (nvim.ex.colorscheme :falcon)
      (nvim.ex.colorscheme :nightfox)
      (set vim.o.background :dark))

    (do 
      (set vim.g.material_style :lighter)
      (material.setup {:high_visibility {:lighter true}})
      (nvim.ex.colorscheme :material)
      (set vim.o.background :light))

    ;; (do 
    ;;   (theme.setup {:theme_style "light"
    ;;                 :comment_style "italic"})
    ;;   (set vim.o.background :light))
    ))

(set-theme true)

; Toggle theme
(vim.keymap.set :n :<leader>tt #(set-theme (-> vim.o.background (= "dark") not)) {:noremap true})
