# MoonScript Textadept support

This package comes with both a theme and a syntax lexer.

![screenshot](https://raw.githubusercontent.com/leafo/moonscript-textadept/master/screenshot.png)

## Install

To install, copy `lexers/moonscript.lua` to a `lexers` directory in your local
textadept directory (usually `.textadept`).

To install the theme copy `themes/moon.lua` to a `themes` directory in your
local textadept directory.

Update your `init.lua`:

```lua
-- enable the lexer
local file_types = require "textadept.file_types"
file_types.extensions.moon = "moonscript"

-- enable the theme, with a custom font (optional)
ui.set_theme(CURSES and "term" or "moon", {
	font = "Source Code Pro",
	fontsize = 14,
})
```
