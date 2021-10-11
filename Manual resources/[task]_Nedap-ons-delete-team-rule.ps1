$Path = $NedapOnsTeamsMappingPath

$CSV = import-csv $Path -Delimiter ";"

$filteredCSV = foreach ($line in $CSV) {
    if (-not(($line.'Department.ExternalId' -eq $afasOrgUnits) -and ($line.NedapTeamId -eq $nedapTeamIds) -and ($line.'Title.ExternalId' -eq $functionIds))) {
        $line 
    }
}

$filteredCSV | ConvertTo-Csv -NoTypeInformation -Delimiter ";" | ForEach-Object { $_.Replace('"', '') } | Out-File $Path
