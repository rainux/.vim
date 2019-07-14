" Vim support file to detect file types
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2004 May 30

" Grub
au BufNewFile,BufRead */menu.lst,*/boot/grub/grub.conf	setf grub

" NSIS
au BufNewFile,BufRead *.nsi,*.nsh			setf nsis

" Pascal / Delphi
if (1==1) "change to "1==0" to use original syntax
  au BufNewFile,BufRead *.pas,*.PAS setf delphi
else
  au BufNewFile,BufRead *.pas,*.PAS setf pascal
endif
" Delphi project file
au BufNewFile,BufRead *.dpr,*.DPR setf delphi
" Delphi form file
au BufNewFile,BufRead *.dfm,*.DFM setf delphi
au BufNewFile,BufRead *.xfm,*.XFM setf delphi
" Delphi package file
au BufNewFile,BufRead *.dpk,*.DPK setf delphi
" Delphi .DOF file = INI file for MSDOS
au BufNewFile,BufRead *.dof,*.DOF setf dosini
au BufNewFile,BufRead *.kof,*.KOF setf dosini
au BufNewFile,BufRead *.dsk,*.DSK setf dosini
au BufNewFile,BufRead *.desk,*.DESK setf dosini
au BufNewFile,BufRead *.dti,*.DTI setf dosini
" Delphi .BPG = Makefile
au BufNewFile,BufRead *.bpg,*.BPG setf make|setlocal makeprg=make\ -f\ %

" Plane text file
au BufNewFile,BufRead *.txt setf text

" ActionScript
au BufNewFile,BufRead *.as setf actionscript

au FileType crontab setlocal nobackup nowritebackup

au FileType json syntax match Comment +\/\/.\+$+
