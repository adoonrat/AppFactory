# Vars
[string]$Application = "$(& git branch --show-current)"

$dest = "Toolkit\Files"

if((Test-Path -Path $($dest)) -eq $false) { New-Item -ItemType Directory -Force -Path $dest | Out-Null }

#TODO Modify Architecture and Type if needed
$EvergreenApp = Get-EvergreenApp -Name $Application | Where-Object { $PSItem.Architecture -eq "x86" -and $PSItem.Type -eq "msi" }
$url = $EvergreenApp.URI
$FileName = $EvergreenApp.URI.Split("/")[$EvergreenApp.URI.Split("/").count-1]

Invoke-WebRequest -Uri $url -OutFile "$dest\$Filename"