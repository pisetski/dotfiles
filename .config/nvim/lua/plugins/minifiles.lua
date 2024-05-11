return {
	'echasnovski/mini.files',
	version = '*',
	config = function()
		local map = require('pisetski.mappings')
		local MiniFiles = require('mini.files')

		local show_dotfiles = true

		local filter_show = function(_) return true end

		local filter_hide = function(fs_entry)
			return not vim.startswith(fs_entry.name, '.')
		end

		local toggle_dotfiles = function()
			show_dotfiles = not show_dotfiles
			local new_filter = show_dotfiles and filter_show or filter_hide
			MiniFiles.refresh({ content = { filter = new_filter } })
		end

		local map_split = function(buf_id, lhs, direction)
			local rhs = function()
				-- Make new window and set it as target
				local new_target_window
				vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
					vim.cmd(direction .. ' split')
					new_target_window = vim.api.nvim_get_current_win()
				end)

				MiniFiles.set_target_window(new_target_window)
			end

			-- Adding `desc` will result into `show_help` entries
			local desc = 'Split ' .. direction
			vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
		end

		local map_tab = function(buf_id, lhs)
			local rhs = function()
				-- Get the file system entry under the cursor
				local fs_entry = MiniFiles.get_fs_entry()
				print(fs_entry.path)
				if fs_entry and fs_entry.fs_type == 'file' then
					MiniFiles.close()
					-- Open the file in a new tab
					vim.cmd('tabedit ' .. fs_entry.path)
				else
					print("No file under the cursor.")
				end
			end

			local desc = 'Open in new tab'
			vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
		end

		vim.api.nvim_create_autocmd('User', {
			pattern = 'MiniFilesBufferCreate',
			callback = function(args)
				local buf_id = args.data.buf_id
				vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
				map_split(buf_id, 'gs', 'belowright horizontal')
				map_split(buf_id, 'gv', 'belowright vertical')
				map_tab(buf_id, 'gt')
			end,
		})
		map('n', '<space>e', ':lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>')

		MiniFiles.setup()
	end
}
