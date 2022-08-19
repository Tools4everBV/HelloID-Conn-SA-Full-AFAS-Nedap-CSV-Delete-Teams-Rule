$afasOrgUnits = $form.teamRules.AFASOEid
$functionIds = $form.teamRules.FunctionId
$nedapTeamIds = $form.teamRules.NedapTeamIds

$path = $NedapOnsTeamsMappingPath

$CSV = import-csv $Path -Delimiter ";"

$filteredCSV = foreach ($line in $CSV) {
    if (-not(($line.'Department.ExternalId' -eq $afasOrgUnits) -and ($line.NedapTeamId -eq $nedapTeamIds) -and ($line.'Title.ExternalId' -eq $functionIds))) {
        $line 
    }
}

$filteredCSV | ConvertTo-Csv -NoTypeInformation -Delimiter ";" | ForEach-Object { $_.Replace('"', '') } | Out-File $Path    

$Log = @{
    Action            = "Undefined" # optional. ENUM (undefined = default) 
    System            = "NedapOns" # optional (free format text) 
    Message           = "Removed team rule for department [$afasOrgUnits] and optional title [$functionIds] to Nedap Team id(s) [$nedapTeamIds] from mapping file [$path]" # required (free format text) 
    IsError           = $false # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
    TargetDisplayName = "$path" # optional (free format text) 
    TargetIdentifier  = "" # optional (free format text) 
}
#send result back  
Write-Information -Tags "Audit" -MessageData $log 
