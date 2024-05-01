Write-host "Testing has started..." -ForegroundColor Cyan
#TODO Modify path to execute the installer
Start-Process -FilePath "C:\Users\WDAGUtilityAccount\Desktop\7Zip\Deploy-Application.exe" -Wait
Write-host "Installation completed" -ForegroundColor DarkGreen
Write-host "you have 60 seconds to verify the installation before it is automatically uninstalled" -ForegroundColor Cyan

$Seconds = 60
$EndTime = [datetime]::UtcNow.AddSeconds($Seconds)

while (($TimeRemaining = ($EndTime - [datetime]::UtcNow)) -gt 0) {
  Write-Progress -Activity 'Waiting for...' -Status testing -SecondsRemaining $TimeRemaining.TotalSeconds
  Start-Sleep 1
}
#TODO Modify path to execute the installer

Start-Process -FilePath "C:\Users\WDAGUtilityAccount\Desktop\7Zip\Deploy-Application.exe" -ArgumentList "Uninstall" -Wait
Write-host "test completed" -ForegroundColor DarkGreen
Write-host "You can close sandbox now!" -ForegroundColor Cyan
Read-Host -Prompt "Press any key to continue..."