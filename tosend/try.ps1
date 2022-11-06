Write-Verbose "Searching for packages to upload"

$list = get-childitem ./*.nupkg -Recurse
foreach ($file in $list) {
    $pushed = $(choco push $file.FullName --api-key $choco_api --failstderr)
    if($pushed -like "*Failed to process request*") {
        Write-Warning "$($file.Name) not sent"
    }
    else {
        git checkout -B master
        git pull
        git rm $file.FullName
        git commit -m "remove $($file.Name)"
        Write-Verbose "$($file.Name) sent"
        git push --follow-tags origin master
    }
}