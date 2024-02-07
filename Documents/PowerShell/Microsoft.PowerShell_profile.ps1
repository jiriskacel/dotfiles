Set-PSReadLineKeyHandler -Chord ctrl+w -Function BackwardKillWord

Get-ChildItem "$PSScriptRoot\Scripts" -Filter *.ps1 | ForEach-Object {
  . $_
}

Start-Job {
  yadm fetch
} | Out-Null

function dev {
  Import-Module C:\source\orion\tools\DevDevelopment.psm1 -Force -ErrorAction SilentlyContinue
}
