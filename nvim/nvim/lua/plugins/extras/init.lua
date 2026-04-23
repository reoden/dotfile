-- lua/plugins/extras/init.lua
-- 可选功能插件汇总

local all_specs = {}

-- Load and flatten each extras plugin module
for _, module in ipairs({
  'ai',
  'coding',
  'tools',
  'diagnostic',
}) do
  local specs = require('plugins.extras.' .. module)
  for _, spec in ipairs(specs) do
    table.insert(all_specs, spec)
  end
end

return all_specs