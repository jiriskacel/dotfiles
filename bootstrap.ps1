param(
    [string[]]$Class = @()
)

$YADM = "$env:USERPROFILE\bin\yadm"
$YADM_BAT = "$YADM.bat"

# install yadm
New-Item -ItemType Directory (Split-Path -Parent $YADM) -EA 0 | Out-Null
Invoke-WebRequest "https://github.com/TheLocehiliosan/yadm/raw/master/yadm" -OutFile $YADM
@'
@echo off

for %%I in ("git.exe") do for %%J in ("%%~$PATH:I") do set GitFolder=%%~dpJ..\
set ShellExe=%GitFolder%bin\sh.exe
set GIT_WORK_TREE=%USERPROFILE%

"%ShellExe%" %~dp0yadm %*
'@ | Out-File -Encoding ascii $YADM_BAT

# clone dotfiles
& $YADM_BAT clone "https://github.com/jiriskacel/dotfiles" -b "yadm/windows" --no-bootstrap
& $YADM_BAT checkout HEAD -- $HOME
$Class | ForEach-Object {
    & $YADM_BAT config --add local.class $_
}
& $YADM_BAT alt
& $YADM_BAT bootstrap
