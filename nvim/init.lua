vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 300
vim.opt.undofile = true

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Plugins --------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "easymotion/vim-easymotion",
      enabled = true,
      config = function()
        vim.g.EasyMotion_smartcase = 1
        vim.g.EasyMotion_startofline = 0
        vim.g.EasyMotion_use_smartsign_us = 1
      end,
    },
    -- {
    --   "nvim-treesitter/nvim-treesitter",
    --   build = ":TSUpdate",
    --   config = function () 
    --     local configs = require("nvim-treesitter.configs")

    --     configs.setup({
    --         ensure_installed = {"r"},
    --         sync_install = false,
    --         highlight = { enable = true },
    --         indent = { enable = true },  
    --       })
    --   end
    -- },
    -- {
    --   "nvim-treesitter/nvim-treesitter-textobjects",
    --   after = "nvim-treesitter",
    --   config = function()
    --     require("nvim-treesitter.configs").setup({
    --       textobjects = {
    --         select = {
    --           enable = true,
    --           lookahead = true,
    --           keymaps = {
    --             ["af"] = "@function.outer",
    --             ["if"] = "@function.inner"
    --           },
    --         },
    --       },
    --     })
    --   end
    -- },
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      enabled = not vim.g.vscode,
      dependencies = { 'nvim-lua/plenary.nvim' },
    }
  },
  checker = { enabled = true },
})

-- Key Mapping functions -------------------------------------------------------
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.keymap.set
local vscall = vim.fn.VSCodeNotify

local nv_keymap = function(lhs, rhs)
  keymap({'n', 'v'}, lhs, rhs, opts)
end

local nx_keymap = function(lhs, rhs)
  keymap({'n', 'v'}, lhs, rhs, term_opts)
end

local refactor = {
  rename = function()
    vscall("editor.action.rename")
  end,
  inlineChat = function()
    vscall("inlineChat.start")
  end,
  showDefinitionHover = function()
    vscall("editor.action.showDefinitionPreviewHover")
  end,
}

local bookmark = {
  toggle = function()
    vscall("bookmarks.toggle")
  end,
  list = function()
    vscall("bookmarks.listFromAllFiles")
  end,
  previous = function()
    vscall("bookmarks.jumpToPrevious")
  end,
  next = function()
    vscall("bookmarks.jumpToNext")
  end,
   clear = function()
    vscall("bookmarks.clearFromAllFiles")
  end,

}

local file = {
  find = function()
    vscall("find-it-faster.findFiles")
  end,
  new = function()
    vscall("workbench.explorer.fileView.focus")
    vscall("explorer.newFile")
  end,
  save = function()
    vscall("workbench.action.files.save")
  end,
  saveAll = function()
    vscall("workbench.action.files.saveAll")
  end,
  showInTree = function()
    vscall("workbench.files.action.showActiveFileInExplorer")
  end,
  rename = function()
    vscall("workbench.files.action.showActiveFileInExplorer")
    vscall("renameFile")
  end
}

local workspace = {
  closeEditor = function()
    vscall("workbench.action.closeActiveEditor")
  end,
  closeOtherEditor  = function()
    vscall("workbench.action.closeOtherEditors")
  end,
  tree = function()
    vscall("workbench.view.explorer")
  end,
  showCommands = function()
    vscall("workbench.action.showCommands")
  end,
  toggleSidebar = function()
    vscall("workbench.action.toggleSidebarVisibility")
  end,
}

local comment = {
  selected = function()
    vim.fn.VSCodeNotifyRange("editor.action.commentLine", vim.fn.line("v"), vim.fn.line("."), 1)
  end
}

local search = {
  reference = function()
    vscall("editor.action.referenceSearch.trigger")
  end,
  project = function()
    vscall("editor.action.addSelectionToNextFindMatch")
    vscall("workbench.action.findInFiles")
  end,
  text = function()
    vscall("find-it-faster.findWithinFiles")
  end,
}

local fold = {
  toggle = function()
    vscall("editor.toggleFold")
  end,
  all = function()
    vscall("editor.foldAll")
  end,
  openAll = function()
    vscall("editor.unfoldAll")
  end,
}

