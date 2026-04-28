-- set <space> as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--[[
--BASIC CONFIG
--]]
vim.g.have_nerd_font = true

vim.o.relativenumber = true
vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.breakindent = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.undofile = true

vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.keymap.set('n', '<leader>cp', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path)
end, {desc = 'Copy absolute path'})

vim.keymap.set('n', '<leader>cr', function()
  local path = vim.fn.expand('%')
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path)
end, {desc = 'Copy relative path'})

vim.o.confirm = true
vim.o.ttimeoutlen = 1
-- Decrease update time
vim.o.updatetime = 250

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
}
-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

vim.keymap.set('n', '<leader>Q', vim.diagnostic.open_float, {desc = 'show diagnostic' })

-- Easily move between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "Move block down" })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "Move block up" })

-- Highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Disable auto continuation of comments
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function() vim.opt.formatoptions:remove { 'c', 'r', 'o' } end,
})

--[[
--PLUGIN CONFIG 
--ref = https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack#update
--]]
vim.pack.add({
  'https://github.com/ibhagwan/fzf-lua',
   "https://github.com/nvim-treesitter/nvim-treesitter",
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/karb94/neoscroll.nvim',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/kdheepak/lazygit.nvim',
  'https://github.com/esmuellert/codediff.nvim',
  'https://github.com/goolord/alpha-nvim',
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/dmtrKovalenko/fff.nvim',
  "https://github.com/leath-dub/snipe.nvim",
  "https://github.com/folke/snacks.nvim",
  'https://github.com/folke/flash.nvim',
  "https://github.com/folke/trouble.nvim",
  "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/folke/which-key.nvim',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.x') }, -- pinning so rust binary dependency automatically downloads
})

-- kanagawa
require('kanagawa').setup({
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none"
        }
      }
    }
  }
})

-- set colorscheme
vim.cmd('colorscheme kanagawa-wave')

-- Markdown
require('render-markdown').setup({})

-- FzfLua Setup
local fzf = require('fzf-lua')
fzf.setup({
  keymap = {
    builtin = {
      ["<C-d>"] = 'preview-page-down', -- Better scrolling within the displays
      ["<C-u>"] = 'preview-page-up',
    },
  },
  winopts = {
    height  = 0.95, -- window height
    width   = 0.90, -- window width
    preview = {
      layout   = 'vertical',
      vertical = "down:30%",
    }
  },
  files = {
    formatter = 'path.filename_first',
  },
})

vim.keymap.set('n', '<leader><leader>', '<cmd>FzfLua files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Find live grep' })
vim.keymap.set('n', '<leader>fr', '<cmd>FzfLua resume<cr>', { desc = 'Resume last picker' })
vim.keymap.set('n', '<leader>,', '<cmd>FzfLua buffers<cr>', { desc = 'Buffers' })

vim.keymap.set('n', 'grr', fzf.lsp_references, { desc = 'References' })
vim.keymap.set('n', 'gri', fzf.lsp_implementations, { desc = 'Implementations' })
vim.keymap.set('n', 'gra', fzf.lsp_code_actions, { desc = 'Code actions' })

-- Treesitter
vim.cmd('syntax off') -- Make it obvious if treesitter is missing]
vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
})

-- LSP
vim.lsp.enable({
  'lua_ls',         
  'gopls',
  "clangd",
})
-- gopls config
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
      completeUnimported = true,
    },
  },
})

vim.o.signcolumn = 'yes' -- make lsp warnings not widen the gutter
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
-- Auto-format ("lint") on save (adapted from neovim docs :help auto-format)
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
--   callback = function(ev)
--     local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
--     if not client:supports_method('textDocument/willSaveWaitUntil')
--       and client:supports_method('textDocument/formatting') then
--       vim.api.nvim_create_autocmd('BufWritePre', {
--         group = vim.api.nvim_create_augroup('my.lsp.fmt', { clear = false }),
--         buffer = ev.buf,
--         callback = function()
--           vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
--         end,
--       })
--     end
--   end,
-- })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)

    if result then
      for _, res in pairs(result) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
          else
            vim.lsp.buf.execute_command(r.command)
          end
        end
      end
    end

    vim.lsp.buf.format({ async = false })
  end,
})

-- autopairs
require('nvim-autopairs').setup({
  check_ts = true,
})

