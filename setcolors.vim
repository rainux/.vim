" Change the color scheme from a list of color scheme names.
" Version 2010-09-12 from http://vim.wikia.com/wiki/VimTip341
" Press key:
"   F8                next scheme
"   Shift-F8          previous scheme
"   Alt-F8            random scheme
" Set the list of color schemes used by the above (default is 'all'):
"   :SetColors all              (all $VIMRUNTIME/colors/*.vim)
"   :SetColors blue slate ron   (these schemes)
"   :SetColors                  (display current scheme names)

" colorscheme names that we use to set color
let s:mycolors = [
      \ 'desert-warm-256',
      \ 'base16-gruvbox-dark-hard',
      \ 'base16-zenburn',
      \ 'base16-eighties',
      \ 'base16-railscasts',
      \ 'base16-ashes',
      \ 'base16-porple',
      \ 'base16-material-darker',
      \ 'base16-oceanicnext',
      \ 'base16-ia-dark',
      \ 'base16-onedark',
      \ 'base16-ia-light',
      \ 'base16-mexico-light',
      \ 'base16-github',
      \ 'base16-harmonic-light',
      \ 'base16-unikitty-light',
      \ 'base16-google-light',
      \ 'base16-one-light',
      \ 'base16-summerfruit-light',
      \ 'base16-tomorrow',
      \ 'base16-grayscale-light',
      \ 'base16-atlas',
      \ 'base16-bespin',
      \ 'base16-brewer',
      \ 'base16-bright',
      \ 'base16-chalk',
      \ 'base16-circus',
      \ 'base16-default-dark',
      \ 'base16-dracula',
      \ 'base16-helios',
      \ 'base16-horizon-dark',
      \ 'base16-materia',
      \ 'base16-paraiso',
      \ 'base16-seti',
      \ 'base16-snazzy',
      \ 'base16-solarflare',
      \ 'base16-spacemacs',
      \ 'base16-summerfruit-dark',
      \ 'base16-synth-midnight-dark',
      \ 'base16-woodland',
      \ 'base16-grayscale-dark',
      \ ]

" Set list of color scheme names that we will use, except
" argument 'now' actually changes the current color scheme.
function! s:SetColors(args)
  if len(a:args) == 0
    echo 'Current color scheme names:'
    let i = 0
    while i < len(s:mycolors)
      echo '  '.join(map(s:mycolors[i : i+4], 'printf("%-14s", v:val)'))
      let i += 5
    endwhile
  elseif a:args == 'all'
    let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
    let s:mycolors = uniq(sort(map(paths, 'fnamemodify(v:val, ":t:r")')))
    echo 'List of colors set from all installed color schemes'
  else
    let s:mycolors = split(a:args)
    echo 'List of colors set from argument (space-separated names)'
  endif
endfunction

command! -nargs=* SetColors call s:SetColors('<args>')

" Set next/previous/random (how = 1/-1/0) color from our list of colors.
" The 'random' index is actually set from the current time in seconds.
" Global (no 's:') so can easily call from command line.
function! NextColor(how)
  call s:NextColor(a:how, 1)
endfunction

" Helper function for NextColor(), allows echoing of the color name to be
" disabled.
function! s:NextColor(how, echo_color)
  if len(s:mycolors) == 0
    call s:SetColors('all')
  endif
  if exists('g:colors_name')
    let current = index(s:mycolors, g:colors_name)
  else
    let current = -1
  endif
  let missing = []
  let how = a:how
  for i in range(len(s:mycolors))
    if how == 0
      let current = localtime() % len(s:mycolors)
      let how = 1  " in case random color does not exist
    else
      let current += how
      if !(0 <= current && current < len(s:mycolors))
        let current = (how>0 ? 0 : len(s:mycolors)-1)
      endif
    endif
    try
      execute 'colorscheme '.s:mycolors[current]
      let g:CUR_COLOR_INDEX = current
      if exists(':AirlineTheme')
        execute 'AirlineTheme '.s:mycolors[current]
      endif
      break
    catch /E185:/
      call add(missing, s:mycolors[current])
    endtry
  endfor
  redraw
  if len(missing) > 0
    echo 'Error: colorscheme not found:' join(missing)
  endif
  if (a:echo_color)
    echo g:colors_name
  endif
endfunction

if !exists("g:CUR_COLOR_INDEX") || g:CUR_COLOR_INDEX < 0 || g:CUR_COLOR_INDEX >= len(s:mycolors)
  let g:CUR_COLOR_INDEX = 0
endif

execute 'colorscheme '.s:mycolors[g:CUR_COLOR_INDEX]

nnoremap <F8> :call NextColor(1)<CR>
nnoremap <S-F8> :call NextColor(-1)<CR>
nnoremap <A-F8> :call NextColor(0)<CR>
