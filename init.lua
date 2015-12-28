local file_types = require "textadept.file_types"
file_types.extensions.moon = "moonscript"

ui.set_theme(CURSES and "term" or "moon", {
	font = "Source Code Pro",
	fontsize = 14,
})

