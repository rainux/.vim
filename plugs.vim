" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Vim core feature extension  ........................................... {{{1
"
" Better fold markers
Plug 'dbmrq/vim-chalk'
" Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
" The NERDTree is a file system explorer for the Vim editor
Plug 'scrooloose/nerdtree'
  Plug 'jistr/vim-nerdtree-tabs'
" Plugin for easily exploring (or browsing) Vim buffers
Plug 'jlanzarotta/bufexplorer'
" ....................................................................... }}}1

" Vim color schemes  .................................................... {{{1
Plug 'rainux/Color-Scheme-Test'
Plug 'rainux/vim-desert-warm-256'
Plug 'rainux/base16-vim'
Plug 'joshdick/onedark.vim'
Plug 'drewtempelmeyer/palenight.vim'
" ....................................................................... }}}1

" Searchers  ............................................................ {{{1
"
" The ultimate fuzzy finder
Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf'
" Fuzzy file, buffer, mru, tag, etc finder
Plug 'ctrlpvim/ctrlp.vim'
" Improved incremental searching for Vim
Plug 'haya14busa/incsearch.vim'
  Plug 'haya14busa/incsearch-fuzzy.vim'
" ....................................................................... }}}1

" General text editing  ................................................. {{{1
"
" EasyMotion provides a much simpler way to use some motions in vim.
Plug 'easymotion/vim-easymotion'
" Align text with :Tabularize command
Plug 'godlygeek/tabular'
" ....................................................................... }}}1

" Git support  .......................................................... {{{1
"
" A Git wrapper so awesome, it should be illegal.
Plug 'tpope/vim-fugitive'
" Vim Git runtime files
Plug 'tpope/vim-git'
" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'airblade/vim-gitgutter'
" ....................................................................... }}}1

" General programming support  .......................................... {{{1
"
" Granular project configuration
Plug 'tpope/vim-projectionist'
" Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'honza/vim-snippets'
" Extended % matching for HTML, LaTeX, and many other languages
Plug 'vim-scripts/matchit.zip'
" A Vim plugin for visually displaying indent levels in code
Plug 'nathanaelkane/vim-indent-guides'
" A Vim plugin making it more convenient to compile or run a single source file.
Plug 'xuhdev/SingleCompile'
" Vim plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'
" Vim plugin that displays tags in a window, ordered by scope.
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
" A vim plugin that simplifies the transition between multiline and single-line code
Plug 'AndrewRadev/splitjoin.vim'
" ....................................................................... }}}1

" Programming languages support  ........................................ {{{1
"
Plug 'rust-lang/rust.vim', { 'for': ['rust', 'toml'] }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
" This C syntax file is to help developing portable Standard C code.
Plug 'vim-scripts/std_c.zip'
" A C-reference manual especially designed for Vim
Plug 'vim-scripts/CRefVim'
" JSON manipulation and pretty printing
Plug 'tpope/vim-jdaddy'
" NSIS syntax file for NSIS 2.46
Plug 'vim-scripts/NSIS-syntax-highlighting'
" A collection of language packs for Vim virtually support all popular
" programming languages.
Plug 'sheerun/vim-polyglot'
" ....................................................................... }}}1

" Productivity tools  ................................................... {{{1
"
" This package contains a syntax file and a file-type plugin for the simple
" format used by the TaskPaper application.
Plug 'davidoc/taskpaper.vim'
" Easily interact with tmux from vim.
Plug 'benmills/vimux'
  Plug 'jtdowney/vimux-cargo'
" ....................................................................... }}}1

" Legacy rarely used toy  ............................................... {{{1
"
" Ascii drawing plugin: lines, ellipses, arrows, fills, and more!
Plug 'vim-scripts/DrawIt'
" Convert highlighted text into ansi control sequence
Plug 'vim-scripts/vim2ansi'
" Matrix screensaver for VIM, inspired by Chris Allegretta's cmatrix.
Plug 'vim-scripts/matrix.vim--Yang'
" ....................................................................... }}}1

" ===========================================================
" Bellow are historical plugs that need to be tidied manually

" Generally Useful:
Plug 'https://github.com/kana/vim-textobj-user.git'

" Programming:
Plug 'https://github.com/tpope/vim-abolish.git'
" endwise.vim: wisely add "end" in ruby, endfunction/endif/more in vim script, etc
" Disabled due to conflict with coc.nvim
" Plug 'https://github.com/tpope/vim-endwise.git'
Plug 'https://github.com/tpope/vim-flatfoot.git'
Plug 'https://github.com/tpope/vim-ragtag.git'
Plug 'https://github.com/tpope/vim-repeat.git'
" Plug 'https://github.com/tpope/vim-speeddating.git', {'bind': 0, 'tags': ['date', 'slow']}
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/vim-easy-align'

" Ruby/Rails Programming:
Plug 'https://github.com/nelstrom/vim-textobj-rubyblock.git'
Plug 'https://github.com/tpope/vim-bundler.git'
Plug 'https://github.com/tpope/vim-rails.git'
Plug 'https://github.com/tpope/vim-rake.git'

" Initialize plugin system
call plug#end()

" vim: set fdm=marker fdl=0:
