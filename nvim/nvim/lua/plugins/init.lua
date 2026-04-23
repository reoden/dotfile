-- lua/plugins/init.lua
-- Unified plugin loader for lazy.nvim

local function convert_vim_pack_to_lazy(spec)
  -- If it's not a table, return as-is
  if type(spec) ~= 'table' then
    return spec
  end

  -- If it has 'src', convert from vim.pack format to lazy.nvim format
  if type(spec.src) == 'string' then
    -- Create new spec with src moved to [1]
    local lazy_spec = {
      spec.src
    }

    -- Copy all other fields and convert nested dependencies
    for key, value in pairs(spec) do
      if key ~= 'src' then
        if key == 'dependencies' and type(value) == 'table' then
          -- Recursively convert dependencies
          local converted_deps = {}
          for _, dep in ipairs(value) do
            table.insert(converted_deps, convert_vim_pack_to_lazy(dep))
          end
          lazy_spec[key] = converted_deps
        else
          lazy_spec[key] = value
        end
      end
    end

    return lazy_spec
  end

  -- If no 'src' field but has other lazy.nvim fields, it's a local plugin - pass through as-is
  return spec
end

-- Helper to flatten and convert specs
local function flatten_and_convert_specs(specs)
  local result = {}
  if type(specs) ~= 'table' then
    return result
  end

  for _, spec in ipairs(specs) do
    if spec == nil then
      -- skip nil
    elseif type(spec) == 'table' then
      -- Convert vim.pack format to lazy.nvim format
      local converted = convert_vim_pack_to_lazy(spec)
      table.insert(result, converted)
    end
  end
  return result
end

-- 核心功能插件
local core_specs = flatten_and_convert_specs(require('plugins.core'))

-- 编辑器功能插件
local editor_specs = flatten_and_convert_specs(require('plugins.editor'))

-- 可选功能插件
local extras_specs = flatten_and_convert_specs(require('plugins.extras'))

-- 合并所有规格
local all_specs = {}
vim.list_extend(all_specs, core_specs)
vim.list_extend(all_specs, editor_specs)
vim.list_extend(all_specs, extras_specs)

return all_specs