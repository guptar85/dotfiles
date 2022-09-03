local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

g.mapleader = " "

-- vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
	  use 'wbthomason/packer.nvim'
-- Used for comments in a file 
-- Comment stuff out. Use gcc to comment out a line (takes a count), gc to comment out the target of a motion (for example, gcap to comment out a paragraph), gc in visual mode to comment out the selection, and gc in operator pending mode to target a comment. You can also use it as a command, either with a range like :7,17Commentary, or as part of a :global invocation like with :g/TODO/Commentary.
    use 'tpope/vim-commentary'
	  use 'mhartington/formatter.nvim'
    use { 'hrsh7th/nvim-cmp', 
            requires = { 'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer' }
    }
  	use 'lewis6991/gitsigns.nvim'
    use 'folke/tokyonight.nvim'
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
    use 'mfussenegger/nvim-dap'
    use 'theHamsta/nvim-dap-virtual-text'
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
vim.cmd('set norelativenumber')
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
vim.keymap.set('n', '[b', ':bnext<CR>')
vim.keymap.set('n', ']b', ':bprev<CR>')
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
    	}
    }
})

-- neovim/nvim-lspconfig
local nvim_lsp = require'lspconfig'
local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
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
vim.cmd 'colorscheme tokyonight'

-- nvim-treesitter/nvim-treesitter
cmd('set foldmethod=expr')
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
    "dockerfile"
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

require('telescope').setup {
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

vim.keymap.set('n', '<leader>x', ':lua send_line_to_terminal()<CR>')

require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
  }
}

--vim.keymap.set('n', '<c-o>', '<c-o>zz')
--vim.keymap.set('n', '<c-i>', '<c-i>zz')
-- nvim-telescope/telescope-ui-select.nvim

require("telescope").load_extension("ui-select")

--vim.keymap.set('i', '<c-o>', '<esc><s-o>')
vim.keymap.set('n', '<leader>p', ':PackerSync<CR>')

-- lualine
require('lualine').setup({
  sections = {
    lualine_c = {
      {'filename', path = 1},
      'lsp_progress',
    },
  },
})
