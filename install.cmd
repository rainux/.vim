@ECHO OFF

CD %~dp0

echo Installing plugin bundles...
git submodule update --init

FOR %%I in (.gvimrc .vimrc) DO (
    IF EXIST %HOME%\%%I (
        ECHO Backing up %HOME%\%%I -^> %HOME%\%%I.original
        MOVE "%HOME%\%%I" "%HOME%\%%I.original" > NUL
    )
    ECHO Copying %%~fI.win -^> %HOME%\%%I
    COPY "%%~fI.win" %HOME%\%%I > NUL
)

ECHO Generating help tags for plugin bundles...
vim -Ec "exec 'BundleDocs' | q"
