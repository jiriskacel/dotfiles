Import-Module posh-git

$GitPromptSettings.DefaultPromptPrefix.Text = `
  (Write-Prompt $env:USERNAME -fore $([ConsoleColor]::DarkGray)) +
  (Write-Prompt '@' -fore $([ConsoleColor]::Gray)) +
  (Write-Prompt $env:COMPUTERNAME -fore $([ConsoleColor]::Green)) +
  (Write-Prompt ':' -fore $([ConsoleColor]::Gray))
$GitPromptSettings.DefaultPromptPath.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.DefaultPromptSuffix.ForegroundColor = [ConsoleColor]::White

$global:VcsPromptStatuses += {
  # special handling for yadm
  if ($PWD.Path -eq $env:USERPROFILE -and -not $env:GIT_DIR) {
    try {
      Push-Location "$env:USERPROFILE/.local/share/yadm/repo.git"
      Write-GitStatus (Get-GitStatus)
    } finally {
      Pop-Location
    }
  }
}
