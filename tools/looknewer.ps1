$ErrorActionPreference = 'Continue';
$source = Join-Path $PSScriptRoot "Check/list.txt"
Install-PackageProvider -name winget -Force

if((Test-Path $source)) {
    $search = (Get-Content $source | Select-Object -First 1).split(' ')[0]
    if(!(Test-Path "$($PSScriptRoot)/../automatic/$search")) {
        if($winout = ($(Find-Package $search).Version)) {
            Write-Host "$search v$($winout) available"
        } else {
            Write-host "$search not available on winget"
            Get-Content $source | Add-Content "Check/Todo.txt"
            Get-Content $source | Select-Object -Skip 1 | set-content "$source-temp"
            Move-Item "$source-temp" $source -Force
        }
    } else {
        Write-host "$search already maintained here"
        Get-Content $source | Select-Object -Skip 1 | set-content "$source-temp"
        Move-Item "$source-temp" $source -Force
    }
    git add $source
    git commit -m "[skip-ci] Package check $search"
}