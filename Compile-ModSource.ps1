
Param(
    [switch]$Init
);

$Output = [Environment]::NewLine + "JAVA_HOME set to: ${Env:JAVA_HOME}" + [Environment]::NewLine
Write-Host $Output -ForegroundColor Green

If ($Init) {

    Set-Location ".\source\"
    Get-ChildItem -Directory | ForEach-Object {
        Write-Host "Initializing" $_
        Set-Location $_
        $InitProcess = Start-Process -PassThru -NoNewWindow .\gradlew setupDecompWorkspace
        $InitProcess.WaitForExit()
        $InitProcess = Start-Process -PassThru -NoNewWindow .\gradlew eclipse
        $InitProcess.WaitForExit()
        Set-Location ".."
        Write-Host "Complete Init for" $_
    }

    Set-Location ".."

    Write-Host "Finished Init" -ForegroundColor Green
}