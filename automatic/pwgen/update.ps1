$ErrorActionPreference = 'Stop'
import-module au

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
	
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
