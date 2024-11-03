$installerUrl = "https://github.com/Efebey1940/ReemoRDP/releases/download/Reemo/Reemo.zip" 
$destinationPath = "C:\Users\runneradmin\Reemo"
$archivePath = "C:\reemo.zip"
$installerPath = "C:\reemo.zip"

Write-Host "Downloading Reemo..."
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

Write-Host "Extracting Reemo..."
Expand-Archive -Path $archivePath -DestinationPath $destinationPath -Force

Invoke-WebRequest -Uri https://github.com/Efebey1940/ReemoRDP/raw/refs/heads/main/start.bat -OutFile "C:\Users\runneradmin\Documents\start.bat"

Write-Host "Starting Reemo..."
try {
    Start-Process -FilePath "C:\Users\runneradmin\Documents\start.bat" -WindowStyle Hidden
    Write-Host "Reemo service started successfully."
} catch {
    Write-Host "Error: Failed to start Reemo."
    exit 1
}

