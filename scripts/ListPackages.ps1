$mdfile = "$PSScriptRoot/../Packages.md"
Set-Content $mdfile "| Downloads | Package Name |"
Add-Content $mdfile "|-----------|--------------|"
$paths = Get-ChildItem -Path "$PSScriptRoot/../automatic/" -Directory | Select-Object FullName
foreach ($path in $paths) {
    $package = $path.FullName.split('\')[-1]
    Add-Content $mdfile "| [![](http://img.shields.io/chocolatey/dt/$package.svg?color=green&label=$package)](https://chocolatey.org/packages/$package) | [$package]|"
}
git add $mdfile
git commit -m "[skip ci] List Packages"