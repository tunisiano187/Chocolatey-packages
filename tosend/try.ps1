Write-Verbose "Searching for packages to upload"

$list = get-childitem ./*.nupkg
foreach ($file in $list) {

    try {
        choco push $file.FullName --api-key $choco_api
        git rm $file.FullName
        git commit -m "remove $($file.FullName)"
        Remove-Item $file.FullName
        Write-Verbose "$($file.Name) sent"
    }
    catch {
        Write-Warning "$($file.Name) not sent"
    }
}