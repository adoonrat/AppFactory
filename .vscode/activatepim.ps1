#Install-Module -Name DCToolbox -RequiredVersion 1.0.18
#Install-Module -Name AzureADPreview -AllowClobber
#Install-Package msal.ps -Force

Connect-AzureAD 
Enable-DCAzureADPIMRole