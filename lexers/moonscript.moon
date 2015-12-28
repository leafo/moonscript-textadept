l = require "lexer"

import token, word_match from l
import S, P, R, Cmt from require "lpeg"

_NAME = "moonscript"

ws = token l.WHITESPACE, l.space^1

longstring = Cmt "[" * lpeg.C(P("=")^0) * "[",
  (input, index, eq) ->
    _, e = input\find "]#{eq}]", index, true
    (e or #input) + 1

line_comment = "--" * l.nonnewline^0
block_comment = "--" * longstring
comment = token l.COMMENT, block_comment + line_comment

sq_str = l.delimited_range "'"
dq_str = l.delimited_range '"'
string = token(l.STRING, sq_str + dq_str) + token("longstring", longstring)

literals = token l.LABEL, word_match {
  "true", "false", "nil"
}

keyword = token l.KEYWORD, word_match {
  "with", "else", "do", "class", "while", "continue", "or", "switch", "using",
  "export", "extends", "not", "and", "return", "elseif", "if", "break", "for",
  "in", "import", "local", "when", "then", "from", "unless"
}

invalid = token l.ERROR, word_match {
  "end", "function", "repeat"
}

constant = token l.CONSTANT, word_match {
  "_G", "_VERSION", "_ENV"
}

func = token l.FUNCTION, word_match {
  "assert", "collectgarbage", "dofile", "error", "getmetatable", "ipairs",
  "load", "loadfile", "next", "pairs", "pcall", "print", "rawequal", "rawget",
  "rawset", "require", "select", "setmetatable", "tonumber", "tostring",
  "type", "xpcall", "rawlen"
}

library = token "library", word_match {
  -- Coroutine.
  "coroutine", "coroutine.create", "coroutine.resume", "coroutine.running",
  "coroutine.status", "coroutine.wrap", "coroutine.yield",
  -- Coroutine added in 5.3.
  "coroutine.isyieldable",
  -- Module.
  "package", "package.cpath", "package.loaded", "package.loadlib",
  "package.path", "package.preload",
  -- Module added in 5.2.
  "package.config", "package.searchers", "package.searchpath",
  -- UTF-8 added in 5.3.
  "utf8", "utf8.char", "utf8.charpattern", "utf8.codepoint", "utf8.codes",
  "utf8.len", "utf8.offset",
  -- String.
  "string", "string.byte", "string.char", "string.dump", "string.find",
  "string.format", "string.gmatch", "string.gsub", "string.len", "string.lower",
  "string.match", "string.rep", "string.reverse", "string.sub", "string.upper",
  -- String added in 5.3.
  "string.pack", "string.packsize", "string.unpack",
  -- Table.
  "table", "table.concat", "table.insert", "table.remove", "table.sort",
  -- Table added in 5.2.
  "table.pack", "table.unpack",
  -- Table added in 5.3.
  "table.move",
  -- Math.
  "math", "math.abs", "math.acos", "math.asin", "math.atan", "math.ceil",
  "math.cos", "math.deg", "math.exp", "math.floor", "math.fmod", "math.huge",
  "math.log", "math.max", "math.min", "math.modf", "math.pi", "math.rad",
  "math.random", "math.randomseed", "math.sin", "math.sqrt", "math.tan",
  -- Math added in 5.3.
  "math.maxinteger", "math.mininteger", "math.tointeger", "math.type",
  "math.ult",
  -- IO.
  "io", "io.close", "io.flush", "io.input", "io.lines", "io.open", "io.output",
  "io.popen", "io.read", "io.stderr", "io.stdin", "io.stdout", "io.tmpfile",
  "io.type", "io.write",
  -- OS.
  "os", "os.clock", "os.date", "os.difftime", "os.execute", "os.exit",
  "os.getenv", "os.remove", "os.rename", "os.setlocale", "os.time",
  "os.tmpname",
  -- Debug.
  "debug", "debug.debug", "debug.gethook", "debug.getinfo", "debug.getlocal",
  "debug.getmetatable", "debug.getregistry", "debug.getupvalue",
  "debug.sethook", "debug.setlocal", "debug.setmetatable", "debug.setupvalue",
  "debug.traceback",
  -- Debug added in 5.2.
  "debug.getuservalue", "debug.setuservalue", "debug.upvalueid",
  "debug.upvaluejoin",

  -- Module deprecated in 5.2.
  "package.loaders", "package.seeall",
  -- Table deprecated in 5.2.
  "table.maxn",
  -- Math deprecated in 5.2.
  "math.log10",
  -- Math deprecated in 5.3.
  "math.atan2", "math.cosh", "math.frexp", "math.ldexp", "math.pow",
  "math.sinh", "math.tanh",
  -- Bit32 deprecated in 5.3.
  "bit32", "bit32.arshift", "bit32.band", "bit32.bnot", "bit32.bor",
  "bit32.btest", "bit32.extract", "bit32.lrotate", "bit32.lshift",
  "bit32.replace", "bit32.rrotate", "bit32.rshift", "bit32.xor",
  -- Debug deprecated in 5.2.
  "debug.getfenv", "debug.setfenv"
}, "."

alphanum = R("az", "AZ", "09", "__")

cls = token l.CLASS, P("@") * alphanum^0 + (R("AZ") * alphanum^0) + word_match {"self", "super"}
upper_operator = token l.TYPE, P"->" + P"=>" + S"[]()"
operator = token l.OPERATOR, S "+-*/%^#=<>&|~;:,.{}[]()!\\"

identifier = token l.IDENTIFIER, l.word
key = token l.FUNCTION, P":" * alphanum^1 + alphanum^1 * P":"

lua_integer = P("-")^-1 * (l.hex_num + l.dec_num)
number = token l.NUMBER, l.float + lua_integer

_tokenstyles = {
  longstring: l.STYLE_STRING
  library: l.STYLE_TYPE
}

_rules = {
  {"whitespace", ws}
  {"function", func + key}
  {"label", literals}
  {"keyword", keyword}
  {"error", invalid}
  {"class", cls}
  {"constant", constant}
  {"library", library}
  {"identifier", identifier}
  {"string", string}
  {"comment", comment}
  {"number", number}
  {"type", upper_operator}
  {"operator", operator}
}

{
  :_NAME
  :_rules
  :_tokenstyles
  _FOLDBYINDENTATION: true
}
