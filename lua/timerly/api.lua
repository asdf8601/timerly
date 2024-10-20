local M = {}
local utils = require "timerly.utils"
local state = require "timerly.state"
local redraw = require("volt").redraw

M.start = function()
  local mins = state.mode == "pause" and (state.total_secs / 60) or state.config.minutes
  utils.start(mins)
  state.mode = "start"
end

M.reset = function()
  state.progress = 0
  state.mode = ""
  state.timer:stop()
  utils.secs_to_ascii(state.config.minutes * 60)
  redraw(state.buf, "clock")
  redraw(state.buf, "progress")
end

M.pause = function()
  state.mode = "pause"
  state.timer:stop()
end

M.increment = function()
  state.config.minutes = state.config.minutes + 1
  utils.secs_to_ascii(state.config.minutes * 60)
  redraw(state.buf, "clock")
end

M.decrement = function()
  state.config.minutes = state.config.minutes - 1
  utils.secs_to_ascii(state.config.minutes * 60)
  redraw(state.buf, "clock")
end

return M
