" ----------------------------------------------------------------------------
" Configurations for plugins
"
" std_c
let c_syntax_for_h = 1
let c_C94 = 1
let c_C99 = 1
let c_cpp = 1
let c_warn_8bitchars = 1
let c_warn_multichar = 1
let c_warn_digraph = 1
let c_warn_trigraph = 1
let c_no_octal = 1

let c_comment_strings = 1
let c_comment_numbers = 1
let c_comment_types = 1
let c_comment_date_time = 1


" rubycomplete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_rails_proactive = 1


" ruby syntax
let g:ruby_fold = 1
let g:ruby_minlines = 200
let g:ruby_operators = 1


" NERD commenter
let g:NERDDefaultNesting = 1
let g:NERDShutUp = 1
let g:NERDSpaceDelims = 1


" vcscommand
nmap <Leader>va <Plug>VCSAdd
nmap <Leader>vn <Plug>VCSAnnotate
nmap <Leader>vG <Plug>VCSClearAndGotoOriginal
nmap <Leader>vc <Plug>VCSCommit
nmap <Leader>vD <Plug>VCSDelete
nmap <Leader>vd <Plug>VCSDiff
nmap <Leader>vg <Plug>VCSGotoOriginal
nmap <Leader>vi <Plug>VCSInfo
nmap <Leader>vL <Plug>VCSLock
nmap <Leader>vl <Plug>VCSLog
nmap <Leader>vq <Plug>VCSRevert
nmap <Leader>vr <Plug>VCSReview
nmap <Leader>vs <Plug>VCSStatus
nmap <Leader>vU <Plug>VCSUnlock
nmap <Leader>vu <Plug>VCSUpdate
nmap <Leader>vv <Plug>VCSVimDiff


" surround
"
" Work with gettext easier
let g:surround_45 = "_('\r')"
let g:surround_95 = "_(\"\r\")"


" speeddating
let g:speeddating_no_mappings = 1
nmap  <C-A>     <Plug>SpeedDatingUp
nmap  <C-X>     <Plug>SpeedDatingDown
nmap d<C-A>     <Plug>SpeedDatingNowUTC
nmap d<C-X>     <Plug>SpeedDatingNowLocal


" Tagbar
let g:tagbar_type_coffee = {
      \ 'ctagstype': 'CoffeeScript',
      \ 'kinds': [
      \   'c:class',
      \   'f:function',
      \   'v:variable',
      \ ],
      \ 'sort': 0
      \ }


" po.vim
let maplocalleader = ','


" Netrw
let g:netrw_home = expand('~/.vim/tmp')


" airline
let g:airline#extensions#default#section_truncate_width = {
  \ 'y': 120
  \ }
call airline#parts#define_function('filesize', 'GetFileSize')
call airline#parts#define_function('charcode', 'GetCharCode')
function! GetFileSize() " {{{
	let bytes = getfsize(expand("%:p"))

	if bytes <= 0
		return ''
	endif

	if bytes < 1024
		return bytes . 'B'
	else
		return (bytes / 1024) . 'kB'
	endif
endfunction "}}}
function! GetCharCode() " {{{
	" Get the output of :ascii
	redir => ascii
	silent! ascii
	redir END

	if match(ascii, 'NUL') != -1
		return 'NUL'
	endif

	" Zero pad hex values
	let nrformat = '0x%02x'

	let encoding = (&fenc == '' ? &enc : &fenc)

	if encoding == 'utf-8'
		" Zero pad with 4 zeroes in unicode files
		let nrformat = '0x%04x'
	endif

	" Get the character and the numeric value from the return value of :ascii
	" This matches the two first pieces of the return value, e.g.
	" "<F>  70" => char: 'F', nr: '70'
	let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

	" Format the numeric value
	let nr = printf(nrformat, nr)

	return "'". char ."' ". nr
endfunction "}}}
function! AirlineInit()
  let g:airline_section_y = airline#section#create(['charcode', ' | ', 'filesize', ' | ', 'ffenc', ' | ', 'sts:%{&sts}:sw:%{&sw}:ts:%{&ts}:tw:%{&tw}'])
endfunction
autocmd VimEnter * call AirlineInit()


" neocomplete
"
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


" neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>
      \ pumvisible() ? "\<C-n>" :
      \ neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'


" vim-rails
let g:rails_projections = {
      \ 'app/admin/*.rb': {'command': 'admin'},
      \ 'app/decorators/*_decorator.rb': {'command': 'decorator'},
      \ 'app/inputs/*_input.rb': {'command': 'input'},
      \ 'app/services/*_service.rb': {'command': 'service'},
      \ 'app/uploaders/*_uploader.rb': {
      \   'command': 'uploader',
      \   'template':
      \     'class %SUploader < CarrierWave::Uploader::Base\nend',
      \   'test': [
      \     'test/unit/%s_uploader_test.rb',
      \     'spec/models/%s_uploader_spec.rb'
      \   ],
      \   'keywords': 'process version'
      \ },
      \ 'app/workers/*_worker.rb': {'command': 'worker'},
      \ 'features/support/*.rb': {'command': 'support'},
      \ 'features/support/env.rb': {'command': 'support'},
      \ 'spec/factories/*.rb': {'command': 'factory'}
      \ }


" Rnavcommand decorator app/decorators      -glob=**/*  -suffix=_decorator.rb
" Rnavcommand presenter app/presenters      -glob=**/*  -suffix=_presenter.rb
" Rnavcommand coffee    app/coffeescripts   -glob=**/*  -suffix=.coffee
" Rnavcommand sass      app/stylesheets     -glob=**/*  -suffix=.sass
" Rnavcommand scss      app/stylesheets     -glob=**/*  -suffix=.scss
" Rnavcommand factory   spec/factories      -glob=*     -default=controller()

" Rnavcommand feature     features                  -glob=**/*    -suffix=.feature
" Rnavcommand steps       features/step_definitions -glob=**/*    -suffix=_steps.rb
" Rnavcommand support     features/support          -glob=*
" Rnavcommand specsupport spec/support              -glob=**/*


" vim-turbux
let g:turbux_command_prefix = 'spring'


" vim-go
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_fmt_command = "goimports"
let g:go_auto_sameids = 1

au FileType go nmap ,r <Plug>(go-run)
au FileType go nmap ,b <Plug>(go-build)
au FileType go nmap <Leader>tg <Plug>(go-test)
au FileType go nmap ,ct <Plug>(go-coverage-toggle)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')


" vim-markdown
let g:vim_markdown_fenced_languages = ['html', 'css', 'ruby', 'erb=eruby', 'python', 'bash=sh', 'yaml']
let g:vim_markdown_conceal = 0
let g:vim_markdown_toc_autofit = 1


" NERDTree
let g:nerdtree_tabs_open_on_gui_startup = 0


" vim-jsx
let g:jsx_ext_required = 0


" Syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" rust.vim
let g:rustfmt_autosave = 1


" vim-table-model
let g:table_mode_corner='|'


" UltiSnips
let g:UltiSnipsNoPythonWarning = 1
