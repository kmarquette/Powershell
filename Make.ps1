﻿# Deploys modules to the local system
Write-Host "Copying .\Modules\KevMar to 'C:\Program Files\WindowsPowerShell\Modules\'" -ForegroundColor DarkGreen
Copy-Item .\Modules\KevMar 'C:\Program Files\WindowsPowerShell\Modules\' -Recurse -Force
Write-Host "Done" -ForegroundColor DarkGreen
