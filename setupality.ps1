# Ensure PowerShell is running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Output "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
    Break
}
# update help so Get-Help can provide help for any PowerShell instruction
 Update-Help
 
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

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

# Dev tools
winget install --id=vim.vim --exact # vim
winget install --id=Git.Git --exact # git
winget install --id=GitHub.GitHubDesktop --exact # Github Desktop
winget install --id=OpenJS.NodeJS --exact # Node JS
winget install --id=RubyInstallerTeam.RubyWithDevKit.3.2 --exact # ruby
winget install --id=9NRWMJP3717K --exact  --accept-source-agreements --accept-package-agreements # python
winget install --id=XP9KHM4BK9FZ7Q --exact --accept-source-agreements --accept-package-agreements # visual studio code

# containers, VMs and devops tools
winget install --id=9PKR34TNCV07  --exact --accept-source-agreements --accept-package-agreements # Kali Linux
winget install --id=Docker.DockerDesktop --exact # Docker Desktop
winget install --id=Kubernetes.minikube --exact # minikube
winget install --id=Hashicorp.Terraform --exact # terraform
winget install --id=Kubernetes.kubectl --exact # kubectl

# system tools and utils
winget install Microsoft.PCManager --exact --accept-source-agreements --accept-package-agreements # Microsoft PC Manager (beta)
winget install --id=9PC3H3V7Q9CH --exact --accept-source-agreements --accept-package-agreements # rufus
winget install --id=9MZ1SNWT0N5D --exact --accept-source-agreements --accept-package-agreements # Update powershell from 5.0 to latest
winget install --id=XPDM17HK323C4X --exact --accept-source-agreements --accept-package-agreements # TeamViewer
winget install --id=XP89DCGQ3K6VLD --exact --accept-source-agreements --accept-package-agreements # Microsoft Power Toys
winget install --id=Notepad++.Notepad++ --exact # Notepad++

# gaming 
winget install --id=Valve.Steam --exact # steam
winget install --id=ElectronicArts.EADesktop --exact # EA Desktop

# hardware
winget install CPUID.CPU-Z

# else 
winget install --id=XP8C9QZMS2PC1T --exact  --accept-source-agreements --accept-package-agreements  # brave
winget install --id=9WZDNCRD29V9 --exact --accept-source-agreements --accept-package-agreements # Microsoft 365
winget install --id=9NCBCSZSJRSB --exact --accept-source-agreements --accept-package-agreements # spotify
winget install --id=9NBLGGH5L9XT --exact --accept-source-agreements --accept-package-agreements # instagram
winget install --id=9NBDXK71NK08 --exact --accept-source-agreements --accept-package-agreements # whatsapp beta
winget install --id=9WZDNCRF0083 --exact --accept-source-agreements --accept-package-agreements # messenger
winget install --id=9P4PNDG7L782 --exact --accept-source-agreements --accept-package-agreements # HP PC HARDWARE DIAGNOSTICS WINDOW


# Install PSWindowsUpdate and install updates + reboot
Install-Module PSWindowsUpdate -Force -Confirm:$false
Get-WindowsUpdate -AcceptAll -Install -AutoReboot
