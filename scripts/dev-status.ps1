$ErrorActionPreference = "Stop"

$port = 3000

function Get-PortRows {
  $rows = @()

  try {
    $output = netstat -ano -p tcp | Select-String ":$port"

    foreach ($match in $output) {
      $line = $match.Line.Trim()

      if (-not $line) {
        continue
      }

      $parts = $line -split "\s+"

      if ($parts.Length -lt 5) {
        continue
      }

      $row = [PSCustomObject]@{
        Protocol = $parts[0]
        LocalAddress = $parts[1]
        RemoteAddress = $parts[2]
        State = $parts[3]
        Pid = $parts[4]
      }

      if ($row.LocalAddress -like "*:$port") {
        $rows += $row
      }
    }
  } catch {
    return @()
  }

  return $rows
}

function Test-LocalHttp {
  try {
    $response = Invoke-WebRequest -Uri "http://127.0.0.1:$port/" -TimeoutSec 3 -UseBasicParsing
    return [PSCustomObject]@{
      Ok = $true
      StatusCode = [int]$response.StatusCode
      Message = ""
    }
  } catch {
    $statusCode = $null

    if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
      $statusCode = [int]$_.Exception.Response.StatusCode
    }

    if ($null -ne $statusCode) {
      return [PSCustomObject]@{
        Ok = $true
        StatusCode = $statusCode
        Message = ""
      }
    }

    return [PSCustomObject]@{
      Ok = $false
      StatusCode = $null
      Message = $_.Exception.Message
    }
  }
}

$portRows = Get-PortRows
$listeningRows = @($portRows | Where-Object { $_.State -eq "LISTENING" })
$httpResult = Test-LocalHttp

if ($httpResult.Ok) {
  Write-Output "Healthy: http://localhost:$port/ returned $($httpResult.StatusCode)."

  if ($listeningRows.Count -gt 0) {
    $pids = $listeningRows | ForEach-Object { $_.Pid } | Select-Object -Unique
    Write-Output "Listening PID(s): $($pids -join ', ')"
  }

  exit 0
}

if ($listeningRows.Count -gt 0) {
  $pids = $listeningRows | ForEach-Object { $_.Pid } | Select-Object -Unique
  Write-Output "Stale server suspected: port $port is listening, but HTTP failed."
  Write-Output "Listening PID(s): $($pids -join ', ')"
  Write-Output "HTTP error: $($httpResult.Message)"
  Write-Output "Recommended fix: npm run dev:reset"
  exit 1
}

if ($portRows.Count -gt 0) {
  Write-Output "Port $port has TCP activity but no listener is healthy yet."
  Write-Output "HTTP error: $($httpResult.Message)"
  Write-Output "Recommended fix: wait a few seconds, then rerun this check."
  exit 1
}

Write-Output "No dev server detected on port $port."
Write-Output "Recommended fix: npm run dev or npm run dev:reset"
exit 1
