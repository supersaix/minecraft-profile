$ModsDirectory = ".\mods"
$ConfigDirectory = ".\config"

Write-Host $ModsDirectory -ForegroundColor Yellow
Get-ChildItem -Path $ModsDirectory | ForEach-Object {
    $Output = "`t\" + $_
    Write-Host $Output
}

Write-Host $ConfigDirectory -ForegroundColor Yellow
Get-ChildItem -Path $ConfigDirectory | ForEach-Object {
    $Output = "`t\" + $_
    Write-Host $Output
}

Copy-Item -Path $ConfigDirectory -Destination "${Env:APPDATA}\.minecraft\" -Recurse -Force
Copy-Item -Path $ModsDirectory -Destination "${Env:APPDATA}\.minecraft\" -Recurse -Force