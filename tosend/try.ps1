Write-Verbose "Searching for packages to upload"

$list = get-childitem ./*.nupkg -Recurse
foreach ($file in $list) {
    if(choco push $file.FullName --api-key $choco_api) {
        git checkout -B master
        git rm $file.FullName
        git commit -m "remove $($file.FullName)"
        Write-Verbose "$($file.Name) sent"
        git push --follow-tags origin master
    }
    else {
        Write-Warning "$($file.Name) not sent"
    }
}