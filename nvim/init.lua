vim.opt.clipboard = "unnamedplus"
-- search ignoring case
vim.opt.ignorecase = true
-- disable "ignorecase" option if the search pattern contains upper case characters
vim.opt.smartcase = true

--Key mappings
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
    vscall("workbench.action.quickOpen")
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
    vscallRange("editor.action.commentLine", vim.fn.line("v"), vim.fn.line("."), 1)
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
    vscall("workbench.action.findInFiles")
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

-- Mapping
vim.g.mapleader = ' ' 

-- nav
nv_keymap('<leader>h', '^')
nv_keymap('<leader>l', '$')  
nv_keymap('<leader>a', '%')

nx_keymap('j', 'gj')
nx_keymap('k', 'gk')

keymap('n', 'U', '<C-r>')
keymap('n', '<Esc>', ':nohlsearch<cr>')

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

keymap({ 'n' }, "<S-h>", ":bprevious<CR>", opts)
keymap({ 'n' }, "<S-l>", ":bnext<CR>", opts)

-- Only use in VSCode
if vim.g.vscode then
  keymap({ 'n' }, "<leader>rr", refactor.rename)
  keymap({ 'n', "v" }, "<leader>ri", refactor.inlineChat)

  keymap({ 'n' }, "<leader>mm", bookmark.toggle)
  keymap({ 'n' }, "<leader>ml", bookmark.list)
  keymap({ 'n' }, "<leader>..", bookmark.next)
  keymap({ 'n' }, "<leader>,,", bookmark.previous)
  keymap({ 'n' }, "<leader>mc", bookmark.clear)

  keymap({ 'n' }, "<leader>i", workspace.toggleSidebar)
  keymap({ 'n', 'v' }, "<leader> ", workspace.showCommands)
  keymap({ 'n' }, "<leader>t", workspace.tree)
  keymap({ 'n' }, "<leader>w", workspace.closeEditor)
  keymap({ 'n' }, "<leader>W", workspace.closeOtherEditor)

  keymap({ 'n' }, "<leader>ff", file.find)
  keymap({ 'n' }, "<leader>fn", file.new)
  keymap({ 'n' }, "<leader>fr", file.rename)
  keymap({ 'n', 'v' }, "<leader>fs", file.save)
  keymap({ 'n', 'v' }, "<leader>fS", file.saveAll)
  keymap({ 'n' }, "<leader>ft", file.showInTree)

  keymap({ 'n' }, "<leader>sr", search.reference)
  keymap({ 'n' }, "<leader>sp", search.project)
  keymap({ 'n' }, "<leader>st", search.text)

  keymap({ 'n' }, "<leader>z", fold.toggle)
  keymap({ 'n' }, "<leader>zz", fold.toggle)
  keymap({ 'n' }, "<leader>za", fold.all)
  keymap({ 'n' }, "<leader>zo", fold.openAll)

  keymap({ 'n', "v" }, ">", indentation.rightindent)
  keymap({ 'n', "v" }, "<", indentation.leftindent)

  keymap({ 'n', 'v' }, "<leader>/", comment.selected)
end
