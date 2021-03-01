function Test-Administrator
{
  $user = [Security.Principal.WindowsIdentity]::GetCurrent();
  (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

Set-PSReadLineKeyHandler -Chord ctrl+w -Function BackwardKillWord

Import-Module posh-git
$GitPromptSettings.DefaultPromptPrefix.Text = `
  $(Write-Prompt $env:USERNAME -fore $([ConsoleColor]::DarkGray)) +
  $(Write-Prompt '@' -fore $([ConsoleColor]::Gray)) +
  $(Write-Prompt $env:COMPUTERNAME -fore $([ConsoleColor]::Green)) +
  $(Write-Prompt ':' -fore $([ConsoleColor]::Gray))
$GitPromptSettings.DefaultPromptPath.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.DefaultPromptSuffix.ForegroundColor = If (Test-Administrator) { [ConsoleColor]::Red } Else { [ConsoleColor]::White }
