if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#rc(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim', {'depends': [
      \ 'Shougo/unite.vim',
      \ ['Shougo/vimproc', {'build': {
      \   'windows': 'make -f make_mingw32.mak',
      \   'cygwin': 'make -f make_cygwin.mak',
      \   'mac': 'make -f make_mac.mak',
      \   'unix': 'make -f make_unix.mak',
      \ }}]
      \ ]}

" Bundles:
" Generally Useful:
NeoBundle 'git://github.com/kana/vim-textobj-user.git'
NeoBundle 'git://github.com/scrooloose/nerdtree.git'
NeoBundle 'git://github.com/jistr/vim-nerdtree-tabs.git'
NeoBundle 'git://git.wincent.com/command-t.git'
NeoBundle 'git://github.com/rainux/Color-Scheme-Test.git'
NeoBundle 'git://github.com/rainux/vim-desert-warm-256.git'
NeoBundle 'git://github.com/mileszs/ack.vim.git'
NeoBundle 'git://github.com/Lokaltog/vim-easymotion.git'
NeoBundle 'git://github.com/Lokaltog/vim-powerline.git'
NeoBundle 'git://github.com/rainux/tslime.vim.git'
NeoBundle 'git://github.com/sjl/gundo.vim.git'
NeoBundle 'DrawIt'
NeoBundle 'bufexplorer.zip'
NeoBundle 'matrix.vim--Yang'
NeoBundle 'taskpaper.vim'
NeoBundle 'vim2ansi'
NeoBundle 'railscasts'

" Programming:
NeoBundle 'git://github.com/godlygeek/tabular.git'
NeoBundle 'git://github.com/hallettj/jslint.vim.git'
NeoBundle 'git://github.com/jnwhiteh/vim-golang.git'
NeoBundle 'git://github.com/kchmck/vim-coffee-script.git'
NeoBundle 'git://github.com/majutsushi/tagbar.git'
NeoBundle 'git://github.com/rainux/vim-vala.git'
NeoBundle 'git://github.com/scrooloose/nerdcommenter.git'
NeoBundle 'git://github.com/tpope/vim-abolish.git'
NeoBundle 'git://github.com/tpope/vim-endwise.git'
NeoBundle 'git://github.com/tpope/vim-flatfoot.git'
NeoBundle 'git://github.com/tpope/vim-fugitive.git'
NeoBundle 'git://github.com/tpope/vim-git.git'
NeoBundle 'git://github.com/tpope/vim-markdown.git'
NeoBundle 'git://github.com/tpope/vim-ragtag.git'
NeoBundle 'git://github.com/tpope/vim-repeat.git'
NeoBundle 'git://github.com/tpope/vim-speeddating.git', {'bind': 0, 'tags': ['date', 'slow']}
NeoBundle 'git://github.com/tpope/vim-surround.git'
NeoBundle 'git://github.com/tpope/vim-unimpaired.git'
NeoBundle 'git://repo.or.cz/vcscommand'
NeoBundle 'CRefVim'
NeoBundle 'JavaScript-syntax'
NeoBundle 'NSIS-syntax-highlighting'
NeoBundle 'OOP-javascript-indentation'
NeoBundle 'SingleCompile'
NeoBundle 'bash-support.vim', {'bind': 0, 'tags': ['bash', 'slow']}
NeoBundle 'c.vim', {'bind': 0, 'tags': ['c', 'slow']}
NeoBundle 'echofunc.vim'
NeoBundle 'jQuery'
NeoBundle 'lua-support'
NeoBundle 'matchit.zip'
NeoBundle 'std_c.zip'
NeoBundle 'taglist.vim'
NeoBundle 'po.vim--Jelenak'

" Ruby/Rails Programming:
NeoBundle 'git://github.com/vim-ruby/vim-ruby.git'
NeoBundle 'git://github.com/nelstrom/vim-textobj-rubyblock.git'
NeoBundle 'git://github.com/tpope/vim-bundler.git'
NeoBundle 'git://github.com/tpope/vim-cucumber.git'
NeoBundle 'git://github.com/tpope/vim-haml.git'
NeoBundle 'git://github.com/tpope/vim-rails.git'
NeoBundle 'git://github.com/tpope/vim-rake.git'
NeoBundle 'git://github.com/slim-template/vim-slim.git'
NeoBundle 'git://github.com/rainux/vim-turbux.git'

NeoBundleCheck
