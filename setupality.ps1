# Ensure PowerShell is running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Output "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    Break
}

# Install the NVIDIA driver
Start-Process -FilePath ".\NVIDIADriver.exe" -ArgumentList "-silent" -NoNewWindow -Wait

# Install PSWindowsUpdate
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Install-Module PSWindowsUpdate -Force -Confirm:$false

# Get updates
Get-WUInstall -MicrosoftUpdate -AcceptAll -AutoReboot | Out-Null

# Install PSReadLine
Install-Module -Name PSReadLine -Force -Confirm:$false

# Install winget
Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v1.0.11692/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle -OutFile winget.appxbundle
Add-AppxPackage .\winget.appxbundle

# Install apps with winget
winget install --id=Git.Git --exact # git
winget install --id=GitHub.GitHubDesktop --exact # github desktop
winget install --id=Valve.Steam --exact # steam
winget install --id=BraveSoftware.BraveBrowser --exact # brave
winget install --id=Spotify.Spotify --exact # spotify
winget install --id=Microsoft.VisualStudioCode --exact # visual studio code

# Install Python and Ruby
winget install --id=Python.Python --exact # python
winget install --id=RubyInstallerTeam.Ruby --exact # ruby

# Install VS Code extensions
# You would need to list out all your extensions here
# Example: code --install-extension ms-python.python
