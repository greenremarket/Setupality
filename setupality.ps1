# Ensure PowerShell is running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Output "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    Break
}

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
winget install --id=Git.Git --exact --accept-source-agreements --accept-package-agreements # git
winget install --id=GitHub.GitHubDesktop --exact --accept-source-agreements --accept-package-agreements # github desktop
winget install --id=Valve.Steam --exact --accept-source-agreements --accept-package-agreements # steam
winget install --id=BraveSoftware.BraveBrowser --exact --accept-source-agreements --accept-package-agreements # brave
winget install --id=Spotify.Spotify --exact --accept-source-agreements --accept-package-agreements # spotify
winget install --id=Microsoft.VisualStudioCode --exact --accept-source-agreements --accept-package-agreements # visual studio code

# Install Python and Ruby
winget install --id=Python.Python --exact --accept-source-agreements --accept-package-agreements # python
winget install --id=RubyInstallerTeam.Ruby --exact --accept-source-agreements --accept-package-agreements # ruby
winget install --id=9PC3H3V7Q9CH --exact --accept-source-agreements --accept-package-agreements # rufus

# Install VS Code extensions
# You would need to list out all your extensions here
# Example: code --install-extension ms-python.python
