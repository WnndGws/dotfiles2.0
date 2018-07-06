
" >>>>> PRECURSOR SETTINGS <<<<< "
" ------------------------------ "

set nocompatible
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

" ----------------------------- "
" >>>>> TEMPLATE SETTINGS <<<<< "
" ----------------------------- "

if has("autocmd")
  augroup templates
    autocmd BufNewFile *.tex 0r ~/.vim/templates/skeleton_docs.tex
    autocmd BufNewFile *.service 0r ~/.vim/templates/skeleton.service
    autocmd BufNewFile *.timer 0r ~/.vim/templates/skeleton.timer
    autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
    autocmd BufNewFile *soln.md 0r ~/.vim/templates/skeleton_soln.md
    autocmd BufNewFile *beamer*.md 0r ~/.vim/templates/skeleton_beamer.md
    autocmd BufNewFile README.md 0r ~/.vim/templates/skeleton_readme.md
    autocmd BufNewFile CONTRIBUTING.md 0r ~/.vim/templates/skeleton_contributing.md
  augroup END
endif
autocmd FileType markdown let g:indentLine_enabled=0

"Navigating with guides
inoremap <Space><Space> <Esc>/<++><Enter>"_c4l

""""LATEX
"autocmd FileType tex inoremap ;em \emph{}<++><Esc>T{i
"autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>T{i
"autocmd FileType tex inoremap ;it \textit{}<++><Esc>T{i
"autocmd FileType tex inoremap ;tc \textcite{}<++><Esc>T{i
"autocmd FileType tex inoremap ;pc \parencite{}<++><Esc>T{i
"autocmd FileType tex inoremap ;ol \begin{enumerate}<Enter><Tab>\end{enumerate}<Enter><Tab><++><Esc>2kA<Enter><Tab>\item<Space>
"autocmd FileType tex inoremap ;ul \begin{itemize}<Enter><Tab>\end{itemize}<Enter><Tab><++><Esc>2kA<Enter><Tab>\item<Space>
"autocmd FileType tex inoremap ;li \item<Space>
"autocmd FileType tex inoremap ;chap \chapter{}<Enter><Tab><++><Esc>-f}i
"autocmd FileType tex inoremap ;sec \section{}<Enter><Tab><++><Esc>-f}i
"autocmd FileType tex inoremap ;ssec \subsection{}<Enter><Tab><++><Esc>-f}i
"autocmd FileType tex inoremap ;sssec \subsubsection{}<Enter><Tab><++><Esc>-f}i
"autocmd FileType tex inoremap ;ques \begin{questions}<Enter><Tab>\end{questions}<Enter><Tab><++><Esc>2kA<Enter><Tab>\newquestion{}<Space>
"autocmd FileType tex inoremap ;part \begin{parts}<Enter><Tab>\end{parts}<Enter><Tab><++><Esc>2kA<Enter><Tab>\newpart{}<Space>

" ---------------------------- "
" >>>>> GENERAL SETTINGS <<<<< "
" ---------------------------- "
au InsertEnter * let updaterestore=&updatetime | set updatetime=5000
au InsertLeave * let &updatetime=updaterestore
au CursorHoldI * call ExitInsertMode()
" automatically leave insert mode after 'updatetime' milliseconds of inaction
" set 'updatetime' to 5 seconds when in insert mode

set autoindent

set formatoptions+=j
"Proper line join

set clipboard=unnamed
set relativenumber
"Shows relative line numbers so math doesnt need to be done

set number
"Line numbers are good

set cursorline
"Sets cursorline

set backspace=indent,eol,start
"Allow backspace in insert mode

set history=1000
"Store lots of :cmdline history

set showcmd
"Show incomplete cmds down the bottom

set showmode
"Show current mode down the bottom

set gcr=a:blinkon0
"Disable cursor blink

set autoread
"Reload files changed outside vim

set timeoutlen=1000
set ttimeoutlen=10
set showmatch

set mousehide
" Hide the mouse cursor while typing

scriptencoding utf-8
set iskeyword-=.
" '.' is an end of word designator
set iskeyword-="
" '"' is an end of word designator
set iskeyword-=-
" '-' is an end of word designator
set iskeyword-=_
" '_' is an end of word designator

set noundofile

set undolevels=1000
" Maximum number of changes that can be undone

set undoreload=10000
" Maximum number lines to save for undo on a buffer reload

set ignorecase
" Case insensitive search

set smartcase
" Case sensitive when uc present

"set spell spelllang=en_au
" Uses spellcheck in vim

set splitright
" Puts new vsplit windows to the right of the current

set splitbelow
" Puts new split windows to the bottom of the current

set hidden
" Buffers exist in the background

set noswapfile
set nobackup
set nowb

set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

set list listchars=tab:\ \ ,trail:·
" Display tabs and trailing spaces visually

set nowrap
"Don't wrap lines

set nofoldenable
"set foldmethod=indent
"Allow me to fold by my settings

" --------------------------- "
" >>>>> KEYMAP SETTINGS <<<<< "
" --------------------------- "
let mapleader = ","

noremap <leader>b :w<Home>silent <End> !urlview<CR>
"Use urlview to open links

map <leader>sc :setlocal spell!<cr>
"Pressing :sc will toggle and untoggle spell checking

map <leader>sa <Esc>]szg
"Spell add word to dictionary
" ]s is go to next spelling error
" zg adds to dictionary

map <leader>cs <Esc>]s1z=
" leader cs corrects spelling by choosing the first suggestion
" 1z= is choose first suggestion
" ]s is go to next spelling error

map <leader>ln :execute "normal! i" . ( line("."))<cr>
"Insert the line number

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
"Hit v to visually select character, again to select word, again to select paragraph

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"split navigations

nnoremap <Leader>w :w<CR>
" Save file using leader w

nnoremap <Leader><right> :vsp<CR>
nnoremap <Leader><down> :sp<CR>
" Split vim using leader keys

nnoremap <BS> {
onoremap <BS> {
vnoremap <BS> {
"Remaps backspace to move back a paragraph

nnoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
onoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
vnoremap <CR> }
"Remaps enter to move forward a paragraph

" --------------------------- "
" >>>>> SWITCH SETTINGS <<<<< "
" --------------------------- "
syntax on
" Turn on syntax highlighting

" --------------------- "
" >>>>> FUNCTIONS <<<<< "
" --------------------- "
cmap w!! %!sudo tee > /dev/null %
"Stolen from CIA Hack, save file you forgot to open as root

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
"Delete trailing white space on save, useful for Python and CoffeeScript

fun! ExitInsertMode()
    if &ft =~ 'tex'
        return
    endif
    if &ft =~ 'python'
        return
    endif
    stopinsert
endfun

""" Cycle through case of selected text
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" ----------------------- "
" >>>>> VIM PLUGINS <<<<< "
" ----------------------- "
execute pathogen#infect()

