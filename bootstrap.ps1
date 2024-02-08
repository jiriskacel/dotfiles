param(
    [string[]]$Class = @()
)

$YADM = "$env:USERPROFILE\bin\yadm"
$YADM_BAT = "$YADM.bat"

# install yadm
New-Item -ItemType Directory (Split-Path -Parent $YADM) -EA 0 | Out-Null
Invoke-WebRequest "https://github.com/TheLocehiliosan/yadm/raw/master/yadm" -OutFile $YADM
Invoke-WebRequest "https://github.com/jiriskacel/dotfiles/raw/yadm/windows/bin/yadm.bat" -OutFile $YADM_BAT

# clone dotfiles
& $YADM_BAT clone "https://github.com/jiriskacel/dotfiles" -b "yadm/windows" --no-bootstrap
& $YADM_BAT checkout HEAD -- $HOME
$Class | ForEach-Object {
    & $YADM_BAT config --add local.class $_
}
& $YADM_BAT alt
& $YADM_BAT bootstrap
