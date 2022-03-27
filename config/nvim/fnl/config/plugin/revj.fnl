(module config.plugin.revj
  {autoload {nvim aniseed.nvim
             revj revj}})


(revj.setup {:brackets {:first "([{<" :last ")]}>"}
             :new_line_before_last_bracket true
             :add_seperator_for_last_parameter true
             :enable_default_keymaps false
             :keymaps {:operator :<Leader>J
                       :line :<Leader>j
                       :visual :<Leader>j}
             :parameter_mapping "a"})	
