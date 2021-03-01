function Test-Administrator
{
  $user = [Security.Principal.WindowsIdentity]::GetCurrent();
  (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

Set-PSReadLineKeyHandler -Chord ctrl+w -Function BackwardKillWord

Import-Module posh-git
$GitPromptSettings.DefaultPromptPrefix.Text = "$env:USERNAME@$env:COMPUTERNAME$(Write-Prompt ':' -ForegroundColor White)"
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Green
$GitPromptSettings.DefaultPromptPath.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.DefaultPromptSuffix.ForegroundColor = If (Test-Administrator) { [ConsoleColor]::Red } Else { [ConsoleColor]::White }
