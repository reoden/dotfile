-- lua/plugins/core/init.lua
-- 汇总核心插件规格

local all_specs = {}

-- Load and flatten each core plugin module
for _, module in ipairs({
  'lsp',
  'telescope',
  'fff',
  'completion',
  'formatter',
  'treesitter',
  'git',
  'todo',
}) do
  local specs = require('plugins.core.' .. module)
  for _, spec in ipairs(specs) do
    table.insert(all_specs, spec)
  end
end

return all_specs