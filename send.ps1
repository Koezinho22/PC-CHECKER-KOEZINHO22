param(
    [string]$hitsFile,
    [int]$suspCount,
    [string]$url,
    [string]$computerName,
    [string]$userName,
    [string]$dateStr
)

$color   = if ($suspCount -gt 0) { 16711680 } else { 65280 }
$status  = if ($suspCount -gt 0) { "SUSPICIOUS - $suspCount hit(s)" } else { "CLEAN" }

# Build the JSON payload as the form field "payload_json"
$embed = [ordered]@{
    title       = "KOEZY SCAN - $computerName / $userName"
    color       = $color
    description = "See attached file for full results."
    fields      = @(
        [ordered]@{ name = 'Result'; value = $status;      inline = $true  }
        [ordered]@{ name = 'Hits';   value = "$suspCount"; inline = $true  }
        [ordered]@{ name = 'Date';   value = $dateStr;     inline = $false }
    )
}
$payload = [ordered]@{
    username = 'Koezy Cheat Checker'
    embeds   = @($embed)
} | ConvertTo-Json -Depth 10 -Compress

# Upload as multipart with the .txt file attached
$boundary = [System.Guid]::NewGuid().ToString("N")
$fileName = "koezy_${computerName}.txt"
$fileBytes = [System.IO.File]::ReadAllBytes($hitsFile)
$fileContent = [System.Text.Encoding]::UTF8.GetString($fileBytes)

$body  = "--$boundary`r`n"
$body += "Content-Disposition: form-data; name=`"payload_json`"`r`n"
$body += "Content-Type: application/json`r`n`r`n"
$body += "$payload`r`n"
$body += "--$boundary`r`n"
$body += "Content-Disposition: form-data; name=`"file`"; filename=`"$fileName`"`r`n"
$body += "Content-Type: text/plain`r`n`r`n"
$body += "$fileContent`r`n"
$body += "--$boundary--"

$bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($body)

try {
    Invoke-RestMethod -Uri $url -Method Post -Body $bodyBytes -ContentType "multipart/form-data; boundary=$boundary" -ErrorAction Stop
    Write-Host '[OK] Scan results uploaded to Discord.'
} catch {
    Write-Host "[ERR] $_"
}
