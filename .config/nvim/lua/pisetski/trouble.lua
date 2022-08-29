local m = require('pisetski.mappings')

local util = require("trouble.util")
local _jump_to_item = util.jump_to_item
util.jump_to_item = function(win, ...)
  return _jump_to_item(win or 0, ...)
end

require('trouble').setup()

m.mapTrouble()
