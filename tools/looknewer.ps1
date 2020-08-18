$source = Join-Path $(Get-Location) "Check/list.txt"
if((Test-Path $source)) {
    $search = (Get-Content $source | Select-Object -First 1).split(' ')[0]
    if(!(Test-Path "$(Get-location)/../automatic/$search")) {
        $winout = (winget.exe search $search)
        if($($winout[-1] -replace(' {2,}',' ')).split(' ')[-3] -ne "matching") {
            $($winout[-1] -replace(' {2,}',' ')).split(' ')[-3]
        } else {
            Write-host "$search not available on winget"
            Get-Content $source | Add-Content "Check/Todo.txt"
            get-content $source | Select-Object -Skip 1 | set-content "$source-temp"
            Move-Item "$source-temp" $source -Force
        }
    } else {
        Write-host "$search already maintained here"
        get-content $source | Select-Object -Skip 1 | set-content "$source-temp"
        Move-Item "$source-temp" $source -Force
    }
}