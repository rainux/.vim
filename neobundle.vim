if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \    },
      \ }

" Bundles:
" Generally Useful:
NeoBundle 'https://github.com/kana/vim-textobj-user.git'
NeoBundle 'https://github.com/scrooloose/nerdtree.git'
NeoBundle 'https://github.com/jistr/vim-nerdtree-tabs.git'
NeoBundle 'https://git.wincent.com/command-t.git'
NeoBundle 'https://github.com/rainux/Color-Scheme-Test.git'
NeoBundle 'https://github.com/rainux/vim-desert-warm-256.git'
NeoBundle 'https://github.com/Lokaltog/vim-easymotion.git'
NeoBundle 'https://github.com/rainux/tslime.vim.git'
NeoBundle 'bling/vim-airline'
NeoBundle 'https://github.com/sjl/gundo.vim.git'
NeoBundle 'rking/ag.vim'
NeoBundle 'DrawIt'
NeoBundle 'bufexplorer.zip'
NeoBundle 'matrix.vim--Yang'
NeoBundle 'taskpaper.vim'
NeoBundle 'vim2ansi'
NeoBundle 'railscasts'
NeoBundle 'Shougo/neocomplcache', {'depends': [
      \ ['Shougo/neosnippet', {'depends': [
      \   'honza/vim-snippets',
      \ ]}],
      \ ]}

" Programming:
NeoBundle 'https://github.com/godlygeek/tabular.git'
NeoBundle 'https://github.com/hallettj/jslint.vim.git'
NeoBundle 'fatih/vim-go'
NeoBundle 'https://github.com/kchmck/vim-coffee-script.git'
NeoBundle 'https://github.com/majutsushi/tagbar.git'
NeoBundle 'https://github.com/rainux/vim-vala.git'
NeoBundle 'https://github.com/scrooloose/nerdcommenter.git'
NeoBundle 'https://github.com/tpope/vim-abolish.git'
NeoBundle 'https://github.com/tpope/vim-endwise.git'
NeoBundle 'https://github.com/tpope/vim-flatfoot.git'
NeoBundle 'https://github.com/tpope/vim-fugitive.git'
NeoBundle 'https://github.com/tpope/vim-git.git'
NeoBundle 'https://github.com/tpope/vim-markdown.git'
NeoBundle 'https://github.com/tpope/vim-ragtag.git'
NeoBundle 'https://github.com/tpope/vim-repeat.git'
NeoBundle 'https://github.com/tpope/vim-speeddating.git', {'bind': 0, 'tags': ['date', 'slow']}
NeoBundle 'https://github.com/tpope/vim-surround.git'
NeoBundle 'https://github.com/tpope/vim-unimpaired.git'
NeoBundle 'https://repo.or.cz/vcscommand.git'
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
NeoBundle 'https://github.com/vim-ruby/vim-ruby.git'
NeoBundle 'https://github.com/nelstrom/vim-textobj-rubyblock.git'
NeoBundle 'https://github.com/tpope/vim-bundler.git'
NeoBundle 'https://github.com/tpope/vim-cucumber.git'
NeoBundle 'https://github.com/tpope/vim-haml.git'
NeoBundle 'https://github.com/tpope/vim-rails.git'
NeoBundle 'https://github.com/tpope/vim-rake.git'
NeoBundle 'https://github.com/slim-template/vim-slim.git'
NeoBundle 'https://github.com/rainux/vim-turbux.git'


call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

if !has('vim_starting')
  " Call on_source hook when reloading .vimrc.
  call neobundle#call_hook('on_source')
endif
