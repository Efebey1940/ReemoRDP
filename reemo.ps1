$installerUrl = "https://github.com/Efebey1940/ReemoRDP/releases/download/Reemo/Reemo.zip" 
$destinationPath = "C:\Users\runneradmin\Reemo"
$archivePath = "C:\reemo.zip"
$installerPath = "C:\reemo.zip"

Write-Host "Downloading Reemo..."
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

Write-Host "Extracting Reemo..."
Expand-Archive -Path $archivePath -DestinationPath $destinationPath -Force

Write-Host "Starting Reemo..."
try {
    Start-Process -FilePath "C:\Users\runneradmin\Reemo\services\reemod.exe" -WindowStyle Hidden
    Write-Host "Reemo service restarted successfully."
} catch {
    Write-Host "Error: Failed to restart Reemo."
    exit 1
}

