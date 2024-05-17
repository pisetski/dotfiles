return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	config = function(_, opts)
		require 'lsp_signature'.setup(opts)

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf

				require("lsp_signature").on_attach({
					bind = true,
					hint_enable = false,
					handler_opts = {
						border = {
							{ ' ', 'FloatBorder' },
							{ ' ', 'FloatBorder' },
							{ ' ', 'FloatBorder' },
							{ ' ', 'FloatBorder' },
							{ ' ', 'FloatBorder' },
							{ ' ', 'FloatBorder' },
							{ ' ', 'FloatBorder' },
							{ ' ', 'FloatBorder' },
						}
					},
				}, bufnr)
			end,
		})
	end
}
