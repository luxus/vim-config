(module config.plugin.whichkey
  {autoload {which-key which-key}})

(let [(ok? which-key) (pcall #(require :which-key))]
  (when ok?
    (which-key.setup {})))


