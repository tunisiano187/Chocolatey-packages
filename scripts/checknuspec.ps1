$global:au_Root = "$PSScriptRoot/../automatic"                           #Path to the AU packages

$nuspecs = Get-ChildItem -Path $global:au_Root -Filter *.nuspec -Recurse

foreach ($nuspec in $nuspecs) {
    [xml]$destspec = Get-Content $nuspec.FullName
    if(!($destspec.package.metadata.releaseNotes))
    {
        $FileContent = Get-Content $nuspec.FullName;
        $NewFileContent = @()
        for ($i = 0; $i -lt $FileContent.Length; $i++) {
            if ($FileContent[$i] -like "*\/metadata*") {
                $NewFileContent += "#### Package
                * Automatically built and uploaded by [tunisiano](https://chocolatey.org/profiles/tunisiano)"
            }
            $NewFileContent += $FileContent[$i].Replace('{{PackageName}}', $($destspec.package.metadata.title).Replace(' ', "-"))
        }
        $NewFileContent | Out-File $($nuspec.FullName)
    } elseif ($destspec.package.metadata.releaseNotes -eq "") {
        $destspec.package.metadata.releaseNotes = "#### Package
* Automatically built and uploaded by [tunisiano](https://chocolatey.org/profiles/tunisiano)"
        $destspec.Save($nuspec.FullName)
    }
}