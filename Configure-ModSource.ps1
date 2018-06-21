Param(
    [switch]$Debug
);

If ($Debug) {
    $DebugPreference = "Continue"
}

Function Parse-Replace([string]$File, [string]$Key, [string]$Value) {
    $Content = Get-Content $File
    $Content = $Content -Replace "${Key}=.*", "${Key}=${Value}"
    Write-Host "Configured ${File}:`n`t'${Key}' for new value '${Value}'."
    $Content | Out-File -FilePath $File -Force
}

Function Parse-ReplaceOccurence([string]$File, [string]$Key, [int]$Occurence, [string]$Value) {
    $Content = Get-Content $File -Raw

    $Occurences = [Regex]::Matches($Content, "${Key}=.*")
    $Position = $Occurences[$Occurence].Index
    $Length = $Occurences[$Occurence].Length

    $Content = $Content -Replace $Content.Substring($Position, $Length), "${Key}=${Value}"

    Write-Host "Configured ${File}:`n`t'${Key}' for new value '${Value}'."
    $Content | Out-File -FilePath $File -Force
}

Function Config-RoguelikeSpawnProb([string]$Value) {
    If ($Value -eq 'VeryHigh') { return '7' }
    If ($Value -eq 'High') { return '9' }
    If ($Value -eq 'Normal') { return '8' }
    If ($Value -eq 'Low') { return '12' }
    Else { return '18' }
}

Write-Host "Loading the SuperSaix.config file..."

If (Test-Path ".\SuperSaix.config") {
    $Config = Get-Content ".\SuperSaix.config"
    Write-Host "Found SuperSaix.config!" -ForegroundColor Green
} Else {
    Return 1
}

Write-Host "Parsing the configuration..."

# Parse the config content, removing the comments
$Config = $Config | ForEach-Object { $_ -Replace '\s*#.*' } | Where-Object { $_ }

$Headings = @()

$Config | ForEach-Object {
    If ($_.StartsWith("[")) {
        $Headings += $_
    }
}

If ($Headings[0] -eq $Null) {
    Write-Error "Failed to find any configurations (for example, [WorldGeneration]) specified"
    Return 1
}

Write-Host "Found configurations:"
Write-Host "`t"$Headings

Write-Debug "Initializing configuration dictionaries"
$Headings | ForEach-Object -Begin { $MasterConfiguration = New-Object 'system.collections.generic.dictionary[string,hashtable]' } -Process {
    $MasterConfiguration.Add($_, [ordered]@{} )
}
Write-Debug "Success!"

# Parse the config content into a hash table
Write-Debug "Reading configuration for configuration values..."
$Header = ""
$Config | ForEach-Object {

    $Values = [regex]::split($_,'=');

    If ($Values[0].StartsWith("[")) {
        $Header = $Values[0]
        Write-Debug "Found ${Header}!"
    } Elseif (($Values[0].CompareTo("") -ne 0)) {
        $DebugOutput = "Writing " + $Values[0] + " to the ${Header} dictionary"
        Write-Debug $DebugOutput
        $MasterConfiguration[$Header].Add($Values[0], $Values[1])
    }
}

# Output the config table to the console for troubleshooting
If ($Debug) {
    $MasterConfiguration.Keys.ForEach({
        "$_ $($MasterConfiguration.$_ | Format-Table | Out-String)"
    }) -Join "`n"
}

#Configure the target config directories
$ModConfigDirectory = "./config"
$RoguelikeConfig = "${ModConfigDirectory}/roguelike_dungeons/roguelike.cfg"
$FamiliarFaunaConfig = "${ModConfigDirectory}/familiarfauna/config.cfg"
$CaveRootConfig = "${ModConfigDirectory}/caveroot.cfg"
$MineralogyConfig = "${ModConfigDirectory}/mineralogy.cfg"
$NaturaConfig = "${ModConfigDirectory}/natura.cfg"
$PrimitiveMobsConfig = "${ModConfigDirectory}/primitivemobs.cfg"

#Begin execution of Parse-Replace
$RoguelikeDungeonSpawnProb = Config-RoguelikeSpawnProb($MasterConfiguration["[Roguelike]"].DungeonSpawnProb)
Parse-Replace $RoguelikeConfig 'spawnFrequency' $RoguelikeDungeonSpawnProb 
Parse-Replace $RoguelikeConfig 'generous' $MasterConfiguration["[Roguelike]"].DungeonGenerous
Parse-Replace $RoguelikeConfig 'levelScatter' $MasterConfiguration["[Roguelike]"].DungeonLevelScatter
Parse-Replace $RoguelikeConfig 'levelRange' $MasterConfiguration["[Roguelike]"].DungeonLevelRange
Parse-Replace $RoguelikeConfig 'levelMaxRooms' $MasterConfiguration["[Roguelike]"].DungeonMaximumRooms
Parse-Replace $RoguelikeConfig 'looting' $MasterConfiguration["[Roguelike]"].DungeonLooting

Parse-ReplaceOccurence $CaveRootConfig 'spawnProb' 0 $MasterConfiguration["[WorldGeneration]"].CaveRootSpawnProb
Parse-ReplaceOccurence $CaveRootConfig 'spawnProb' 1 $MasterConfiguration["[WorldGeneration]"].DriedRootSpawnProb
Parse-ReplaceOccurence $CaveRootConfig 'spawnProb' 2 $MasterConfiguration["[WorldGeneration]"].TorchFungiSpawnProb

Parse-Replace $NaturaConfig '"Drop barley seeds from grass"' $MasterConfiguration["[Natura]"].GrassContainsBarleySeeds
Parse-Replace $NaturaConfig '"Drop cotton seeds from grass"' $MasterConfiguration["[Natura]"].GrassContainsBarleySeeds