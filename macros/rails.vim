autocmd FileType cucumber
      \ compiler cucumber |
      \ setl makeprg=cucumber\ \"%:p\"
autocmd FileType ruby
      \ if expand('%') =~# '_test\.rb$' |
      \   compiler rubyunit | setl makeprg=testrb\ \"%:p\" |
      \ elseif expand('%') =~# '_spec\.rb$' |
      \   compiler rspec | setl makeprg=rspec\ \"%:p\" |
      \ else |
      \   compiler ruby | setl makeprg=ruby\ -wc\ \"%:p\" |
      \ endif
autocmd User Bundler
      \ if &makeprg !~ 'bundle' | setl makeprg^=bundle\ exec\  | endif

" Highlight Ruby 1.8.x hash rocket
" This will prevent us to ever write it again
highlight ObsoleteHashRocket ctermbg=red guibg=red
au ColorScheme * highlight ObsoleteHashRocket guibg=red
au BufEnter * match ObsoleteHashRocket /\(:\<\w\+\s*\)\@<==>/
au InsertEnter * match ObsoleteHashRocket /\(\<:\w\+\s*\)\@<==>/
au InsertLeave * match ObsoleteHashRocket /\(\<:\w\+\s*\)\@<==>/