local indentation = {
  rightindent = function()
    vscall("editor.action.indentLines")
  end,
  leftindent = function()
    vscall("editor.action.outdentLines")
  end,
}

local editor = {
  split = function()
    vscall("workbench.action.splitEditor")
  end,
  verticalSplit = function()
    vscall("workbench.action.splitEditorDown")
  end,
  focusNextGroup = function()
    vscall("workbench.action.focusNextGroup")
  end,
  focusPreviousGroup = function()
    vscall("workbench.action.focusPreviousGroup")
  end,
  focusNext = function()
    vscall("workbench.action.nextEditor")
  end,
  focusPrevious = function()
    vscall("workbench.action.previousEditor")
  end, 
}

-- Mappings --------------------------------------------------------------------
-- nav
nv_keymap('<leader>h', '^')
nv_keymap('<leader>l', 'g_')  
nv_keymap('<leader>a', '%')
keymap('v', '<leader>p', '\"_dP')

nx_keymap('j', 'gj')
nx_keymap('k', 'gk')

keymap({ 'n', 'v'}, 'p', 'P', opts)

keymap('n', 'U', '<C-r>')

keymap('n', '<Esc>', ':nohlsearch<cr>', term_opts)
keymap('n', 's', '<Plug>(easymotion-s2)', opts)

keymap('n', '<leader>aa', 'ggVG', opts)

--keymap("n", "<C-d>", "<C-d>zz", opts)
--keymap("n", "<C-u>", "<C-u>zz", opts)

-- Only use in VSCode ----------------------------------------------------------
if vim.g.vscode then
  keymap({ 'n' }, "<leader>nn", editor.split)
  keymap({ 'n' }, "<leader>nv", editor.verticalSplit)

  keymap({ 'n' }, "gh", refactor.showDefinitionHover) 

  keymap("n", "<C-l>", editor.focusNextGroup)
  keymap("n", "<C-h>", editor.focusPreviousGroup)
  keymap("n", "<S-l>", editor.focusNext)
  keymap("n", "<S-h>", editor.focusPrevious)

  keymap({ 'n' }, "<leader>rr", refactor.rename)
  keymap({ 'n', "v" }, "<leader>ri", refactor.inlineChat)

  keymap({ 'n' }, "<leader>mm", bookmark.toggle)
  keymap({ 'n' }, "<leader>ml", bookmark.list)
  keymap({ 'n' }, "<leader>..", bookmark.next)
  keymap({ 'n' }, "<leader>,,", bookmark.previous)
  keymap({ 'n' }, "<leader>mc", bookmark.clear)

  keymap({ 'n' }, "<leader>ii", workspace.toggleSidebar)
  keymap({ 'n' }, "<leader>pp", workspace.showCommands)
  keymap({ 'n' }, "<leader>tt", workspace.tree)
  keymap({ 'n' }, "<leader>ww", workspace.closeEditor)
  keymap({ 'n' }, "<leader>WW", workspace.closeOtherEditor)

  keymap({ 'n' }, "<leader>ff", file.find)
  keymap({ 'n' }, "<leader>fn", file.new)
  keymap({ 'n' }, "<leader>fr", file.rename)
  keymap({ 'n', 'v' }, "<leader>fs", file.save)
  keymap({ 'n', 'v' }, "<leader>fS", file.saveAll)
  keymap({ 'n' }, "<leader>ft", file.showInTree)

  keymap({ 'n' }, "<leader>sr", search.reference)
  keymap({ 'n' }, "<leader>sp", search.project)
  keymap({ 'n' }, "<leader>ss", search.text)

  keymap({ 'n' }, "<leader>zz", fold.toggle)
  keymap({ 'n' }, "<leader>za", fold.all)
  keymap({ 'n' }, "<leader>zo", fold.openAll)

  keymap({ 'n', "v" }, ">", indentation.rightindent)
  keymap({ 'n', "v" }, "<", indentation.leftindent)

  keymap({ 'n', 'v' }, "<leader>/", comment.selected)
end
