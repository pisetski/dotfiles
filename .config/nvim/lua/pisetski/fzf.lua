local m = require('pisetski.mappings')
local fzf = require('fzf-lua')

_G.my_action = function(selected, opts)
  if #selected > 1 then
    -- code from `actions.file_sel_to_qf`
    local qf_list = {}
    for i = 1, #selected do
      local file = fzf.path.entry_to_file(selected[i], opts)
      local text = selected[i]:match(":%d+:%d?%d?%d?%d?:?(.*)$")
      table.insert(qf_list, {
        filename = file.path,
        lnum = file.line,
        col = file.col,
        text = text,
      })
    end
    -- this sets the quickfix list, you may or may not need it for 'trouble.nvim'
    vim.fn.setqflist(qf_list)
    -- call the command to open the 'trouble.nvim' interface
    vim.cmd("Trouble quickfix")
  else
    fzf.actions.file_edit(selected, opts)
  end
end

fzf.setup {
  winopts = {
    preview = { default = 'bat_native' }
  },
  files = {
    winopts = {
      width = 0.44,
      height = 0.44,
      preview = {
        hidden = 'hidden'
      }
    },
    actions = { ['default'] = _G.my_action },
  },
  git = {
    branches = {
      winopts = {
        width = 0.44,
        height = 0.44,
        preview = {
          hidden = 'hidden'
        }
      }
    }
  },
  oldfiles = {
    cwd_only  = true,
    stat_file = true, -- verify files exist on disk
    winopts   = {
      width = 0.44,
      height = 0.44,
      preview = {
        layout = 'vertical'
      }
    },
    actions   = { ['default'] = _G.my_action },
  },
  buffers = {
    cwd_only = true,
    winopts  = {
      width = 0.44,
      height = 0.44,
      preview = {
        layout = 'vertical'
      }
    },
    actions  = { ['default'] = _G.my_action },
  },
  grep = {
    filter = "rg -v '\\.(yaml|lock|csv)'",
    actions = { ['default'] = _G.my_action }
  },
}

m.mapFzf()
