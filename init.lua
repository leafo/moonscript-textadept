--- the Textadept initializer for the Moonscript module.
-- @copyright 2015-2016
-- @license MIT (see LICENSE)
-- @module init

local _snippets = require("moonscript.snippets")

textadept.file_types.extensions.moon = 'moonscript'
textadept.editing.comment_string.moonscript = '--'

textadept.run.compile_commands.moonscript = 'moonc %f'
textadept.run.run_commands.moonscript = 'moon %f'

textadept.run.build_commands["Tupfile(%.lua)?"] = "tup"

events.connect(events.LEXER_LOADED, function (lang)
  if lang ~= 'moonscript' then return end

  buffer.tab_width = 2
  buffer.use_tabs = false
end)

if type(snippets) == 'table' then
  snippets.moonscript = _snippets
end

keys.moonscript = {
  [not OSX and not CURSES and 'cl' or 'ml'] = {
    -- Open this module for editing: `Alt/⌘-L` `M`
    s = function()
      io.open_file(_USERHOME..'/modules/moonscript/snippets.lua')
    end,
  },

}

--- compiles automatically any moonscript file.
-- disable by changing _AUTOLINT to false.
events.connect(events.FILE_AFTER_SAVE, function()
  if buffer:get_lexer() ~= 'moonscript' or not _MOONAUTOLINT then return end
  buffer:annotation_clear_all()
  local err =  io.popen("moonc -l " .. buffer.filename .. " 2>&1"):read('*a')

  local line = err:match("^.+(%d+).+>>")
  if line and tonumber(line) > 0 then
    line = tonumber(line) - 1
    local msg  = err:match(">>.+"):gsub('>>%s+','')
    -- If the error line is not onscreen, annotate the current line.
    if (line < buffer.first_visible_line or
        line > buffer.first_visible_line + buffer.lines_on_screen) then
      msg = 'line '..(line + 1)..'\n'..msg
      line = buffer:line_from_position(buffer.current_pos)
    end
    buffer.annotation_visible = 2
    buffer.annotation_text[line] = "Error: " .. msg
    buffer.annotation_style[line] = 8 -- error style number
    buffer:goto_line(line)
  end
end)


return { }
