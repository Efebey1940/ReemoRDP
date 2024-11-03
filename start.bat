@echo off
powershell.exe /command Start-Service -Name Reemo -ErrorAction Stop
start "" "%PROGRAMFILES%\Reemo\service\reemod.exe"
