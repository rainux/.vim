Rnavcommand decorator app/decorators      -glob=**/*  -suffix=_decorator.rb
Rnavcommand presenter app/presenters      -glob=**/*  -suffix=_presenter.rb
Rnavcommand coffee    app/coffeescripts   -glob=**/*  -suffix=.coffee
Rnavcommand sass      app/stylesheets     -glob=**/*  -suffix=.sass
Rnavcommand scss      app/stylesheets     -glob=**/*  -suffix=.scss
Rnavcommand factory   spec/factories      -glob=*     -default=controller()

Rnavcommand feature     features                  -glob=**/*    -suffix=.feature
Rnavcommand steps       features/step_definitions -glob=**/*    -suffix=_steps.rb
Rnavcommand support     features/support          -glob=*
Rnavcommand specsupport spec/support              -glob=**/*

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
