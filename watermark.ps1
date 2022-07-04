try
{
  if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { 
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}

  $activationState = Get-ItemPropertyValue -path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\Activation' -Name 'Manual'

  Write-Host "Activationstate before: $activationState (0 = not activated, 1 = activated)"

  Set-Itemproperty -path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\Activation' -Name 'Manual' -value 1

  $activationState = Get-ItemPropertyValue -path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\Activation' -Name 'Manual'

  Write-Host "Activationstate after: $activationState (0 = not activated, 1 = activated)"

  Read-Host -Prompt "Press Enter to exit"
}
catch
{
  Write-Error $_.Exception.ToString()
      Read-Host -Prompt "The above error occurred. Press Enter to exit."
}

