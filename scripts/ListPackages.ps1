$ErrorActionPreference = 'Continue';
$mdfile = "$PSScriptRoot/../Packages.md"
Set-Content $mdfile "| Downloads | Package Name and version | Repology |"
Add-Content $mdfile "|-----------:|--------------|--------------|"
$paths = Get-ChildItem -Path "$PSScriptRoot/../automatic/" -Directory | Select-Object FullName
foreach ($path in $paths) {
    $package = $path.FullName.split('\')[-1]
    Add-Content $mdfile "| [![](http://img.shields.io/chocolatey/dt/$package.svg)](https://chocolatey.org/packages/$package) | [![](https://img.shields.io/chocolatey/v/$($package)?color=green&label=$package)](https://github.com/tunisiano187/Chocolatey-packages/tree/master/automatic/$package)|[![Chocolatey package](https://repology.org/badge/version-for-repo/chocolatey/$package.svg)](https://repology.org/project/$package/versions)|"
}
git add $mdfile
git commit -m "[skip ci] List Packages" | git push