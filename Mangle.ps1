function GetRandomString {
    return -join ((97..122) | Get-Random -Count 16 | % {[char]$_})
}

$seatbeltRand = GetRandomString

Get-ChildItem $Env:BUILD_SOURCESDIRECTORY -Filter "*.cs" -recurse |
    Foreach-Object {
        $c = ($_ | Get-Content)
        $c = $c -replace 'Seatbelt',"$seatbeltRand"
        $c = $c -replace 'ShowLogo();',""
        [IO.File]::WriteAllText($_.FullName, ($c -join "`r`n"))
    }
