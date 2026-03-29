$ErrorActionPreference = "Stop"

$projectRoot = (Get-Location).Path
$nextDir = Join-Path $projectRoot ".next"
$port = 3000

function Get-PortPids {
  $pids = @()

  try {
    $output = netstat -ano -p tcp | Select-String ":$port"

    foreach ($match in $output) {
      $line = $match.Line.Trim()

      if (-not $line) {
        continue
      }

      if ($line -notmatch "LISTENING" -and $line -notmatch "ESTABLISHED") {
        continue
      }

      $parts = $line -split "\s+"

      if ($parts.Length -lt 5) {
        continue
      }

      if ($parts[1] -like "*:$port") {
        $pids += $parts[-1]
      }
    }
  } catch {
    return @()
  }

  return $pids | Where-Object { $_ } | Select-Object -Unique
}

foreach ($processId in Get-PortPids) {
  try {
    taskkill /PID $processId /F | Out-Null
    Write-Output "Stopped process on port ${port}: $processId"
  } catch {
    Write-Output "Could not stop process $processId, continuing."
  }
}

if (Test-Path $nextDir) {
  Remove-Item -Recurse -Force $nextDir
  Write-Output "Cleared .next build output."
}

$launchCommand = "Set-Location '$projectRoot'; npm run dev 1> dev-server.out.log 2> dev-server.err.log"

Start-Process powershell -ArgumentList "-NoProfile", "-Command", $launchCommand -WindowStyle Hidden
Write-Output "Started fresh dev server in a new PowerShell window."
exit 0