-- Blink.cmp
local blinkCMP = require('blink.cmp')
blinkCMP.setup({
  keymap = {
    preset = 'none',

    -- 经典 Vim 选择
    ['<C-n>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback' },

    ['<CR>']  = { 'accept', 'fallback' },

    ['<Tab>']   = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },

    ['<C-e>'] = { 'cancel' },
    ['<C-y>'] = { 'accept' },
  },

  completion = {
    accept = {
      auto_brackets = {
        enabled = false, 
      },
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
})


-- Neoscroll
require('neoscroll').setup({
  hide_cursor = false,
  stop_eof = true,
  easing = 'quadratic',
  duration_multiplier = 0.30,
})

-- Dap (debugging)
local dap = require('dap')
dap.adapters.debugpy = function(cb, config) -- also $ uv tool install debugpy@latest
  if config.request == 'attach' then
    cb({
      type = 'server',
      port = config.connect.port,
      host = config.connect.host or '127.0.0.1',
    })
  else
    cb({
      type = 'executable',
      command = 'debugpy-adapter',
    })
  end
end
dap.configurations.python = { -- https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
  {
    type = 'debugpy',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    python = function()
      local root = vim.fs.root(0, '.venv')
      return { root and root .. '/.venv/bin/python' or 'python3' }
    end,
    cwd = function()
      return vim.fs.root(0, '.venv') or vim.fn.getcwd()
    end,
  },
}
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug toggle breakpoint' })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug continue' })
vim.keymap.set('n', '<leader>dq', dap.terminate, { desc = 'Debug terminate' })
vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Debug open REPL' })
vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug run last' })
vim.keymap.set({ 'n', 'v' }, '<leader>dh', require('dap.ui.widgets').hover, { desc = 'Debug hover' })
vim.keymap.set('n', '<Down>', dap.step_over, { desc = 'Debug step over' })
vim.keymap.set('n', '<Right>', dap.step_into, { desc = 'Debug step into' })
vim.keymap.set('n', '<Left>', dap.step_out, { desc = 'Debug step out' })
vim.keymap.set('n', '<Up>', dap.restart_frame, { desc = 'Debug restart frame' })

-- Oil.nvim
require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Lazygit.nvim
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>gb', function() vim.ui.open(vim.fn.systemlist('git remote get-url origin')[1]) end,
{ desc = 'Open git remote' })

-- Codediff (vscode like diffs :))
require("codediff").setup({})
vim.keymap.set('n', '<leader>ru', '<cmd>CodeDiff<cr>', { desc = 'Code diff not staged' })
vim.keymap.set('n', '<leader>rm', '<cmd>CodeDiff main<cr>', { desc = 'Code diff main' })
vim.keymap.set('n', '<leader>rh', '<cmd>CodeDiff HEAD~1<cr>', { desc = 'Code diff previous commit' })

-- fff.nvim
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'fff.nvim' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('fff.nvim') end
      require('fff.download').download_or_build_binary()
    end
  end,
})

vim.g.fff = {
  lazy_sync = true,
  debug = { enabled = true, show_scores = true },
}

vim.keymap.set('n', 'ff', function() require('fff').find_files() end, { desc = 'FFFind files' })

require('fff').setup({
  base_path = vim.fn.getcwd(),
  prompt = '> ',
  title = 'FFFiles',
  max_results = 100,
  max_threads = 4,
  lazy_sync = true,
  prompt_vim_mode = false,
  layout = {
    height = 0.8,
    width = 0.8,
    prompt_position = 'bottom',   -- or 'top'
    preview_position = 'right',   -- 'left' | 'right' | 'top' | 'bottom'
    preview_size = 0.5,
    flex = { size = 130, wrap = 'top' },
    show_scrollbar = true,
    path_shorten_strategy = 'middle_number', -- 'middle_number' | 'middle' | 'end'
    anchor = 'center',
  },
  preview = {
    enabled = true,
    max_size = 10 * 1024 * 1024,
    chunk_size = 8192,
    binary_file_threshold = 1024,
    imagemagick_info_format_str = '%m: %wx%h, %[colorspace], %q-bit',
    line_numbers = false,
    cursorlineopt = 'both',
    wrap_lines = false,
    filetypes = {
      svg = { wrap_lines = true },
      markdown = { wrap_lines = true },
      text = { wrap_lines = true },
    },
  },
  keymaps = {
    close = '<Esc>',
    select = '<CR>',
    select_split = '<C-s>',
    select_vsplit = '<C-v>',
    select_tab = '<C-t>',
    move_up = { '<Up>', '<C-p>' },
    move_down = { '<Down>', '<C-n>' },
    preview_scroll_up = '<C-u>',
    preview_scroll_down = '<C-d>',
    toggle_debug = '<F2>',
    cycle_grep_modes = '<S-Tab>',
    cycle_previous_query = '<C-Up>',
    toggle_select = '<Tab>',
    send_to_quickfix = '<C-q>',
    focus_list = '<leader>l',
    focus_preview = '<leader>p',
  },
  frecency = {
    enabled = true,
    db_path = vim.fn.stdpath('cache') .. '/fff_nvim',
  },
  history = {
    enabled = true,
    db_path = vim.fn.stdpath('data') .. '/fff_queries',
    min_combo_count = 3,
    combo_boost_score_multiplier = 100,
  },
  git = {
    status_text_color = false, -- true to color filenames by git status
  },
  grep = {
    max_file_size = 10 * 1024 * 1024,
    max_matches_per_file = 100,
    smart_case = true,
    time_budget_ms = 150,
    modes = { 'plain', 'regex', 'fuzzy' },
    trim_whitespace = false,
  },
  debug = { enabled = false, show_scores = false },
  logging = {
    enabled = true,
    log_file = vim.fn.stdpath('log') .. '/fff.log',
    log_level = 'info',
  },
})

