" ----------------------------------------------------------------------------
" Configurations for plugins
"

" coc.nvim  ............................................................. {{{1

let g:coc_global_extensions = [
      \ 'coc-emoji',
      \ 'coc-git',
      \ 'coc-json',
      \ 'coc-rls',
      \ 'coc-snippets',
      \ 'coc-solargraph',
      \ 'coc-syntax',
      \ 'coc-tabnine',
      \ 'coc-word',
      \ ]

function! s:CocConfig()
" Coc Core  ............................................................. {{{2
"
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>fo  <Plug>(coc-format-selected)
nmap <leader>fo  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" ....................................................................... }}}2

" Using CocList  ........................................................ {{{2
"
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" ....................................................................... }}}2

" coc-snippets  ......................................................... {{{2
"
" Show snippets
nnoremap <silent> <space>n  :<C-u>CocList snippets<cr>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
" ....................................................................... }}}2
endfunction

autocmd User CocNvimInit call s:CocConfig()
" ....................................................................... }}}1

" vim-chalk  ............................................................ {{{1
let g:chalk_char = "."
let g:chalk_edit = 0

" Files for which to add a space between the marker and the current text
au BufRead,BufNewFile *.vim let b:chalk_space_before = 1


vmap zf <Plug>Chalk          " Create fold at visual selection
nmap zf <Plug>Chalk          " Create fold at operator movement
nmap zF <Plug>ChalkRange     " Create fold for specified number of lines

nmap Zf <Plug>SingleChalk    " Create single (opening) fold marker
                             " at current level or specified count
nmap ZF <Plug>SingleChalkUp  " Create single (opening) fold marker
                             "  at next levelor specified count

nmap =z <Plug>ChalkUp        " Increment current fold level
nmap -z <Plug>ChalkDown      " Decrement current fold level
vmap =z <Plug>ChalkUp        " Increment levels in selection
vmap -z <Plug>ChalkDown      " Decrement levels in selection
" ....................................................................... }}}1

" vim-grepper  .......................................................... {{{1
let g:grepper       = {}
let g:grepper.dir   = 'repo,file'
let g:grepper.tools = ['git', 'rg', 'ag']
" ....................................................................... }}}1

" rust.vim  ............................................................. {{{1
let g:rustfmt_autosave = 1
" ....................................................................... }}}1

" vim-polyglot  ......................................................... {{{1
let g:polyglot_disabled = ['rust', 'go']
let g:vim_json_syntax_conceal = 1
" ....................................................................... }}}1

" EasyMotion  ........................................................... {{{1

let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

" You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and sometimes want to move cursor with
" EasyMotion.
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
        \ 'modules': [incsearch#config#easymotion#module({'overwin': 1})],
        \ 'keymap': {
        \   "\<CR>": '<Over>(easymotion)'
        \ },
        \ 'is_expr': 0
        \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
        \ 'converters': [incsearch#config#fuzzyword#converter()],
        \ 'modules': [incsearch#config#easymotion#module({'overwin': 1})],
        \ 'keymap': {"\<CR>": '<Over>(easymotion)'},
        \ 'is_expr': 0,
        \ 'is_stay': 0
        \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
" ....................................................................... }}}1

" std_c  ................................................................ {{{1
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
" ....................................................................... }}}1

" Vimux  ................................................................ {{{1
let g:VimuxRunnerType = 'window'

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>
" ....................................................................... }}}1

" rubycomplete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_rails_proactive = 1


" ruby syntax
let g:ruby_fold = 1
let g:ruby_minlines = 200
let g:ruby_operators = 1


" NERD Commenter  ....................................................... {{{1
let g:NERDDefaultNesting = 1
let g:NERDSpaceDelims = 1
" ....................................................................... }}}1


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


" Tagbar  ............................................................... {{{1
let g:tagbar_type_coffee = {
      \ 'ctagstype': 'CoffeeScript',
      \ 'kinds': [
      \   'c:class',
      \   'f:function',
      \   'v:variable',
      \ ],
      \ 'sort': 0
      \ }
" ....................................................................... }}}1


" Netrw
let g:netrw_home = expand('~/.vim/tmp')


" airline  .............................................................. {{{1
let g:airline#extensions#default#section_truncate_width = {
  \ 'y': 120
  \ }

function! GetFileSize() " ............................................... {{{2
  let bytes = getfsize(expand("%:p"))

  if bytes <= 0
    return ''
  endif

  if bytes < 1024
    return bytes . 'B'
  else
    return (bytes / 1024) . 'kB'
  endif
endfunction " ........................................................... }}}2

function! GetCharCode() " ............................................... {{{2
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
endfunction " ........................................................... }}}2

function! s:AirlineConfig()
  call airline#parts#define_function('filesize', 'GetFileSize')
  call airline#parts#define_function('charcode', 'GetCharCode')

  let g:airline_section_y = airline#section#create(
        \ ['charcode', ' | ', 'filesize', ' | ', 'ffenc', ' | ',
        \ 'sts:%{&sts}:sw:%{&sw}:ts:%{&ts}:tw:%{&tw}'])
endfunction

autocmd User AirlineAfterInit call s:AirlineConfig()
" ....................................................................... }}}1


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


" vim-go
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


" NERDTree-tabs  ........................................................ {{{1
let g:nerdtree_tabs_open_on_gui_startup = 0
" ....................................................................... }}}1

" vim-jsx
let g:jsx_ext_required = 0


" vim-table-model
let g:table_mode_corner='|'

" vim: set fdm=marker fdl=0:
