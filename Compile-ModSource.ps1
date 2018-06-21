
Param(
    [switch]$Init,
    [string]$Build = "false"
);

$IgnoreDirectories = @(".metadata",".recommenders")
$IgnoreFiles = @("-sources", "-deobf", "-javadoc")

$Output = [Environment]::NewLine + "JAVA_HOME set to: ${Env:JAVA_HOME}" + [Environment]::NewLine
Write-Host $Output -ForegroundColor Green

If ($Init) {

    Set-Location ".\source\"
    Get-ChildItem -Directory | ForEach-Object {
        Write-Host "`nInitializing" $_
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

Else {
    Write-Host "Initializing process dictionary..."
    $Processes = New-Object 'System.Collections.Generic.Dictionary[int, System.Diagnostics.Process]'
    $Builds = New-Object 'System.Collections.Generic.Dictionary[int, string]'

    Write-Host "Entering .\source\ to begin builds..."
    Set-Location ".\source\"
    [int]$Counter = 1
    Get-ChildItem -Directory | ForEach-Object {

        If (!$IgnoreDirectories.Contains($_.Name)) {
            Write-Host "`nPreparing build" $_
            Set-Location $_
            $Processes.Add($Counter, (Start-Process -RedirectStandardOutput buildlog.txt -PassThru -NoNewWindow .\gradlew build))
            $Builds.Add($Counter, $_.Name)
            Set-Location ".."
        } Else {
            $Output = "`n" +  $_.Name + " is an ignored directory."
            Write-Host $Output
        }
        
        If ( ($Counter -ge 2) -And ($Counter % 2 -eq 0) ) {
            Write-Host "${Counter} is set, waiting for builds to complete"

            Write-Host "Awaiting" $Builds[$Counter]
            $Processes[$Counter].WaitForExit()
            $Path = $PSScriptRoot + "\source\" + $Builds[$Counter] + "\build\libs"
            Write-Host $Path
            Get-ChildItem -Path $Path | ForEach-Object {
                if ($_.Name.Contains($IgnoreFiles[0]) -Or $_.Name.Contains($IgnoreFiles[1]) -Or $_.Name.Contains($IgnoreFiles[2])) {
                    Write-Host "Ignored file" $_
                } Else {
                    Copy-Item -Path $_.FullName -Destination "${PSScriptRoot}\mods" -Recurse -Force
                }
            }

            Write-Host "Awaiting" $Builds[$Counter - 1]
            $Processes[$Counter - 1].WaitForExit()
            $Path = $PSScriptRoot + "\source\" + $Builds[$Counter - 1] + "\build\libs"
            Write-Host $Path
            Get-ChildItem -Path $Path | ForEach-Object {
                if ($_.Name.Contains($IgnoreFiles[0]) -Or $_.Name.Contains($IgnoreFiles[1]) -Or $_.Name.Contains($IgnoreFiles[2])) {
                    Write-Host "Ignored file" $_
                } Else {
                    Copy-Item -Path $_.FullName -Destination "${PSScriptRoot}\mods" -Recurse -Force
                }
            }
        }
        
        If (!$IgnoreDirectories.Contains($_.Name)) {
            $Counter += 1
        }

    }
    Write-Host "`nExiting .\source\, attempted to trigger all builds." -ForegroundColor Green

    $Processes.Values | ForEach-Object {
        $_.WaitForExit()
    }

    Write-Host "All build processes have resolved."

    Set-Location ".."
}