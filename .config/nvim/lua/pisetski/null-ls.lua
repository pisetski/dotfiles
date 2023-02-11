local null_ls = require('null-ls')
local cwds = { "icc", "overlay", "online-checkin", "superadmin", "videocall", "ui-components" }

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
