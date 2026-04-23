-- lua/plugins/editor/init.lua
-- 编辑器功能插件汇总

local all_specs = {}

-- Load and flatten each editor plugin module
for _, module in ipairs {
  'navigation',
  'ui',
  'mini',
  'treesitter-context',
  'which-key',
  'greeter',
} do
  local specs = require('plugins.editor.' .. module)
  for _, spec in ipairs(specs) do
    table.insert(all_specs, spec)
  end
end

return all_specs

