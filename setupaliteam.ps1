# Ensure PowerShell is running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Output "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    Break
}
# update help so Get-Help can provide help for any PowerShell instruction
 Update-Help
 
 Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
 
# Install PSWindowsUpdate
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Install-Module PSWindowsUpdate -Force -Confirm:$false

# Get updates
Get-WUInstall -MicrosoftUpdate -AcceptAll -AutoReboot | Out-Null

# Install PSReadLine
Install-Module -Name PSReadLine -Force -Confirm:$false

# Install winget# get latest download url
$URL = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
$URL = (Invoke-WebRequest -Uri $URL).Content | ConvertFrom-Json |
        Select-Object -ExpandProperty "assets" |
        Where-Object "browser_download_url" -Match '.msixbundle' |
        Select-Object -ExpandProperty "browser_download_url"

# download
Invoke-WebRequest -Uri $URL -OutFile "Setup.msix" -UseBasicParsing

# install
Add-AppxPackage -Path "Setup.msix"

# delete file
Remove-Item "Setup.msix"

# Install apps with winget

winget install --id=9MZ1SNWT0N5D --exact --accept-source-agreements --accept-package-agreements # Update powershell from 5.0 to latest

# Dev tools
winget install --id=vim.vim --exact # vim
winget install --id=Git.Git --exact # git
winget install --id=OpenJS.NodeJS --exact # Node JS
winget install --id=RubyInstallerTeam.RubyWithDevKit.3.2 --exact # ruby
winget install --id=9NRWMJP3717K --exact  --accept-source-agreements --accept-package-agreements # python
winget install --id=XP9KHM4BK9FZ7Q --exact --accept-source-agreements --accept-package-agreements # visual studio code

# system tools and utils
winget install Microsoft.PCManager --exact --accept-source-agreements --accept-package-agreements # Microsoft PC Manager (beta)
winget install --id=9PC3H3V7Q9CH --exact --accept-source-agreements --accept-package-agreements # rufus
winget install --id=XPDM17HK323C4X --exact --accept-source-agreements --accept-package-agreements # TeamViewer
winget install --id=XP89DCGQ3K6VLD --exact --accept-source-agreements --accept-package-agreements # Microsoft Power Toys
winget install --id=XP8K2L36VP0QMB --exact --accept-source-agreements --accept-package-agreements # KeePassXC
winget install --id=Notepad++.Notepad++ --exact # Notepad++

# hardware
winget install CPUID.CPU-Z
winget install --id=9P4PNDG7L782 --exact --accept-source-agreements --accept-package-agreements # hp pc hardware diagnostics window

# else
winget install --id=XP8C9QZMS2PC1T --exact  --accept-source-agreements --accept-package-agreements  # brave
