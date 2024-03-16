return {
  "goolord/alpha-nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    dashboard.section.header.val = {
      "            :h-                                  Nhy`               ",
      "           -mh.                           h.    `Ndho               ",
      "           hmh+                          oNm.   oNdhh               ",
      "          `Nmhd`                        /NNmd  /NNhhd               ",
      "          -NNhhy                      `hMNmmm`+NNdhhh               ",
      "          .NNmhhs              ```....`..-:/./mNdhhh+               ",
      "           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ",
      "           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ",
      "      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ",
      " .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ",
      " h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ",
      " hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ",
      " /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ",
      "  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ",
      "   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ",
      "     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ",
      "       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ",
      "       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ",
      "       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ",
      "       //+++//++++++////+++///::--                 .::::-------::   ",
      "       :/++++///////////++++//////.                -:/:----::../-   ",
      "       -/++++//++///+//////////////               .::::---:::-.+`   ",
      "       `////////////////////////////:.            --::-----...-/    ",
      "        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ",
      "         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ",
      "           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ",
      "            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``",
      "           s-`::--:::------:////----:---.-:::...-.....`./:          ",
      "          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ",
      "         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ",
      "        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ",
      "                        .-:mNdhh:.......--::::-`                    ",
      "                           yNh/..------..`                          ",
      "                                                                    ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("p", "  Find file", "<CR>:FzfLua files<CR>"),
      dashboard.button("e", "  Explore", ":ene<CR>:NvimTreeFocus<CR>"),
      dashboard.button("r", "  Recent files", ":FzfLua oldfiles<CR>"),
      dashboard.button("u", "  Update plugins and parsers", ":Lazy sync<CR> :TSUpdate<CR>"),
      dashboard.button("q", "󰅘 Quit", ":qa<CR>"),
    }

    dashboard.config.opts.noautocmd = true
    alpha.setup(dashboard.config)
  end
}
