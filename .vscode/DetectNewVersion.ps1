#Install-Module -Name IntuneWin32App
#Install-Module -Name Evergreen -force

# Retrieve access token required for accessing Microsoft Graph
# Delegated authentication (authorization code, device code flows) are currently supported
Connect-MSIntuneGraph -TenantID "amadeusgadlab.onmicrosoft.com"
#Connect-MSIntuneGraph -TenantID "amadeusgadlab.onmicrosoft.com" -Verbose
#Connect-MSIntuneGraph -TenantID "amadeusgadlab.onmicrosoft.com" -DeviceCode
#Connect-MSIntuneGraph -TenantID "amadeusgadlab.onmicrosoft.com" -Refresh
#Connect-MSIntuneGraph -TenantID "amadeusgadlab.onmicrosoft.com" -Interactive


# Access token available in global variable
$Global:AuthenticationHeader


#########

# Vars
. ".vscode\Global.ps1"

$Intune7zip = Get-IntuneWin32App -DisplayName "7-zip*" | Select-Object -Property displayName, displayVersion
$EvergreenApp = Get-EvergreenApp -Name "$Application" | Where-Object { $PSItem.Architecture -eq "x64" -and $PSItem.Type -eq "msi" }

If($Intune7zip.displayVersion -ge $EvergreenApp.Version)
{Write-Host "$Application package is up to date"}
 else
{
$NewVersion = $EvergreenApp.Version
$MsgBody = @{text = "New $Application Version $NewVersion released! "} | ConvertTo-Json

$EnHook =  Get-Content .\.vscode\Hook.txt
$DeHook = $EnHook | ConvertTo-SecureString
$Code = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($DeHook))
$Hook = Invoke-Expression $Code

Invoke-RestMethod -Method post -ContentType 'Application/Json' -Body $MsgBody -Uri $Hook

}