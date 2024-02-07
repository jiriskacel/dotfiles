#!/bin/bash
SCRIPT=$(basename $0)

if which pwsh >/dev/null 2>&1; then
    echo "⚡ $SCRIPT"

    echo "✨ Installing posh-git"
    pwsh -NoProfile -c 'Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force'
    echo "🔧 Patching posh-git"
    sed -e '/untrackedFilesOption/s/default/"Normal"/' -i ~/Documents/PowerShell/Modules/posh-git/*/GitUtils.ps1
    echo "🎀 posh-git"

    echo "✔  $SCRIPT"
fi
