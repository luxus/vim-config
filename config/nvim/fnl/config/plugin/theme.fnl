(module config.plugin.theme
  {autoload {nvim aniseed.nvim
             theme github-theme
             material material}})

;; For github theme
; (theme.setup {:theme_style "dark"
;               :comment_style "italic"})

;;(nvim.ex.colorscheme :nightfly)
; (nvim.ex.colorscheme :embark)
; (nvim.ex.colorscheme :falcon)

(set vim.g.material_style "deep ocean")
(material.setup)
(nvim.ex.colorscheme :material)
