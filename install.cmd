@ECHO OFF

FOR %%I in (.gvimrc .vimrc) DO (
    IF EXIST %HOME%\%%I (
        ECHO Backing up %HOME%\%%I -^> %HOME%\%%I.original
        MOVE "%HOME%\%%I" "%HOME%\%%I.original" > NUL
    )
)

ECHO Install plugins...
vim -Ec "exec 'PlugInstall' | qa"
