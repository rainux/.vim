" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Vim core feature extension
Plug 'dbmrq/vim-chalk'          " Better fold markers
Plug 'vim-airline/vim-airline'  " Lean & mean status/tabline for vim that's light as air
  Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
  Plug 'jistr/vim-nerdtree-tabs'

" Vim color schemes
Plug 'rainux/Color-Scheme-Test'
Plug 'rainux/vim-desert-warm-256'
Plug 'rainux/base16-vim'

" Searchers
Plug 'wincent/command-t', { 'do': 'rake make' }
Plug 'mhinz/vim-grepper'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'

" General programming support
Plug 'nathanaelkane/vim-indent-guides'
Plug 'xuhdev/SingleCompile'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'honza/vim-snippets'

" Programming languages support
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'rust-lang/rust.vim', { 'for': ['rust', 'toml'] }
  Plug 'cespare/vim-toml'

" ===========================================================
" Bellow are historical plugs that need to be tidied manually

" Generally Useful:
Plug 'https://github.com/kana/vim-textobj-user.git'
Plug 'https://github.com/Lokaltog/vim-easymotion.git'
Plug 'https://github.com/rainux/tslime.vim.git'
" PlugLazy 'DrawIt'
" PlugLazy 'bufexplorer.zip'
Plug 'vim-scripts/matrix.vim--Yang'
Plug 'vim-scripts/taskpaper.vim'
Plug 'vim-scripts/vim2ansi'
Plug 'ctrlpvim/ctrlp.vim'

" Programming:
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'https://github.com/kchmck/vim-coffee-script.git'
Plug 'https://github.com/rainux/vim-vala.git'
Plug 'https://github.com/tpope/vim-abolish.git'
" endwise.vim: wisely add "end" in ruby, endfunction/endif/more in vim script, etc
" Disabled due to conflict with coc.nvim
" Plug 'https://github.com/tpope/vim-endwise.git'
Plug 'https://github.com/tpope/vim-flatfoot.git'
Plug 'https://github.com/tpope/vim-markdown.git'
Plug 'https://github.com/tpope/vim-ragtag.git'
Plug 'https://github.com/tpope/vim-repeat.git'
" Plug 'https://github.com/tpope/vim-speeddating.git', {'bind': 0, 'tags': ['date', 'slow']}
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'vim-scripts/vcscommand.vim'
Plug 'godlygeek/tabular'
" PlugLazy 'Valloric/YouCompleteMe', {
     " \ 'build'      : {
        " \ 'mac'     : './install.py',
        " \ 'unix'    : './install.py',
        " \ 'windows' : 'install.py',
        " \ 'cygwin'  : './install.py'
        " \ }
     " \ }
Plug 'vim-scripts/CRefVim'
Plug 'vim-scripts/NSIS-syntax-highlighting'
Plug 'pangloss/vim-javascript'
" Plug 'bash-support.vim', {'bind': 0, 'tags': ['bash', 'slow']}
" Plug 'c.vim', {'bind': 0, 'tags': ['c', 'slow']}
Plug 'vim-scripts/echofunc.vim'
Plug 'vim-scripts/jQuery'
" PlugLazy 'lua-support'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/std_c.zip'
Plug 'vim-scripts/po.vim--Jelenak'
" Plug 'kballard/vim-swift', {
        " \ 'filetypes': 'swift',
        " \ 'unite_sources': ['swift/device', 'swift/developer_dir']
        " \}
Plug 'mxw/vim-jsx'
Plug 'leafo/moonscript-vim'
Plug 'tpope/vim-jdaddy'
Plug 'elzr/vim-json'
Plug 'ekalinin/Dockerfile.vim'
Plug 'othree/html5.vim'
Plug 'justmao945/vim-clang'
Plug 'othree/html5.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/vim-easy-align'

" Ruby/Rails Programming:
Plug 'https://github.com/vim-ruby/vim-ruby.git'
Plug 'https://github.com/nelstrom/vim-textobj-rubyblock.git'
Plug 'https://github.com/tpope/vim-bundler.git'
Plug 'https://github.com/tpope/vim-cucumber.git'
Plug 'https://github.com/tpope/vim-haml.git'
Plug 'https://github.com/tpope/vim-rails.git'
Plug 'https://github.com/tpope/vim-rake.git'
Plug 'https://github.com/slim-template/vim-slim.git'
Plug 'https://github.com/rainux/vim-turbux.git'

" Initialize plugin system
call plug#end()
