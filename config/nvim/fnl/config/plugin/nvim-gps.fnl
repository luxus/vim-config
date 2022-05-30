(module config.plugin.nvim-gps
  {autoload {nvim aniseed.nvim
             nvim-gps nvim-gps}})

(nvim-gps.setup) 

(nvim-gps.is_available)  ;; Returns boolean value indicating whether a output can be provided
(nvim-gps.get_location)  ;; Returns a string with context information (or nil if not available)

