Set-PSReadLineKeyHandler -Chord ctrl+w -Function BackwardKillWord

Get-ChildItem "$PSScriptRoot\Scripts" -Filter *.ps1 | ForEach-Object {
  . $_
}

Start-Job {
  yadm fetch
} | Out-Null

function dev {
  $orion = git config --get maintenance.repo | Select-String -Raw orion
  if ($orion) {
    Import-Module $orion\tools\DevDevelopment.psm1 -Force
  }
}