-- snipe.nvim
local snipe = require("snipe")
snipe.setup()
vim.keymap.set("n", "gb", snipe.open_buffer_menu)
snipe.ui_select_menu = require("snipe.menu"):new { position = "center" }
snipe.ui_select_menu:add_new_buffer_callback(function (m)
  vim.keymap.set("n", "<esc>", function ()
    m:close()
  end, { nowait = true, buffer = m.buf })
end)
vim.ui.select = snipe.ui_select;

-- snacks.nvim
local snacks = require("snacks")
vim.keymap.set("n", "<leader>z", function() Snacks.zen() end, {desc = 'Toggle Zen' })
vim.keymap.set("n", "<leader>D", function()
  if vim.g.snacks_dim_enabled then
    Snacks.dim.disable()
    vim.g.snacks_dim_enabled = false
    print 'Dim disabled'
  else
    Snacks.dim.enable()
    vim.g.snacks_dim_enabled = true
    print 'Dim enabled'
  end
end, {desc = 'Toggle Dim'})
snacks.setup({
  opts = {
    indent = {
      enabled = false,
      indent = {
        enabled = false,
        only_current = false,
        only_scope = false,
        char = '┊',
        hl = {
          'SnacksIndentRed',
          'SnacksIndentYellow',
          'SnacksIndentBlue',
          'SnacksIndentOrange',
          'SnacksIndentGreen',
          'SnacksIndentViolet',
          'SnacksIndentCyan',
        },
      },
      scope = {
        enabled = false,
        char = '║',
        underline = true,
        only_current = true,
        hl = {
          'SnacksIndentScopeRed',
          'SnacksIndentScopeYellow',
          'SnacksIndentScopeBlue',
          'SnacksIndentScopeOrange',
          'SnacksIndentScopeGreen',
          'SnacksIndentScopeViolet',
          'SnacksIndentScopeCyan',
        },
      },
      chunk = {
        enabled = false,
        char = {
          corner_top = '╭',
          corner_bottom = '╰',
          horizontal = '─',
          vertical = '│',
          arrow = '>',
        },
        only_current = true,
        hl = {
          'SnacksIndentChunkRed',
          'SnacksIndentChunkOrange',
          'SnacksIndentChunkYellow',
          'SnacksIndentChunkGreen',
          'SnacksIndentChunkBlue',
          'SnacksIndentChunkCyan',
          'SnacksIndentChunkViolet',
        },
      },
    },
  }
})

-- flash.nvim
local flash = require("flash")
-- keymaps
vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", flash.remote, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", flash.treesitter_search, { desc = "Treesitter Search" })
vim.keymap.set("c", "<C-s>", flash.toggle, { desc = "Toggle Flash Search" })


