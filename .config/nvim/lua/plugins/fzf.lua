return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local map = require('pisetski.mappings')
    local fzf = require('fzf-lua')

    vim.keymap.set("n", "<C-P>", function()
      local bufname = vim.fn.expand("%")

      -- Do not open fzf if Harpoon menu is open
      if string.find(bufname, "harpoon") then
        vim.api.nvim_input('<Up>')
        return
      end

      require('fzf-lua').files()
    end)
    map('n', '<c-G>', "<cmd>lua require('fzf-lua').live_grep_native()<CR>")
    map('n', '<leader>fj', "<cmd>lua require('fzf-lua').jumps()<CR>")
    map('n', '<leader>fb', "<cmd>lua require('fzf-lua').buffers()<CR>")
    map('n', '<leader>fr', "<cmd>lua require('fzf-lua').oldfiles()<CR>")
    map('n', '<leader>fv', "<cmd>lua require('fzf-lua').git_branches()<CR>")
    map('n', '<leader>fm', "<cmd>lua require('fzf-lua').marks()<CR>")
    map('n', '<leader>fy', "<cmd>lua require('fzf-lua').registers()<CR>")
    map('n', '<leader>fw', "<cmd>lua require('fzf-lua').grep_cword()<CR>")
    map('n', '<leader>fW', "<cmd>lua require('fzf-lua').grep_cWORD()<CR>")
    map('n', '<leader>fs', "<cmd>lua require('fzf-lua').git_status()<CR>")

    -- Pass custom cwd to grep
    map('n', '<leader>fd', ":FzfLua live_grep_native cwd=./", { noremap = true })

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

    fzf.setup({
      "skim",
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
        filter = "rg -v '\\.(lock|csv)'",
        actions = { ['default'] = _G.my_action }
      },
    })
  end
}
