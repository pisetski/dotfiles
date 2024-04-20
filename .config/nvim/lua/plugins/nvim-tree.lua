return {
  "kyazdani42/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  cmd = {
    "NvimTreeFocus"
  },
  keys = {
    { '<Space>E', '<cmd>NvimTreeFindFile<cr>',       desc = "NvimTreeFindFile" },
    { '<Space>e', '<cmd>NvimTreeFindFileToggle<cr>', desc = "NvimTreeFindFileToggle" },
  },
  config = function()
    local function on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function copy_or_move_file_to(node, copy)
        local file_src = node.absolute_path
        -- The args of input are {prompt}, {default}, {completion}
        -- Read in the new file path using the existing file's path as the baseline.
        local cmd_str = copy and "COPY" or "MOVE"
        local file_out = vim.fn.input(cmd_str .. " TO: ", file_src, "file")
        -- Create any parent dirs as required
        local dir = vim.fn.fnamemodify(file_out, ":h")

        -- gitbash.exe has win32 but no move. A better check is if the system has the `mv` command
        -- Note: In windows copy is also `cp`
        local is_win = vim.fn.executable('mv') == 0

        -- Make parent dir as required
        local mkdir_cmd = is_win and { 'mkdir', dir } or { 'mkdir', '-p', dir }
        vim.fn.system(mkdir_cmd)
        local cmds = {
          win = {
            copy = { 'cp', file_src, file_out },
            move = { 'move', file_src, file_out },
          },
          linux = {
            copy = { 'cp', '-R', file_src, file_out },
            move = { 'mv', file_src, file_out },
          }
        }
        local cmd_arr = cmds[is_win and 'win' or 'linux'][copy and 'copy' or 'move']
        vim.fn.system(cmd_arr)
        if not copy then
          -- If a move, then associate any open buffers with the moved file with the new file path
          for _, buf in ipairs(vim.fn.getbufinfo()) do
            if buf.name == file_src then
              -- Set the buffer's name to the new destination path
              print(buf.name, '\n', file_src, '\n', file_out)
              vim.api.nvim_buf_set_name(buf.bufnr, file_out)
              vim.api.nvim_buf_call(buf.bufnr, function()
                vim.cmd('e')
              end)
            end
          end
          vim.cmd('redraw!')
          vim.cmd('redrawstatus!') -- Doesn't work with my status line
        end
      end
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.events.subscribe(api.events.Event.FileCreated, function(file)
        vim.cmd("edit " .. file.fname)
      end)

      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.del('n', 's', { buffer = bufnr })
      vim.keymap.del('n', 'S', { buffer = bufnr })

      vim.keymap.set('n', 'A', api.tree.expand_all, opts('Expand All'))
      vim.keymap.set('n', 'Z', api.node.run.system, opts('Run System'))

      vim.keymap.set('n', 'c', function()
        local node = api.tree.get_node_under_cursor()
        copy_or_move_file_to(node, true)
      end, opts('copy_file_to'))

      vim.keymap.set('n', 'm', function()
        local node = api.tree.get_node_under_cursor()
        -- If the buffer is open, move the buffer path too
        local source_path = node.absolute_path
        -- Iterate through all open buffers
        copy_or_move_file_to(node, false)
      end, opts('move_file_to'))
    end

    require("nvim-tree").setup({
      sort_by = 'case_sensitive',
      view = {
        side = "right",
        adaptive_size = true,
        centralize_selection = true,
      },
      on_attach = on_attach,
      renderer = {
        group_empty = true,
        highlight_git = true,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = {
          '^\\.git'
        }
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      filesystem_watchers = {
        enable = true,
      },
      diagnostics = {
        enable = false
      },
    })
  end
}
