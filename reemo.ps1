$installerUrl = "https://download.reemo.io/reemo.setup.x64.exe" 
$installerPath = "C:\reemo_installer.exe"
$configPath = "${Env:PROGRAMFILES}\Reemo\service\reemo.ini"
$authToken = "f5acdf09f0f5" 

Write-Host "Downloading Reemo installer..."
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

Write-Host "Installing Reemo..."
Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait

Invoke-WebRequest -Uri https://github.com/Efebey1940/ReemoRDP/raw/refs/heads/main/reemo.ini -OutFile ${Env:PROGRAMFILES}\Reemo\service\reemo.ini

cmd /c taskkill /f /im reemod.exe

Write-Host "Configuring Reemo authentication token..."
if (Test-Path $configPath) {
    (Get-Content $configPath) -replace 'token=.*', "token=$authToken" | Set-Content $configPath
    Write-Host "Token configured successfully."
} else {
    Write-Host "Error: Could not find reemo.ini file at $configPath"
    exit 1
}

Invoke-WebRequest -Uri https://github.com/Efebey1940/ReemoRDP/raw/refs/heads/main/start.bat -OutFile "C:\Users\runneradmin\start.bat"

Write-Host "Starting Reemo..."
try {
    start "" "C:\Users\runneradmin\start.bat"
    Write-Host "Reemo service restarted successfully."
} catch {
    Write-Host "Error: Failed to restart Reemo."
    exit 1
}

