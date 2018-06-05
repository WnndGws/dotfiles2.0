#!/usr/bin/zsh
## A script to install all my vim plugins

mkdir ~/.vim/bundle
cd ~/.vim/bundle

git clone https://github.com/w0rp/ale.git #linter
git clone https://github.com/dkarter/bullets.vim #plugins for automated bullet lists
git clone https://github.com/Raimondi/delimitMate.git #autocomplete brackets etc.
git clone https://github.com/junegunn/fzf.vim.git #fuzzyfind
git clone https://github.com/mattn/gist-vim.git #gists in vim
git clone https://github.com/Yggdroot/indentLine.git #better indenting
git clone https://github.com/haya14busa/incsearch.vim.git #improved incrimental searching
git clone https://github.com/davidhalter/jedi-vim.git #autocomplete
git clone https://github.com/Shougo/neocomplete.vim #neocomplete
git clone https://github.com/scrooloose/nerdtree.git #filebrowser
git clone https://github.com/luochen1990/rainbow.git #rainbow parentheses
git clone https://github.com/wellle/targets.vim.git #better targeting
git clone https://github.com/chiedo/vim-case-convert.git #convert between cases
git clone https://github.com/altercation/vim-colors-solarized.git #vim colours solarized
git clone https://github.com/easymotion/vim-easymotion.git #easymotion
git clone https://github.com/terryma/vim-expand-region.git #expand region
git clone https://github.com/jamessan/vim-gnupg.git #gnupg
git clone https://github.com/jez/vim-superman.git #use man pages
git clone https://github.com/reedes/vim-pencil.git #pencil
git clone https://github.com/sheerun/vim-polyglot.git #language pack
git clone https://github.com/lervag/vimtex.git #use latex
git clone https://github.com/dhruvasagar/vim-table-mode.git #tables in vim
git clone https://github.com/mattn/webapi-vim.git #webapi for vim
git clone https://github.com/lifepillar/vim-solarized8.git #colours
git clone git://github.com/SirVer/ultisnips.git #snippets engine
git clone git://github.com/honza/vim-snippets.git #snippets definitions
git clone https://github.com/ervandew/supertab.git #needed for snippets and neocomplete to work together
