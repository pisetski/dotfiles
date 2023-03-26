local null_ls = require('null-ls')
local eslint = require('eslint')
local cwds = { "virtual-nursing", "overlay", "online-checkin", "superadmin", "videocall" }

local function findCWD(params)
  for _, cwd in ipairs(cwds) do
    if params.bufname:find(cwd) then
      return cwd
    end
  end
end

local sources = {
  null_ls.builtins.formatting.eslint_d.with({
    -- Falls back to bufname if return value is nil
    cwd = findCWD,
  }),
  null_ls.builtins.diagnostics.eslint_d.with({
    -- Falls back to bufname if return value is nil
    cwd = findCWD,
  }),
  null_ls.builtins.code_actions.eslint_d.with({
    -- Falls back to bufname if return value is nil
    cwd = findCWD,
  }),
}

null_ls.setup({
  sources = sources,
})

eslint.setup({
  bin = 'eslint_d',
  code_actions = {
    enable = true,
    apply_on_save = {
      enable = true,
      types = { "directive", "problem", "suggestion", "layout" },
    },
    disable_rule_comment = {
      enable = true,
      location = "separate_line", -- or `same_line`
    },
  },
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
    run_on = "type", -- or `save`
  },
})
