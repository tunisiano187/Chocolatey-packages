$global:au_Root = "$PSScriptRoot/../automatic"                           #Path to the AU packages

$nuspecs = Get-ChildItem -Path $global:au_Root -Filter *.nuspec -Recurse

foreach ($nuspec in $nuspecs) {
    [xml]$destspec = Get-Content $nuspec.FullName
    if(!($destspec.package.metadata.releaseNotes) -or ($destspec.package.metadata.releaseNotes -eq ""))
    {
        $FileContent = Get-Content $nuspec.FullName;
        $NewFileContent = @()
        for ($i = 0; $i -lt $FileContent.Length; $i++) {
            if ($FileContent[$i] -like "*\/metadata*") {
                $NewFileContent += '<releaseNotes>#### Package
                * Automatically built and uploaded by [tunisiano](https://chocolatey.org/profiles/tunisiano)</releaseNotes>'
            }
            $NewFileContent += $FileContent[$i].Replace('{{PackageName}}', $($destspec.package.metadata.title).Replace(' ', "-"))
        }
        $NewFileContent | Out-File $nuspec.FullName
    }
}