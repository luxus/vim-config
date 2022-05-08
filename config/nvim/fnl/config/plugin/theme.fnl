(module config.plugin.theme
  {autoload {nvim aniseed.nvim
             theme github-theme
             mosel mosel.nvim
             material material}})

;; For github theme
;; (set vim.o.background :light)
;; (theme.setup {:theme_style "light"
;;               :comment_style "italic"})

;;(nvim.ex.colorscheme :nightfly)
; (nvim.ex.colorscheme :embark)
;; (nvim.ex.colorscheme :falcon)


;; (set vim.g.material_style "deep ocean")
;; (material.setup)

;; (nvim.ex.colorscheme :kanagawa)

(defn set-theme [is-dark]
  (if is-dark
    (do 
      (nvim.ex.colorscheme :nightfox) 
      (set vim.o.background :dark))

    (do 
      (theme.setup {:theme_style "light"
                    :comment_style "italic"})
      (set vim.o.background :light))))

; Toggle theme
(vim.keymap.set :n :<leader>tt #(set-theme (-> vim.o.background (= "dark") not)) {:noremap true})
