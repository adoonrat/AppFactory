# Vars
. ".vscode\Global.ps1"

# intunewin
[string]$Uri = "https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/tree/master"
[string]$Exe = "IntuneWinAppUtil.exe"

# Source content prep tool
if (-not(Test-Path -Path "$env:ProgramData\$Exe")){
    Invoke-WebRequest -Uri "$Uri/$Exe" -OutFile "$env:ProgramData\$Exe"
}


# Execute content prep tool
Start-Process -FilePath "$env:ProgramData\$Exe" -ArgumentList "-c $Cache -s $Cache\Deploy-Application.exe -o C:\temp\ -q" -Wait

# Rename and prepare for upload
mkdir $Desktop\$Application
Move-Item -Path "C:\temp\Deploy-Application.intunewin" -Destination "$Desktop\$Application\$Application.intunewin" -Force -Verbose
explorer $Desktop