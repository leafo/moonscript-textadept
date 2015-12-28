local l = require("lexer")
local token, word_match
token, word_match = l.token, l.word_match
local S, P, R, Cmt
do
  local _obj_0 = require("lpeg")
  S, P, R, Cmt = _obj_0.S, _obj_0.P, _obj_0.R, _obj_0.Cmt
end
local _NAME = "moonscript"
local ws = token(l.WHITESPACE, l.space ^ 1)
local longstring = Cmt("[" * lpeg.C(P("=") ^ 0) * "[", function(input, index, eq)
  local _, e = input:find("]" .. tostring(eq) .. "]", index, true)
  return (e or #input) + 1
end)
local line_comment = "--" * l.nonnewline ^ 0
local block_comment = "--" * longstring
local comment = token(l.COMMENT, block_comment + line_comment)
local sq_str = l.delimited_range("'")
local dq_str = l.delimited_range('"')
local string = token(l.STRING, sq_str + dq_str) + token("longstring", longstring)
local literals = token(l.LABEL, word_match({
  "true",
  "false",
  "nil"
}))
local keyword = token(l.KEYWORD, word_match({
  "with",
  "else",
  "do",
  "class",
  "while",
  "continue",
  "or",
  "switch",
  "using",
  "export",
  "extends",
  "not",
  "and",
  "return",
  "elseif",
  "if",
  "break",
  "for",
  "in",
  "import",
  "local",
  "when",
  "then",
  "from",
  "unless"
}))
local invalid = token(l.ERROR, word_match({
  "end",
  "function",
  "repeat"
}))
local constant = token(l.CONSTANT, word_match({
  "_G",
  "_VERSION",
  "_ENV"
}))
local func = token(l.FUNCTION, word_match({
  "assert",
  "collectgarbage",
  "dofile",
  "error",
  "getmetatable",
  "ipairs",
  "load",
  "loadfile",
  "next",
  "pairs",
  "pcall",
  "print",
  "rawequal",
  "rawget",
  "rawset",
  "require",
  "select",
  "setmetatable",
  "tonumber",
  "tostring",
  "type",
  "xpcall",
  "rawlen"
}))
local library = token("library", word_match({
  "coroutine",
  "coroutine.create",
  "coroutine.resume",
  "coroutine.running",
  "coroutine.status",
  "coroutine.wrap",
  "coroutine.yield",
  "coroutine.isyieldable",
  "package",
  "package.cpath",
  "package.loaded",
  "package.loadlib",
  "package.path",
  "package.preload",
  "package.config",
  "package.searchers",
  "package.searchpath",
  "utf8",
  "utf8.char",
  "utf8.charpattern",
  "utf8.codepoint",
  "utf8.codes",
  "utf8.len",
  "utf8.offset",
  "string",
  "string.byte",
  "string.char",
  "string.dump",
  "string.find",
  "string.format",
  "string.gmatch",
  "string.gsub",
  "string.len",
  "string.lower",
  "string.match",
  "string.rep",
  "string.reverse",
  "string.sub",
  "string.upper",
  "string.pack",
  "string.packsize",
  "string.unpack",
  "table",
  "table.concat",
  "table.insert",
  "table.remove",
  "table.sort",
  "table.pack",
  "table.unpack",
  "table.move",
  "math",
  "math.abs",
  "math.acos",
  "math.asin",
  "math.atan",
  "math.ceil",
  "math.cos",
  "math.deg",
  "math.exp",
  "math.floor",
  "math.fmod",
  "math.huge",
  "math.log",
  "math.max",
  "math.min",
  "math.modf",
  "math.pi",
  "math.rad",
  "math.random",
  "math.randomseed",
  "math.sin",
  "math.sqrt",
  "math.tan",
  "math.maxinteger",
  "math.mininteger",
  "math.tointeger",
  "math.type",
  "math.ult",
  "io",
  "io.close",
  "io.flush",
  "io.input",
  "io.lines",
  "io.open",
  "io.output",
  "io.popen",
  "io.read",
  "io.stderr",
  "io.stdin",
  "io.stdout",
  "io.tmpfile",
  "io.type",
  "io.write",
  "os",
  "os.clock",
  "os.date",
  "os.difftime",
  "os.execute",
  "os.exit",
  "os.getenv",
  "os.remove",
  "os.rename",
  "os.setlocale",
  "os.time",
  "os.tmpname",
  "debug",
  "debug.debug",
  "debug.gethook",
  "debug.getinfo",
  "debug.getlocal",
  "debug.getmetatable",
  "debug.getregistry",
  "debug.getupvalue",
  "debug.sethook",
  "debug.setlocal",
  "debug.setmetatable",
  "debug.setupvalue",
  "debug.traceback",
  "debug.getuservalue",
  "debug.setuservalue",
  "debug.upvalueid",
  "debug.upvaluejoin",
  "package.loaders",
  "package.seeall",
  "table.maxn",
  "math.log10",
  "math.atan2",
  "math.cosh",
  "math.frexp",
  "math.ldexp",
  "math.pow",
  "math.sinh",
  "math.tanh",
  "bit32",
  "bit32.arshift",
  "bit32.band",
  "bit32.bnot",
  "bit32.bor",
  "bit32.btest",
  "bit32.extract",
  "bit32.lrotate",
  "bit32.lshift",
  "bit32.replace",
  "bit32.rrotate",
  "bit32.rshift",
  "bit32.xor",
  "debug.getfenv",
  "debug.setfenv"
}, "."))
local alphanum = R("az", "AZ", "09", "__")
local cls = token(l.CLASS, P("@") * alphanum ^ 0 + (R("AZ") * alphanum ^ 0) + word_match({
  "self",
  "super"
}))
local upper_operator = token(l.TYPE, P("->") + P("=>") + S("[]()"))
local operator = token(l.OPERATOR, S("+-*/%^#=<>&|~;:,.{}[]()!\\"))
local identifier = token(l.IDENTIFIER, l.word)
local key = token(l.FUNCTION, P(":") * alphanum ^ 1 + alphanum ^ 1 * P(":"))
local lua_integer = P("-") ^ -1 * (l.hex_num + l.dec_num)
local number = token(l.NUMBER, l.float + lua_integer)
local _tokenstyles = {
  longstring = l.STYLE_STRING,
  library = l.STYLE_TYPE
}
local _rules = {
  {
    "whitespace",
    ws
  },
  {
    "function",
    func + key
  },
  {
    "label",
    literals
  },
  {
    "keyword",
    keyword
  },
  {
    "error",
    invalid
  },
  {
    "class",
    cls
  },
  {
    "constant",
    constant
  },
  {
    "library",
    library
  },
  {
    "identifier",
    identifier
  },
  {
    "string",
    string
  },
  {
    "comment",
    comment
  },
  {
    "number",
    number
  },
  {
    "type",
    upper_operator
  },
  {
    "operator",
    operator
  }
}
return {
  _NAME = _NAME,
  _rules = _rules,
  _tokenstyles = _tokenstyles,
  _FOLDBYINDENTATION = true
}
