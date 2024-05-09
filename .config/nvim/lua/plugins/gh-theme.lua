return {
	'projekt0n/github-nvim-theme',
	lazy = false,   -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require('github-theme').setup({
			options = {
				styles = {
					comments = 'italic',
					keywords = 'italic',
					types = 'italic,bold',
					functions = 'NONE',
					variables = 'NONE',
					conditionals = 'bold',
					constants = 'italic',
					numbers = 'italic',
					operators = 'bold',
					strings = 'italic',
				},
				darken = {
					floats = false,
					sidebars = {
						enabled = true,
						list = { 'qf', 'netrw', 'Trouble' }
					}
				}
			}
		})

		vim.cmd('colorscheme github_dark')
	end,
}
