function Remove-NodeModules {
  [Alias("nuke")]
  [CmdletBinding()]
  param (
      [switch]$Apollo,
      [switch]$Fusion,
      [string[]]$Path
  )

  function FindModules {
    param ($Path)
    Write-Progress "Looking through" -Status $Path
    Get-ChildItem -Directory $Path | ForEach-Object {
      if ($_.Name -eq "node_modules") { return $_ }
      if ($_.Name -eq "bin") { return }
      if ($_.Name -eq "packages" -and (Test-Path "$($_.FullName)\..\paket.dependencies")) { return }
      FindModules $_
    }
  }
  Write-Progress "Looking through" -Status "Done" -Completed

  function NukeModules {
    param ($Path)
    Write-Host "removing $Path"
    Start-Job { param($dir); cmd /c "rmdir /s/q $dir"; } -ArgumentList $Path
  }

  function NukeGit {
    param ($Path)
    Write-Host "cleaning $Path"
    Start-Job { param($dir); cd $dir; git clean -qfdx . -e '*.sln' -e '*.code-workspace' -e '*.TestDeployment.config.json' } -ArgumentList $Path
  }

  function WaitJobs {
    param ($Task, $jobs)
    while (($jobs | ? State -eq "Running").Count -gt 0) {
      Wait-Job $jobs -any | Receive-Job
      $running = $jobs | ? State -eq "Running"
      $percentage = [int](100.0 * (1 - $running.Count / $jobs.Count))
      Write-Progress $Task -Status "$percentage% removed | $($running.Count) remaining" -PercentComplete $percentage
    }
    Write-Progress $Task -Status "Done" -Completed
  }

  $paths = @()
  try {
    pushd-oo Frontend

    if ($Apollo) { $paths += "apollo" }
    if ($Fusion) { $paths += "fusion" }
    $jobs = $paths | % { FindModules $_ } | % { NukeModules $_ }
    WaitJobs -Task "Nuking" $jobs

    if ($Path) { $paths += (Resolve-Path $Path).Path }
    $jobs = $paths | % { NukeGit $_ }
    WaitJobs -Task "Cleaning" $jobs

  } finally {
    popd-oo
  }
}
