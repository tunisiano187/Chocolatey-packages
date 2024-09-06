$ErrorActionPreference = "SilentlyContinue"

Write-Host "Checking nuspec errors"
scripts/Find-NuspecError.ps1
git commit -am "Nuspec errors
[skip ci]"
Write-Host "updating packageSourceUrl"
scripts/Update-PackageSourceUrl.ps1 -GithubRepository "tunisiano187/Chocolatey-packages" -UseStopwatch
git commit -am "PackageSourceUrl
[skip ci]"
Write-Host "updating variables in ps1"
scripts/Update-Variables.ps1
git commit -am "ps1 vars
[skip ci]"
#Write-Host "updating IconUrl in nuspec"
#scripts/Update-IconUrl.ps1 -Quiet -GithubRepository "tunisiano187/Chocolatey-packages" -UseStopwatch
#git commit -am "Updating icons
#[skip ci]"
Write-Host "updating owners in nuspec"
import-module Wormies-AU-Helpers
$nuspec=Get-ChildItem ./*.nuspec -Recurse; foreach ($file in $nuspec) { Update-Metadata -key owners -value "tunisiano" -NuspecFile $file.FullName }
git commit -am "Updating owner
[skip ci]"
Write-Host "updating tunisiano187/choco-packages to chocolatey-packages"
$md=Get-ChildItem ./*.md -Recurse; foreach ($file in $md) { (((Get-Content $file.FullName) -replace 'https://cdn.jsdelivr.net/gh/tunisiano187/choco-packages@f986b7f5de3afc021180256752805698d4efbc38/icons/patreon.png','https://cdn.jsdelivr.net/gh/tunisiano187/Chocolatey-packages@d15c4e19c709e7148588d4523ffc6dd3cd3c7e5e/icons/patreon.png') -replace “tunisiano187/Choco-packages”, “tunisiano187/Chocolatey-packages”) -replace 'https://www.patreon.com/bePatron?u=39585820','https://www.patreon.com/bePatron?u=39585820' | Set-Content -Path $file.FullName }
git commit -am "Updating repository
[skip ci]"
Write-Host "Updating Packages.md"
scripts/ListPackages.ps1
git commit -am "List packages
[skip ci]"
git pull
git push origin master
exit 0