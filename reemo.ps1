# Define variables
$installerUrl = "https://download.reemo.io/reemo.setup.x64.exe"  # Replace with the actual download URL for Reemo installer
$installerPath = "C:\reemo_installer.exe"
$configPath = "C:\Program Files\reemo\service\reemo.ini"
$reemoServiceName = "ReemoService"  # Replace with actual service name if different
$authToken = "f5acdf09f0f5"  # Replace with your authentication token if necessary

# Step 1: Download the Reemo installer
Write-Host "Downloading Reemo installer..."
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

# Step 2: Install Reemo silently
Write-Host "Installing Reemo..."
Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait

# Step 3: Configure the reemo.ini file with the authentication token
Write-Host "Configuring Reemo authentication token..."
if (Test-Path $configPath) {
    (Get-Content $configPath) -replace 'token=.*', "token=$authToken" | Set-Content $configPath
