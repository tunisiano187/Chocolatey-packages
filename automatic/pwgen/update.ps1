$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/'

function global:au_SearchReplace {
	@{
		 "$($Latest.PackageName).nuspec" = @{
			 "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
		 }
	 }
 }

function global:au_GetLatest {
	$choc=$(choco search pwgen.install | Where-Object {$_ -match "pwgen.install"})
	$version = $choc.Split(" ")[1]

	$Latest = @{ Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckUrl
