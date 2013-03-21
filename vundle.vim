" Initialize vundle
set runtimepath^=~/.vim/bundle/vundle
call vundle#rc()

" Bundles:
" Generally Useful:
Bundle 'git://github.com/rainux/vundle.git'
Bundle 'git://github.com/kana/vim-textobj-user.git'
Bundle 'git://github.com/scrooloose/nerdtree.git'
Bundle 'git://github.com/jistr/vim-nerdtree-tabs.git'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'git://github.com/rainux/Color-Scheme-Test.git'
Bundle 'git://github.com/rainux/vim-desert-warm-256.git'
Bundle 'git://github.com/mileszs/ack.vim.git'
Bundle 'git://github.com/Lokaltog/vim-easymotion.git'
Bundle 'git://github.com/Lokaltog/vim-powerline.git'
Bundle 'git://github.com/rainux/tslime.vim.git'
Bundle 'git://github.com/sjl/gundo.vim.git'
Bundle 'DrawIt'
Bundle 'bufexplorer.zip'
Bundle 'matrix.vim--Yang'
Bundle 'taskpaper.vim'
Bundle 'vim2ansi'
Bundle 'railscasts'

" Programming:
Bundle 'git://github.com/godlygeek/tabular.git'
Bundle 'git://github.com/hallettj/jslint.vim.git'
Bundle 'git://github.com/jnwhiteh/vim-golang.git'
Bundle 'git://github.com/kchmck/vim-coffee-script.git'
Bundle 'git://github.com/majutsushi/tagbar.git'
Bundle 'git://github.com/rainux/vim-vala.git'
Bundle 'git://github.com/scrooloose/nerdcommenter.git'
Bundle 'git://github.com/tpope/vim-abolish.git'
Bundle 'git://github.com/tpope/vim-endwise.git'
Bundle 'git://github.com/tpope/vim-flatfoot.git'
Bundle 'git://github.com/tpope/vim-fugitive.git'
Bundle 'git://github.com/tpope/vim-git.git'
Bundle 'git://github.com/tpope/vim-markdown.git'
Bundle 'git://github.com/tpope/vim-ragtag.git'
Bundle 'git://github.com/tpope/vim-repeat.git'
Bundle 'git://github.com/tpope/vim-speeddating.git', {'bind': 0, 'tags': ['date', 'slow']}
Bundle 'git://github.com/tpope/vim-surround.git'
Bundle 'git://github.com/tpope/vim-unimpaired.git'
Bundle 'git://repo.or.cz/vcscommand'
Bundle 'CRefVim'
Bundle 'JavaScript-syntax'
Bundle 'NSIS-syntax-highlighting'
Bundle 'OOP-javascript-indentation'
Bundle 'SingleCompile'
Bundle 'bash-support.vim', {'bind': 0, 'tags': ['bash', 'slow']}
Bundle 'c.vim', {'bind': 0, 'tags': ['c', 'slow']}
Bundle 'echofunc.vim'
Bundle 'jQuery'
Bundle 'lua-support'
Bundle 'matchit.zip'
Bundle 'std_c.zip'
Bundle 'taglist.vim'
Bundle 'po.vim--Jelenak'

" Ruby/Rails Programming:
Bundle 'git://github.com/vim-ruby/vim-ruby.git'
Bundle 'git://github.com/nelstrom/vim-textobj-rubyblock.git'
Bundle 'git://github.com/tpope/vim-bundler.git'
Bundle 'git://github.com/tpope/vim-cucumber.git'
Bundle 'git://github.com/tpope/vim-haml.git'
Bundle 'git://github.com/tpope/vim-rails.git'
Bundle 'git://github.com/tpope/vim-rake.git'
Bundle 'git://github.com/slim-template/vim-slim.git'
Bundle 'git://github.com/rainux/vim-turbux.git'

BundleBind!
