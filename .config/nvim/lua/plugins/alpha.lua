return {
  "goolord/alpha-nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    dashboard.section.header.val = {
      [[                                                    ]],
      [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
      [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
      [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
      [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
      [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
      [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
      [[                                                    ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("p", "  Find file", "<CR>:FzfLua files<CR>"),
      dashboard.button("e", "  Explore", ":ene<CR>:NvimTreeFocus<CR>"),
      dashboard.button("r", "  Recent files", ":FzfLua oldfiles<CR>"),
      dashboard.button("u", "  Update plugins and parsers", ":Lazy sync<CR> :TSUpdate<CR>"),
      dashboard.button("q", "󰅘  Quit", ":qa<CR>"),
    }
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local v = vim.version()
        local dev = ""
        if v.prerelease == "dev" then
          dev = "-dev+" .. v.build
        else
          dev = ""
        end
        local version = v.major .. "." .. v.minor .. "." .. v.patch .. dev
        local stats = require("lazy").stats()
        local plugins_count = stats.loaded .. "/" .. stats.count
        local ms = math.floor(stats.startuptime + 0.5)
        local line1 = " " .. plugins_count .. " plugins loaded in " .. ms .. "ms"
        local line3 = "v" .. version

        local line1_width = vim.fn.strdisplaywidth(line1)
        local line3Padded = string.rep(" ", (line1_width - vim.fn.strdisplaywidth(line3)) / 2) .. line3

        dashboard.section.footer.val = {
          line1,
          line3Padded,
        }
        pcall(vim.cmd.AlphaRedraw)
      end,
    })


    dashboard.config.opts.noautocmd = true
    alpha.setup(dashboard.config)
  end
}
