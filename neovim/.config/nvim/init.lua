local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

g.mapleader = " "

-- vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
	  use 'wbthomason/packer.nvim'
-- Used for comments in a file 
-- Comment stuff out. Use gcc to comment out a line (takes a count), gc to comment out the target of a motion (for example, gcap to comment out a paragraph), gc in visual mode to comment out the selection, and gc in operator pending mode to target a comment. You can also use it as a command, either with a range like :7,17Commentary, or as part of a :global invocation like with :g/TODO/Commentary.
     use 'lewis6991/impatient.nvim'
     use 'tpope/vim-commentary'
	 use 'mhartington/formatter.nvim'
    use { 'hrsh7th/nvim-cmp', 
            requires = { 'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer' }
    }
  	use 'lewis6991/gitsigns.nvim'
    -- use 'folke/tokyonight.nvim'
  	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'voldikss/vim-floaterm'
    use {
            'kyazdani42/nvim-tree.lua',
            requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use {
            'nvim-telescope/telescope.nvim',
            requires = { 'nvim-lua/plenary.nvim' }
    } 
    use { 'nvim-lualine/lualine.nvim',
          requires = { 'kyazdani42/nvim-web-devicons', 'arkav/lualine-lsp-progress' }
    }
    use 'nvim-telescope/telescope-dap.nvim'
    use 'nvim-telescope/telescope-ui-select.nvim'
    use 'cljoly/telescope-repo.nvim'
    use {
      'AckslD/nvim-neoclip.lua',
      config = function() require('neoclip').setup() end,
    }
    use 'mfussenegger/nvim-dap'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'ekickx/clipboard-image.nvim'
    use { 'kdheepak/tabline.nvim', config = function()
                                    require'tabline'.setup {
                                        -- Defaults configuration options
                                   enable = true,
                                   options = {
                                        -- If lualine is installed tabline will use separators configured in lualine by default.
                                        -- These options can be used to override those settings.
                                        section_separators = {'', ''},
                                        component_separators = {'', ''},
                                        max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
                                        show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
                                        show_devicons = true, -- this shows devicons in buffer section
                                        show_bufnr = false, -- this appends [bufnr] to buffer section,
                                        show_filename_only = true, -- shows base filename only instead of relative path in filename
                                        modified_icon = "+ ", -- change the default modified icon
                                        modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
                                        show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
                                      }
                                    }
        vim.cmd[[
                    set guioptions-=e " Use showtabline in gui vim
                    set sessionoptions+=tabpages,globals " store tabpages and globals in session
               ]]
        end,
    }
    use {
      'folke/trouble.nvim',
      config = function()
        require('trouble').setup {} end
    }   
    use 'folke/lsp-colors.nvim'
    use 'NTBBloodbath/rest.nvim'
    use 'tanvirtin/monokai.nvim'
    use 'glepnir/dashboard-nvim'
    -- use 'tpope/vim-surround'
    use {
    	"windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use { 'vimwiki/vimwiki', branch = 'master' }
    use 'ggandor/leap.nvim'
    use 'renerocksai/calendar-vim'
    -- use {
    --     'folke/which-key.nvim',
    --       config = function()
    --         require("which-key").setup {
    --     }
    --   end
    -- }
-- use 'marko-cerovac/material.nvim'
  end
)

-- default options
opt.completeopt = {'menu', 'menuone', 'noselect'}
opt.laststatus = 3
opt.mouse = 'a'
opt.splitright = true
opt.splitbelow = true
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
--opt.number = true "Not sure what it does since line number 27 is also there
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
-- opt.relativenumber = true
vim.cmd('set number')
vim.cmd('set relativenumber')
-- set diffopt+=vertical " starts diff mode in vertical split
opt.cmdheight = 1
-- set shortmess+=c " don't need to press enter so often
-- Do not show current vim mode since it is already shown by Lualine
opt.showmode = false
opt.signcolumn = 'yes'
opt.updatetime = 520
opt.showmatch = true
opt.showmode = true
opt.autoindent = true
opt.ruler = true
opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('config') .. '/undo-dir'
opt.clipboard = 'unnamedplus'
cmd('filetype plugin on')
opt.backup = false
g.netrw_banner = false
g.netrw_liststyle = 3
g.markdown_fenced_languages = { 'javascript', 'js=javascript', 'json=javascript' }

-- opt.path:append({ "**" })
vim.cmd([[set path=$PWD/**]])
vim.keymap.set('n', '<leader>v', ':e $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>', { silent = true })
vim.keymap.set('n', '<leader>s', ':so $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>t', ':bnext<CR>')
vim.keymap.set('n', '<leader>T', ':bprev<CR>')
vim.keymap.set('n', '<leader>x', ':bd<CR>')

-- vimwiki/vimwiki
 vim.cmd([[
     let g:vimwiki_list = [{'path': '$HOME/Documents/VimWiki/', 'syntax': 'markdown', 'ext': '.md'}]
]])
vim.cmd([[
    let g:vimwiki_global_ext = 0
]])
--vim.cmd([[au FileType vimwiki setlocal shiftwidth=6 tabstop=6 noexpandtab]])
vim.keymap.set('n', '<leader>n', ':tabe ~/Documents/VimWiki/index.md<CR>')

-- global mark I for last edit
vim.cmd [[autocmd InsertLeave * execute 'normal! mI']]

-- highlight on yank
vim.cmd([[au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}]])
-- better colors, but makes it sery slow!
-- opt.termguicolors = true

-- sbdchd/neoformat
vim.keymap.set('n', '<leader>F', ':Format<CR>')
require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    	},
       json = {
        -- prettierd
       function()
          return {
            exe = "jq",
            stdin = true
          }
        end
    	},
       css = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            stdin = true
          }
        end
    	},
        markdown = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            stdin = true
          }
        end
    	},
        html = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            stdin = true
          }
        end
    	},
        xml = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            stdin = true
          }
        end
    	},
        yaml = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            stdin = true
          }
        end
    	},
        lua = {
        --lua-fmt
        function()
            return {
                exe = "lua-fmt",
                    stdin = true
                }
	end
        }
   }
})
vim.cmd([[let g:shfmt_opt="-ci"]])

-- neovim/nvim-lspconfig

-- Mappings.
local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
end

local nvim_lsp = require'lspconfig'
local servers = { 'tsserver', 'bashls', 'luau_lsp' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    -- on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    }
    -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
end

require'lspconfig'.tsserver.setup{
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = function() return vim.loop.cwd() end      -- run lsp for javascript in any directory
}

-- this is for diagnositcs signs on the line number column
-- use this to beautify the plain E W signs to more fun ones
-- !important nerdfonts needs to be setup for this to work in your terminal
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " } 
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
end

vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end)
vim.keymap.set('n', 'gh', function() vim.lsp.buf.hover() end)
vim.keymap.set('n', 'gD', function() vim.lsp.buf.implementation() end)
vim.keymap.set('n', '<c-k>', function() vim.lsp.buf.signature_help() end)
vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end)
vim.keymap.set('n', 'gR', function() vim.lsp.buf.rename() end)
vim.keymap.set('n', 'ga', function() vim.lsp.buf.code_action() end)
-- vim.keymap.set('n', 'gA', ':Telescope lsp_code_actions<CR>')  

vim.keymap.set('n', '<leader><esc><esc>', ':tabclose<CR>')

-- vim.g.material_style = "darker"
-- vim.cmd 'colorscheme material'
vim.opt.fillchars = {
  horiz     = '█',
  horizup   = '█',
  horizdown = '█',
  vert      = '█',
  vertleft  = '█',
  vertright = '█',
  verthoriz = '█',
}
-- vim.cmd 'colorscheme tokyonight'
vim.cmd 'colorscheme monokai'

-- nvim-treesitter/nvim-treesitter
-- cmd('set foldmethod=expr')
cmd('set foldexpr=nvim_treesitter#foldexpr()')

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = true,
    disable = { "yaml" },
  },
  sync_install = false,
  ignore_install = {},
  auto_install = true,
  ensure_installed = {
    "yaml",
    "html",
    "scss",
    "lua",
    "javascript",
    "json",
    "markdown",
    "sql",
    "bash",
    "dockerfile",
    "http"
  },
}
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.tsx.used_by = { "javascript", "typescript.tsx" }

-- lewis6991/gitsigns.nvim
function diffThisBranch()
 local branch = vim.fn.input("Branch: ", "")
 require"gitsigns".diffthis(branch)
end

require('gitsigns').setup({
  current_line_blame = true,
  on_attach = function(bufnr)
       -- Navigation
    vim.keymap.set('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    vim.keymap.set('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

    -- Actions
    vim.keymap.set('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    vim.keymap.set('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    vim.keymap.set('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    vim.keymap.set('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
    vim.keymap.set('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    vim.keymap.set('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
    vim.keymap.set('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    vim.keymap.set('n', '<leader>hb', function() require"gitsigns".blame_line{full=true} end)
    vim.keymap.set('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
    vim.keymap.set('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    vim.keymap.set('n', '<leader>hD', function() require"gitsigns".diffthis("~") end)
    vim.keymap.set('n', '<leader>hm', function() require"gitsigns".diffthis("main")end)
    vim.keymap.set('n', '<leader>hM', diffThisBranch)
    vim.keymap.set('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

    -- Text object
    vim.keymap.set('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    vim.keymap.set('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})

-- 'voldikss/vim-floaterm'
vim.g.floaterm_width = 0.95
vim.g.floaterm_height = 0.95
vim.keymap.set('n', '<leader>g', ':FloatermNew lazygit<CR>')

-- kyazdani42/nvim-tree.lua
require('nvim-tree').setup({
  hijack_cursor = true,
  update_focused_file = { enable = true },
  view = {
    width = 60
  }
})
vim.keymap.set('n', '\\', ':NvimTreeToggle<CR>', {silent=true})


local telescope_actions = require("telescope.actions.set")

local fixfolds = {
	hidden = true,
	attach_mappings = function(_)
		telescope_actions.select:enhance({
			post = function()
				vim.cmd(":normal! zx")
			end,
		})
		return true
	end,
}

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require('telescope').setup {
    defaults = {
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        },
    },
	pickers = {
		buffers = fixfolds,
		find_files = fixfolds,
		git_files = fixfolds,
		grep_string = fixfolds,
		live_grep = fixfolds,
		oldfiles = fixfolds,
	}
}

-- nvim-telescope/telescope.nvim
_G.telescope_find_files_in_path = function(path)
 local _path = path or vim.fn.input("Dir: ", "", "dir")
 require("telescope.builtin").find_files({search_dirs = {_path}})
end
_G.telescope_live_grep_in_path = function(path)
 local _path = path or vim.fn.input("Dir: ", "", "dir")
 require("telescope.builtin").live_grep({search_dirs = {_path}})
end
_G.telescope_files_or_git_files = function()
 local utils = require('telescope.utils')
 local builtin = require('telescope.builtin')
 local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
 if ret == 0 then
   builtin.git_files()
 else
   builtin.find_files()
 end
end
vim.keymap.set('n', '<leader>fD', function() telescope_live_grep_in_path() end)
vim.keymap.set('n', '<leader><space>', function() telescope_files_or_git_files() end)
vim.keymap.set('n', '<leader>fd', function() telescope_find_files_in_path() end)
vim.keymap.set('n', '<leader>ft', function() telescope_find_files_in_path("./tests") end)
vim.keymap.set('n', '<leader>fT', function() telescope_live_grep_in_path("./tests") end)
vim.keymap.set('n', '<leader>ff', ':Telescope live_grep<CR>')
-- vim.keymap.set('n', '<leader>fo', ':Telescope file_browser<CR>')
vim.keymap.set('n', '<leader>fn', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fr', ':Telescope resume<CR>')
vim.keymap.set('n', '<leader>fg', ':Telescope git_branches<CR>')
vim.keymap.set('n', '<c-\\>', ':Telescope buffers<CR>')
vim.keymap.set('n', '<leader>fs', ':Telescope lsp_document_symbols<CR>')
vim.keymap.set('n', '<leader>ff', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>f', ':Telescope repo list<CR>')
vim.keymap.set('n', '<leader>FF', ':Telescope grep_string<CR>')

--Extra config for open terminal from Neovim
_G.term_buf_of_tab = _G.term_buf_of_tab or {}
_G.term_buf_max_nmb = _G.term_buf_max_nmb or 0

function spawn_terminal()
  local cur_tab = vim.api.nvim_get_current_tabpage()
  vim.cmd('vs | terminal')
  local cur_buf = vim.api.nvim_get_current_buf()
  _G.term_buf_max_nmb = _G.term_buf_max_nmb + 1
  vim.api.nvim_buf_set_name(cur_buf, "Terminal " .. _G.term_buf_max_nmb)
  table.insert(_G.term_buf_of_tab, cur_tab, cur_buf)
  vim.cmd(':startinsert')
end

function toggle_terminal()
  local cur_tab = vim.api.nvim_get_current_tabpage()
  local term_buf = term_buf_of_tab[cur_tab]
  if term_buf ~= nil then
   local cur_buf = vim.api.nvim_get_current_buf()
   if cur_buf == term_buf then
     vim.cmd('q')
   else
     vim.cmd('vert sb' .. term_buf)
     vim.cmd(':startinsert')
   end
  else
    spawn_terminal()
    vim.cmd(':startinsert')
  end
end
vim.keymap.set('n', '<c-y>', toggle_terminal)
vim.keymap.set('i', '<c-y>', '<ESC>:lua toggle_terminal()<CR>')
vim.keymap.set('t', '<c-y>', '<c-\\><c-n>:lua toggle_terminal()<CR>')
-- cmd([[
-- if has('nvim')
--    au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
-- endif]])

_G.send_line_to_terminal = function()
  local curr_line = vim.api.nvim_get_current_line()
  local cur_tab = vim.api.nvim_get_current_tabpage()
  local term_buf = term_buf_of_tab[cur_tab]
  if term_buf == nil then
    spawn_terminal()
    term_buf = term_buf_of_tab[cur_tab]
  end
  for _, chan in pairs(vim.api.nvim_list_chans()) do
    if chan.buffer == term_buf then
      chan_id = chan.id
    end
  end
  vim.api.nvim_chan_send(chan_id, curr_line .. '\n')
end

vim.keymap.set('n', '<leader>l', ':lua send_line_to_terminal()<CR>')

require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
  }
}

vim.keymap.set('n', '<c-o>', '<c-o>zz')
vim.keymap.set('n', '<c-i>', '<c-i>zz')
-- lualine
require('lualine').setup({
  sections = {
    lualine_c = {
      {'filename', path = 1},
      'lsp_progress',
    },
  },
})

-- mfussenegger/nvim-dap
local dap = require('dap')
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/Code/neovim/apps/node-debug2/out/src/nodeDebug.js'},
}

--require('dap').set_log_level('INFO')
dap.defaults.fallback.terminal_win_cmd = '20split new'
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

vim.keymap.set('n', '<leader>dh', function() require"dap".toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set('n', '<S-k>', function() require"dap".step_out() end)
vim.keymap.set('n', "<S-l>", function() require"dap".step_into() end)
vim.keymap.set('n', '<S-j>', function() require"dap".step_over() end)
vim.keymap.set('n', '<S-h>', function() require"dap".continue() end)
vim.keymap.set('n', '<leader>dn', function() require"dap".run_to_cursor() end)
vim.keymap.set('n', '<leader>dc', function() require"dap".terminate() end)
vim.keymap.set('n', '<leader>dR', function() require"dap".clear_breakpoints() end)
vim.keymap.set('n', '<leader>de', function() require"dap".set_exception_breakpoints({"all"}) end)
vim.keymap.set('n', '<leader>da', function() require"debugHelper".attach() end)
--vim.keymap.set('n', '<leader>dA', function() require"debugHelper".attachToRemote() end)
vim.keymap.set('n', '<leader>di', function() require"dap.ui.widgets".hover() end)
vim.keymap.set('n', '<leader>d?', function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end)
vim.keymap.set('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
vim.keymap.set('n', '<leader>dj', ':lua require"dap".down()<CR>zz')
vim.keymap.set('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')

-- nvim-telescope/telescope-dap.nvim
require('telescope').load_extension('dap')
vim.keymap.set('n', '<leader>ds', ':Telescope dap frames<CR>')
-- vim.keymap.set('n', '<leader>dc', ':Telescope dap commands<CR>')
vim.keymap.set('n', '<leader>db', ':Telescope dap list_breakpoints<CR>')

require('nvim-dap-virtual-text').setup()

-- nvim-telescope/telescope-ui-select.nvim
require("telescope").load_extension("ui-select")
--vim.keymap.set('i', '<c-o>', '<esc><s-o>')
vim.keymap.set('n', '<leader>p', ':PackerSync<CR>')

-- 'L3MON4D3/LuaSnip'
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local ls = require("luasnip")
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if ls.jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'npm' },
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 5 },
  },
  -- formatting = {
  --   format = lspkind.cmp_format({with_text = false, maxwidth = 50})
  -- }
})

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.expand = function ()
  -- print("hurray!!")
  if ls.expand_or_jumpable() then
    return t("<Plug>luasnip-expand-or-jump")
  end
  return ''
end

_G.expand_back = function ()
  -- print("hurray!!")
  if ls.jumpable(-1) then
    return t("<Plug>luasnip-jump-prev")
  end
  return ''
end

vim.api.nvim_set_keymap('i', '<c-j>', 'v:lua.expand()', { expr = true })
vim.api.nvim_set_keymap('i', '<c-k>', 'v:lua.expand_back()', { expr = true })
vim.api.nvim_set_keymap('s', '<c-j>', 'v:lua.expand()', { expr = true })
vim.api.nvim_set_keymap('s', '<c-k>', 'v:lua.expand_back()', { expr = true })

vim.keymap.set('n', '<leader>ls', '<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>')

require'clipboard-image'.setup {
   default = {
    img_dir = {"%:p:h", "images/"}
   }
}
vim.keymap.set('n', '<leader>P', ':PasteImg<CR>')

--'folke/trouble.nvim'
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)

-- neoclip
--vim.keymap.set("n", ",tn", [[<Cmd>lua require('neoclip').toggle()<CR>]], { noremap = true, silent = true })
vim.keymap.set(
  "n",
  "<leader>r",
  [[<Cmd>lua require('telescope').extensions.neoclip.default()<CR>]],
  { noremap = true, silent = false }
)

-- ggandor/leap.nvim
require('leap').set_default_keymaps()
vim.cmd[[autocmd ColorScheme * lua require('leap').init_highlight(true)]]

-- vim.keymap.set("i", "<S-Tab>", "<c-p>", {noremap = true})
-- vim.keymap.set("i", "<Tab>", "<c-n>", {noremap = true})

vim.keymap.set(
  "n",
  "<leader>c",
  [[<Cmd>lua require('rest-nvim').run()<CR>]],
  { noremap = true, silent = false }
)

vim.keymap.set(
  "n",
  "<leader>cp",
  [[<Cmd>lua require('rest-nvim').run(true)<CR>]],
  { noremap = true, silent = false }
)

vim.keymap.set(
  "n",
  "<leader>cl",
  [[<Cmd>lua require('rest-nvim').last()<CR>]],
  { noremap = true, silent = false }
)

vim.cmd[[
    let g:calendar_weeknm = 2 
]]

vim.cmd[[
  let g:calendar_number_of_months = 5
]]

vim.keymap.set(
  "n",
  "<leader>C",
  ":CalendarH<CR>",
  { noremap = true, silent = true }
)
