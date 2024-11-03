$installerUrl = "https://example.com/reemo_installer.exe" 
$installerPath = "C:\reemo_installer.exe"
$configPath = "C:\Program Files\reemo\service\reemo.ini"
$reemoServiceName = "ReemoService"  
$authToken = "f5acdf09f0f5" 

Write-Host "Downloading Reemo installer..."
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

Write-Host "Installing Reemo..."
Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait

Write-Host "Configuring Reemo authentication token..."
if (Test-Path $configPath) {
    (Get-Content $configPath) -replace 'token=.*', "token=$authToken" | Set-Content $configPath
    Write-Host "Token configured successfully."
} else {
    Write-Host "Error: Could not find reemo.ini file at $configPath"
    exit 1
}


Write-Host "Restarting the Reemo service..."
try {
    Restart-Service -Name $reemoServiceName -ErrorAction Stop
    Write-Host "Reemo service restarted successfully."
} catch {
    Write-Host "Error: Failed to restart Reemo service. Please check the service name."
    exit 1
}


Write-Host "Cleaning up..."
Remove-Item -Path $installerPath -Force

Write-Host "Reemo setup completed successfully!"
