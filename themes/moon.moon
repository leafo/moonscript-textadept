-- moon theme for Textadept
-- implemented by leaf, colors by kristen

buffer = buffer
property, property_int = buffer.property, buffer.property_int

-- needed to convert string colors for some methods
hex_to_int = (str) ->
  r,g,b = str\match "#(..)(..)(..)"
  r = tonumber r, 16
  g = tonumber g, 16
  b = tonumber b, 16
  (b << 16) + (g << 8) + r

property["color.black0"]      = "#121212" -- background
property["color.black"]       = "#1F1F1F" -- background
property["color.black2"]      = "#2B2B2B" -- lighter
property["color.black3"]      = "#303030" -- lighterer
property["color.black4"]      = "#6D6D6D" -- lighterer

property["color.white"]       = "#FFFFFF" -- default

property["color.yellow"]      = "#F1BF8E" -- string
property["color.blue"]        = "#99CBCA" -- ProperThings
property["color.purple"]      = "#BB84B4" -- keywords
property["color.pink"]        = "#F277A1" -- key:, operators
property["color.green"]       = "#B0D89C" -- function literals, ops []()
property["color.orange"]      = "#F69385" -- builtins
property["color.gray"]        = "#929292" -- comments
property["color.light_blue"]  = "#B3EFE5" -- true, false, nil
property["color.blue_purple"] = "#9D8FF2" -- numbers
property["color.red"]         = "#F32C75" -- invalid tokens

-- the assignments

-- Default font.
property['font'], property['fontsize'] = 'Bitstream Vera Sans Mono', 12

if WIN32
  property['font'] = 'Courier New'
elseif OSX
  property['font'], property['fontsize'] = 'Monaco', 12

-- Predefined styles.
property['style.default'] = 'font:%(font),size:%(fontsize),fore:%(color.white),back:%(color.black)'
property['style.linenumber'] = 'fore:%(color.black3),back:%(color.black0)'

--property['style.controlchar'] =
property['style.indentguide'] = 'fore:%(color.black3)'
property['style.calltip'] = 'fore:%(color.white),back:%(color.black2)'

-- Token styles.
property['style.class'] = 'fore:%(color.blue)'
property['style.comment'] = 'fore:%(color.gray)'
property['style.constant'] = 'fore:%(color.blue)'

property['style.embedded'] = '%(style.keyword),back:%(color.black3)'
property['style.error'] = 'fore:%(color.white),back:%(color.red)'
property['style.function'] = 'fore:%(color.orange)'
property['style.identifier'] = ''
property['style.keyword'] = 'fore:%(color.purple)'
property['style.label'] = 'fore:%(color.light_blue)' -- okay?
property['style.number'] = 'fore:%(color.blue_purple)'
property['style.operator'] = 'fore:%(color.pink)'
property['style.preprocessor'] = 'fore:%(color.green)'
property['style.regex'] = 'fore:%(color.yellow)'
property['style.string'] = 'fore:%(color.yellow)'
property['style.type'] = 'fore:%(color.green)'
property['style.variable'] = 'fore:%(color.white)'
property['style.whitespace'] = ''

-- Multiple Selection and Virtual Space
--buffer.additional_sel_alpha =
--buffer.additional_sel_fore =
--buffer.additional_sel_back =
--buffer.additional_caret_fore =

-- Caret and Selection Styles.
-- buffer\set_sel_fore true, hex_to_int property['color.red']
buffer\set_sel_back true, hex_to_int property["color.black3"]

--buffer.sel_alpha =
buffer.caret_fore = hex_to_int property['color.gray']
buffer.caret_line_back = hex_to_int property['color.black2']
--buffer.caret_line_back_alpha =

-- Fold Margin.
buffer\set_fold_margin_colour true, hex_to_int property["color.black"]
buffer\set_fold_margin_hi_colour true, hex_to_int property["color.black"]

-- Markers.
MARK_BOOKMARK = textadept.bookmarks.MARK_BOOKMARK
--buffer.marker_fore[MARK_BOOKMARK] = property_int['color.black']
buffer.marker_back[MARK_BOOKMARK] = hex_to_int property['color.blue']
--buffer.marker_fore[textadept.run.MARK_WARNING] = property_int['color.black']
buffer.marker_back[textadept.run.MARK_WARNING] = hex_to_int property['color.yellow']
--buffer.marker_fore[textadept.run.MARK_ERROR] = property_int['color.black']
buffer.marker_back[textadept.run.MARK_ERROR] = hex_to_int property['color.red']

for i = 25, 31 do -- fold margin markers
  buffer.marker_fore[i] = hex_to_int property['color.black0']
  buffer.marker_back[i] = hex_to_int property['color.black3']
  buffer.marker_back_selected[i] = hex_to_int property['color.black3']

-- Indicators.
buffer.indic_fore[ui.find.INDIC_FIND] = hex_to_int property['color.yellow']
buffer.indic_alpha[ui.find.INDIC_FIND] = 255
INDIC_BRACEMATCH = textadept.editing.INDIC_BRACEMATCH
buffer.indic_fore[INDIC_BRACEMATCH] = hex_to_int property['color.gray']
INDIC_HIGHLIGHT = textadept.editing.INDIC_HIGHLIGHT
buffer.indic_fore[INDIC_HIGHLIGHT] = hex_to_int property['color.orange']
buffer.indic_alpha[INDIC_HIGHLIGHT] = 255
INDIC_PLACEHOLDER = textadept.snippets.INDIC_PLACEHOLDER
buffer.indic_fore[INDIC_PLACEHOLDER] = hex_to_int property['color.gray']

-- Call tips.
--buffer.call_tip_fore_hlt = property_int['color.light_blue']

-- Long Lines.
buffer.edge_colour = hex_to_int property['color.black0']
