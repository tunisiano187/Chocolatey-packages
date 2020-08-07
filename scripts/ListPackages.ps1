$mdfile = "$PSScriptRoot/../Packages.md"
Set-Content $mdfile "| Downloads | Package Name |"
Add-Content $mdfile "|-----------|--------------|"
$paths = Get-ChildItem -Path "$PSScriptRoot/../automatic/" -Directory | Select-Object FullName
foreach ($path in $paths) {
    $package = $path.FullName
    Add-Content $mdfile "| [![](http://img.shields.io/chocolatey/dt/$package.svg?color=green&label=$package)](https://chocolatey.org/packages/$package) | [$package]|"
}
git add $mdfile
git commit -m "List Packages"