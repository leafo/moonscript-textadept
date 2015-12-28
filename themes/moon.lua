local buffer = buffer
local property, property_int = buffer.property, buffer.property_int
local hex_to_int
hex_to_int = function(str)
  local r, g, b = str:match("#(..)(..)(..)")
  r = tonumber(r, 16)
  g = tonumber(g, 16)
  b = tonumber(b, 16)
  return (b << 16) + (g << 8) + r
end
property["color.black0"] = "#121212"
property["color.black"] = "#1F1F1F"
property["color.black2"] = "#2B2B2B"
property["color.black3"] = "#303030"
property["color.black4"] = "#6D6D6D"
property["color.white"] = "#FFFFFF"
property["color.yellow"] = "#F1BF8E"
property["color.blue"] = "#99CBCA"
property["color.purple"] = "#BB84B4"
property["color.pink"] = "#F277A1"
property["color.green"] = "#B0D89C"
property["color.orange"] = "#F69385"
property["color.gray"] = "#929292"
property["color.light_blue"] = "#B3EFE5"
property["color.blue_purple"] = "#9D8FF2"
property["color.red"] = "#F32C75"
property['font'], property['fontsize'] = 'Bitstream Vera Sans Mono', 12
if WIN32 then
  property['font'] = 'Courier New'
elseif OSX then
  property['font'], property['fontsize'] = 'Monaco', 12
end
property['style.default'] = 'font:%(font),size:%(fontsize),fore:%(color.white),back:%(color.black)'
property['style.linenumber'] = 'fore:%(color.black3),back:%(color.black0)'
property['style.indentguide'] = 'fore:%(color.black3)'
property['style.calltip'] = 'fore:%(color.white),back:%(color.black2)'
property['style.class'] = 'fore:%(color.blue)'
property['style.comment'] = 'fore:%(color.gray)'
property['style.constant'] = 'fore:%(color.blue)'
property['style.embedded'] = '%(style.keyword),back:%(color.black3)'
property['style.error'] = 'fore:%(color.white),back:%(color.red)'
property['style.function'] = 'fore:%(color.orange)'
property['style.identifier'] = ''
property['style.keyword'] = 'fore:%(color.purple)'
property['style.label'] = 'fore:%(color.light_blue)'
property['style.number'] = 'fore:%(color.blue_purple)'
property['style.operator'] = 'fore:%(color.pink)'
property['style.preprocessor'] = 'fore:%(color.green)'
property['style.regex'] = 'fore:%(color.yellow)'
property['style.string'] = 'fore:%(color.yellow)'
property['style.type'] = 'fore:%(color.green)'
property['style.variable'] = 'fore:%(color.white)'
property['style.whitespace'] = ''
buffer:set_sel_back(true, hex_to_int(property["color.black3"]))
buffer.caret_fore = hex_to_int(property['color.gray'])
buffer.caret_line_back = hex_to_int(property['color.black2'])
buffer:set_fold_margin_colour(true, hex_to_int(property["color.black"]))
buffer:set_fold_margin_hi_colour(true, hex_to_int(property["color.black"]))
local MARK_BOOKMARK = textadept.bookmarks.MARK_BOOKMARK
buffer.marker_back[MARK_BOOKMARK] = hex_to_int(property['color.blue'])
buffer.marker_back[textadept.run.MARK_WARNING] = hex_to_int(property['color.yellow'])
buffer.marker_back[textadept.run.MARK_ERROR] = hex_to_int(property['color.red'])
for i = 25, 31 do
  buffer.marker_fore[i] = hex_to_int(property['color.black0'])
  buffer.marker_back[i] = hex_to_int(property['color.black3'])
  buffer.marker_back_selected[i] = hex_to_int(property['color.black3'])
end
buffer.indic_fore[ui.find.INDIC_FIND] = hex_to_int(property['color.yellow'])
buffer.indic_alpha[ui.find.INDIC_FIND] = 255
local INDIC_BRACEMATCH = textadept.editing.INDIC_BRACEMATCH
buffer.indic_fore[INDIC_BRACEMATCH] = hex_to_int(property['color.gray'])
local INDIC_HIGHLIGHT = textadept.editing.INDIC_HIGHLIGHT
buffer.indic_fore[INDIC_HIGHLIGHT] = hex_to_int(property['color.orange'])
buffer.indic_alpha[INDIC_HIGHLIGHT] = 255
local INDIC_PLACEHOLDER = textadept.snippets.INDIC_PLACEHOLDER
buffer.indic_fore[INDIC_PLACEHOLDER] = hex_to_int(property['color.gray'])
buffer.edge_colour = hex_to_int(property['color.black0'])
