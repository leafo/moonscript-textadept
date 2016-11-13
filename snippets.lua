--- Moonscript snippets.
-- @author [Alejandro Baez](https://twitter.com/a_baez)
-- copyright 2015
-- @license MIT (see LICENSE)
-- @module snippets

return {
  -- function
  fn    = '%1(name) = %2((%3(param)) )%4(-)> \n\t%0',
  fna   = '%1((%2(param)) )%3(-)> %0',

  -- oop
  class = 'class %1(Name)\n\t%0',
  ce    = 'class %1(Name) extends %2(NewName)\n\t%0',
  ca    = 'class extends %1(Name)\n\t%0',
  mn    = 'new: %1(param) => \n\t%0',
  fnm   = '%1(name): %2((%3(param))) => \n\t%0',

  -- conditionals
  ['if']      = 'if %1(expr)\n\t%0',
  ['ift']     = 'if %1(expr) then %0',
  ['ifc']     = 'continue if %1(expr) %0',
  ['ife']     = 'if %1(expr)\n\t%2(body)\nelse\n\t%0',
  ['else']    = 'else \n\t%0',
  ['elseif']  = 'elseif %1(expr)\n\t%0',
  ['unless']  = 'unless %1(expr)\n\t%0',
  ['when']    = 'when %1(expr)\n\t%0',
  ['switch']  = 'switch %1(item)\n\t%2(when)\n\t%3(else)',

  -- keys
  ['key']    = '%1(key): %2(value)%0',
  ['var']  = ':%1(variable)%0',

  -- comprehensions
  lc = '[%0 for %1(value) in ipairs %2(list)]',
  li = '[%0 for %1(value) in %2(iterator)%3( when)]',
  ln = '[%0 for %1(i) = %2(1), %3(10)]',
  tc = '{%0 for %1(k), %2(v) in pairs %3(table)%4( when)}',

  -- loops
  ['for']   = 'for %1(i) = %2(1), %3(10)%4(, %5(-1))\n\t%0',
  ford  = 'for %1(value) in %2(iterator) do %0',
  fori  = 'for %1(value) in %2(iterator)\n\t%0',
  forp  = 'for %1(k), %2(v) in %3(i)pairs %4(table)\n\t%0',
  ['while'] = 'while %1(expr)\n\t%0',
  wd    = 'while %1(expr) do %0',

  -- random
  ['#']     = '#{%1(expr)}%0',
  imp       = 'import %1(values) %2(from %3(module))',
  r         = 'require "%1(module)"%0',
  ['with']  = 'with %1(expr)\n\t%0',
}
