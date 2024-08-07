$page = Invoke-WebRequest -Uri "https://community.chocolatey.org/profiles/needs_new_maintainer"
foreach ($packages in $page.Links | Where-Object {$_.href -match "packages/"} | Where-Object {$_.outerHTML -notmatch "Deprecated"} | Where-Object {$_.outerHTML -notmatch "Retired"}) {
    Write-Output "$($packages.href.split('/')[-1]) 0.0 - New maintainer" | Out-file -FilePath '.\New_maintainer.txt' -Append
}
