# MoonScript Textadept support
[![license][6i]][6l]
[Moonscript][4] module for [Textadept][1].

## Information
This module comes with snippets, theme, lexer, and auto lint for Moonscript.
The snippets can be found under the **snippets.lua** file. The theme is located
under **themes/** directory. The lexer is in **lexer/** directory. Auto linting
allows you to have your work checked after save. It is disabled by default, but
you can very easily enabled as described below, under *Usage*.

![screenshot](https://raw.githubusercontent.com/leafo/moonscript-textadept/master/screenshot.png)

## Install
To install, you need to clone the repository into your **_USERHOME/modules** directory:

```
cd ~/.textadept/modules
git clone https://github.com/leafo/moonscript-textadept.git \
    moonscript
```

You are done! If you want to use the latest in development version of the lexer,
or any of the other abilities of the module, then continue along in *Usage*.

### Usage

#### enable auto lint.
You only need to modify your **_USERHOME/init.lua** file with the following:

```
-- init.lua

_MOONAUTOLINT = true
```

#### moonscript lexer
Copy the **lexers/moonscript.lua** file into your **_USERHOME/lexers/**
directory:

```
cp ~/.textadept/modules/moonscript/lexers/moonscript.lua \
    ~/.textadept/lexers/moonscript.lua
```

#### Theme install
To install the theme, copy **themes/moon.lua** into **themes/** directory in
your local textadept directory.

```
cp ~/.textadept/modules/moonscript/themes/moon.lua \
    ~/.textadept/themes/moon.lua
```

Then update your **_USERHOME/init.lua** with the following:

```lua
-- init.lua

-- enable the theme, with a custom font (optional)
ui.set_theme(CURSES and "term" or "moon", {
	font = "Source Code Pro",
	fontsize = 14,
})
```

## Keybindings

```
Keys        Action
cl+s        opens snippets directory for modifying.
cR          runs `moonc` on the current moonscript file.
cr          runs `moon` on the current moonscript file.
cB          builds the project with tup.
```

[1]: http://foicica.com/textadept/
[2]: https://twitter.com/a_baez
[3]: https://twitter.com/moonscript
[4]: http://moonscript.org/
[5]: http://gittup.org/tup/
[6i]: https://img.shields.io/badge/license-MIT-green.svg
[6l]: ./LICENSE
