$ErrorActionPreference = 'Stop'
import-module au

$packageName = 'mailpv.install'

function global:au_SearchReplace {
    @{
         "$($Latest.PackageName).nuspec" = @{
             "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
         }
     }
 }

function global:au_GetLatest {
    $choc=$(choco search $packageName | Where-Object {$_ -match $packageName})
	$version = $choc.Split(" ")[1]

    Update-Metadata -key "copyright" -value "© $(Get-Date -Format "yyyy") NirSoft"

    return @{
        Version = $version
    }
}

update-package -ChecksumFor 32 -NoCheckUrl