"------------------------"
" ALE
let g:ale_sign_column_always = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

"------------------------"
" EMMET
vmap <Leader>h <c-y>,
" Enables emmit

vmap <Leader>hc <c-y>/
" Comments out the selected html
" https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL

"------------------------"
" NERDTREE
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Close nerdtree if it is the only window left

nnoremap <Leader>nt :NERDTreeToggle<CR>
" Toggle nerdtree using leader nt

"------------------------"
" GISTS
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1
let g:gist_show_privates = 1
let g:gist_update_on_write = 1

nnoremap <Leader>g :Gist
" Save file using leader w

"------------------------"
" PYTHON MUMBOJUMBO
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
"python with virtualenv support
"Allows you complete me to find the venv packages

let python_highlight_all=1

"------------------------"
" VIMTEX
let g:tex_flavor = 'latex'
let g:vimtex_enabled=1
let g:vimtex_compiler_method='latexmk'
let g:vimtex_compiler_latexmk = {'callback' : 0}
let g:tex_conceal = ''
let g:polyglot_disabled = ['latex']


" Vimtex mappings

let g:livepreview_previewer = 'mupdf'

nnoremap <leader>vtc :VimtexCompile
nnoremap <leader>vtr :VimtexReload
nnoremap <leader>vtv :VimtexView
" Vimtex mappings

" Compile on initialization, cleanup on quit
augroup vimtex_event_1
  au!
  au User VimtexEventQuit     call vimtex#compiler#clean(0)
  "au User VimtexEventInitPost call vimtex#compiler#compile()
augroup END

" Close viewers on quit
function! CloseViewers()
  if executable('xdotool') && exists('b:vimtex')
      \ && exists('b:vimtex.viewer') && b:vimtex.viewer.xwin_id > 0
    call system('xdotool windowclose '. b:vimtex.viewer.xwin_id)
  endif
endfunction

augroup vimtex_event_2
  au!
  au User VimtexEventQuit call CloseViewers()
augroup END

"------------------------"
" NEOCOMPLETE
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Tab completion

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
    \ '\v\\%('
    \ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
    \ . '|hyperref\s*\[[^]]*'
    \ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|%(include%(only)?|input)\s*\{[^}]*'
    \ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . '|usepackage%(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . '|documentclass%(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . '|\a*'
    \ . ')'
 
"------------------------"
" VIMCASE
map <Leader>stc :SnakeToCamel
map <Leader>cth :CamelToHyphen
map <Leader>cts :CamelToSnake
map <Leader>htc :HyphenToCamel
map <Leader>hts :HyphenToSnake
map <Leader>sth :SnakeToHyphen

" ----------------------"
" SOLARIZED COLOURS
if has('gui_running')
    colorscheme solarized8_dark
endif
" Sets the colorscheme in gvim, but keeps terminal vim default

set termguicolors
set background=dark
colorscheme solarized8
" ----------------------"
" FZF
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" ----------------------"
" EASYMOTIONS
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" ----------------------"
" VIM-PENCIL
autocmd FileType * call pencil#init({'wrap': 'soft'})

" ----------------------"
" INC-SEARCH
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" ----------------------"
" RAINBOW
 let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" ----------------------"
" ULTISNIPS
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<leader><tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

" ----------------------"
" VIM-MARKDOWN
" pandoc , markdown
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'
nmap <Leader>md :RunSilent pandoc -o /tmp/vim-pandoc-out.pdf % && mupdf /tmp/vim-pandoc-out.pdf &<cr>