require("trouble").setup({})
-- keymaps
vim.keymap.set("n", "<leader>qD", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>qd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>qs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Document Symbols" })
vim.keymap.set("n", "<leader>ql", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set("n", "<leader>qL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>qQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
vim.api.nvim_create_user_command("Trouble", function(opts)
  require("trouble")
  vim.cmd("Trouble " .. opts.args)
end, { nargs = "*" })

-- tiny-inline-diagnostic
require("tiny-inline-diagnostic").setup({
  preset = "modern",
  transparent_bg = false,
  transparent_cursorline = true,
  signs = {
    vertical = " │",
    vertical_end = " └",
  },
  blend = {
    factor = 0.1,
  },
  options = {
    show_source = {
      enabled = true,
      if_many = true,
    },
    add_messages = {
      display_count = true,
    },
    set_arrow_to_diag_color = true,
    multilines = {
      enabled = true,
      always_show = true,
    },
    show_all_diags_on_cursorline = true,
    enable_on_insert = false,
    enable_on_select = true,
  },
})

-- which-key
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    require('which-key').setup({
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
    })

    require('which-key').add({
      -- { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>c', group = '[C]opy Path' },
      { '<leader>g', group = '[G]it' },
      { '<leader>d', group = '[D]ebug' },
      { '<leader>q', group = '[Q]uick Fix' },
      { 'f', group = '[F]ind (fff)' },
      { 'gr', group = 'LSP Actions', mode = { 'n' } },
    })
  end,
})

-- Start screen
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
dashboard.section.header.val = vim.split(
  [[
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⠶⠶⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⠋⠀⠀⠀⠀⠉⠻⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠏⠀⠀⠀⠀⠀⠀⠀⠀⠹⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡏⠀⢠⣤⣤⡄⢀⣤⣤⣄⠀⠹⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠀⠀⣿⣿⣿⡿⢸⣿⣿⣿⠀⠀⢻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀
  ⠀⠀⣄  ⠀   ⢠⡇⠀⠀⠈⠛⠛⠁⠀⠙⠛⠋⠀⠀⠈⣧⠀⠀⠀ ⡔ ⠀⠀⠀
  ⢀⡤⠙⢷⣦   ⠀⣸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡆⠀⠀⠀⠈⢙⣲⣶⠀
  ⣴⣾⣿⡋   ⢰⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⠀⠀⠰⢿⣿⠿⠁ 
  ⠙⠛⠿⠛⠀  ⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣇⠀⠀⠀⠀⠀ ⠀
  ⠀⠀⠀⠀⠀⠀⠀⢸⡷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡄⠀⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⢠⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⡆⢻⡄⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⣾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠘⠂⢷⡀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⣼⠃⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⢻⠀⢂⠀⠀⠀⠀⠻⣆⠀⠀⠀
  ⠀⠀⠀⢀⡾⠃⠀⠀⠀⡜⠀⠀⠀⠀⠀⠀⠀ ⢸⣿⠀⠀⢸⠀⠘⠂⠀⠀⠀⠀⠈⢳⣄⠀
  ⠀⠀⢀⡞⠁⠀⠸⠷⢰⠁⠀⠀⠀⠀⠀⠀⠀  ⢸⣿⠀⠈⡄⠀⠀⣤⠄⠀⢀⣠⠏⢹⡆
  ⠀⣴⡟⣀⠀⠀⠷⢀⠃⠀⠀⠀⣤⡀⠀⠀⠀⢸⣿⠀⠀⠀⠀⡇⠀⠀⢰⡟⠋⠁⠀⣠⡞⠀
  ⠻⣧⣿⣧⣜⠃⡘⠀⠀⠀⢠⣿⠇⠀⠀⠀ ⢸⣿⠀⠀⠀⠃⠀⠀⢸⣇⣀⣀⡼⠋$⠀
  ⠀⠀⠘⢿⣿⡏⠐⢁⠄⠀⠀⠸⡷⠀⠀⠀⠀ ⢸⣿⠀⠀⠀⠀⠀⠀⠀⠘⢻⣿⡇⠀⠀⠀
  $⠀⢠⣿⠋⠀⠀⡌⠀⠀⣸⣿⠄⠀⠀⠀⠀⠸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⡇⠀⠀⠀
  ⠀⠀⡌⠀⠺⠃⠀⠀⠀⢀⣿⠏⠀⠀⠀⠀⠀⠿⠆  ⠀⠀⠀⣆⠀⠀⢰⡎⣿⡇⠀$⠀
  ⠀⠀⢦⣄⠀⠀⠀⠀⠀⣾⠟⠀⠀$⠀⠀⠺⠇⠀⠀⠀⠀⢹⠀⠀⠀⠀⢸⣷⠻⣷⠀⠀⠀
  ⠀⠀⠀⠉⠲⠶⣤⣤⣶⠆⠀⠀⠀⠀⠀⣼⡟⠀⠀⠀$⠀⠸⡄⠀⠀⠀⢸⣿⣶⣿⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⣿⠛⣃⠀⠀⠀⣀⡀⠀⣿⣧⣄⡀⠀⠀⠀⠀⡇⠀⠀⠀⢸⣿⠉⠉⠀⠀⠀
  ⠀⠀$⠀⠀⠀⣿⠀⠈⠉⠉⠉⠉⠉⠁⠉⠉⠉⠉⢳⣤⡄⠀⠃⠀⠀⠀⠸⣿⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⢻⣄⠀⠀⠀⠀⠀⣠⣄⠀⠀⠀⠀⠀⠀⢈⣡⣤⡀⠀⠀⠀⣿⠀⠀⠀⠀⠀
  ⠀⠀⠀$⠀⠀⠀⠉⠉⠳⠶⠶⠞⠁⠈⢧⡀⠀⠀⣠⡴⠋⠀⠈⠹⢧⣄⣠⠏⠀⠀⠀⠀⠀
  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠒⠛⠁⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀$⠀⠀⠀
  $                       
  $             
  ]], '\n', { trimempty = true })
  dashboard.section.header.opts.hl = 'Comment'
  dashboard.section.buttons.val = {}
  dashboard.section.footer.val = 'Config By Reoden'
  dashboard.section.footer.opts.hl = 'Comment'
  alpha.setup(dashboard.opts)
