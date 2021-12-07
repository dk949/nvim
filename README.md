# nvim

neovim config

## How to use

* clone **recursively** to `$XDG_CONFIG_HOME`
* launch nvim
* see [cheatsheet](cheatsheet.md) for key bindings

``` vim
:PluginInstall
```

## Plugins and dependencies

* coc
  * [nodejs](https://nodejs.org/en/)
  * [npm](https://www.npmjs.com/)
  * everything that mentions '(coc)' as a dependency would also require these
  * Make sure to also clone the [coc config](https://github.com/dk949/coc).
* c++
  * [ccls](https://github.com/MaskRay/ccls)
  * [clang-format](https://clang.llvm.org/docs/ClangFormat.html)
  * [cpplint](https://github.com/cpplint/cpplint)
  * (coc)
* c++ linting
  * [clang-tidy](https://clang.llvm.org/extra/clang-tidy/)
  * [cppcheck](https://cppcheck.sourceforge.io/)
* cmake
  * [cmake-format](https://github.com/cheshirekow/cmake_format)
  * (coc)
* git
  * [git](https://git-scm.com/)
* haskell
  * [stack](https://haskellstack.org)
    * Specifically stack repl
  * [HLS](https://github.com/haskell/haskell-language-server)
  * (coc)
* hexedit
  * [xxd](https://linux.die.net/man/1/xxd)
    * included with vim, but not neovim
* JS/TS
  * (coc)
* json
  * [jq](https://stedolan.github.io/jq/)
  * (coc)
* man
  * [man](https://man7.org/linux/man-pages/man1/man.1.html)
* Markdown
  * [formark](https://github.com/dk949/formark/)
* python
  * (coc)
* ripgrep
  * [ripgrep](https://github.com/BurntSushi/ripgrep)
* rust
  * (coc)
* tex
  * [pdflatex](https://www.tug.org/texlive/)
  * [execf](https://github.com/dk949/shellutils/blob/master/execf.sh)
* xml
  * [xmllint](http://xmlsoft.org/xmllint.html)
