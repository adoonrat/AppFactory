#Install-Module -Name IntuneWin32App
#Install-Module -Name Evergreen -force

# Retrieve access token required for accessing Microsoft Graph
# Delegated authentication (authorization code, device code flows) are currently supported
Connect-MSIntuneGraph -TenantID "amadeusgadlab.onmicrosoft.com"
Connect-MSIntuneGraph -TenantID "amadeusgadlab.onmicrosoft.com" -Verbose
Connect-MSIntuneGraph -TenantID "amadeusgadlab.onmicrosoft.com" -DeviceCode
Connect-MSIntuneGraph -TenantID "amadeusgadlab.onmicrosoft.com" -Refresh
Connect-MSIntuneGraph -TenantID "amadeusgadlab.onmicrosoft.com" -Interactive


# Access token available in global variable
$Global:AuthenticationHeader


#########

$Intune7zip = Get-IntuneWin32App -DisplayName "7-zip*" | Select-Object -Property displayName, displayVersion
$EvergreenApp = Get-EvergreenApp -Name "7Zip" | Where-Object { $PSItem.Architecture -eq "x64" -and $PSItem.Type -eq "msi" }

If($Intune7zip.displayVersion -ge $EvergreenApp.Version)
{Write-Host "7Zip package is up to date"}
 else
{
$NewVersion = $EvergreenApp.Version
$MsgBody = @{text = "New 7Zip Version $NewVersion released! "} | ConvertTo-Json
$myTeamsWebHook = "https://amadeusworkplace.webhook.office.com/webhookb2/873fa5dc-11af-488e-add3-9b219c93ab72@b3f4f7c2-72ce-4192-aba4-d6c7719b5766/IncomingWebhook/4573bbb443614a01bdb41019d57547b5/70135612-8975-4a92-8759-c18270790385"
Invoke-RestMethod -Method post -ContentType 'Application/Json' -Body $MsgBody -Uri $myTeamsWebHook

}