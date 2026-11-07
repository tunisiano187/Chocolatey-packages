import-module chocolatey-AU

$releases = "https://www.xiles.app/"

function global:au_SearchReplace {
	@{
		"$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
	}
}


function global:au_GetLatest {
	$File = "$env:TEMP/chocolatey/nexusfile.html"
	Invoke-WebRequest -Uri $releases -OutFile $File
	$pageContent = Get-Content $File
	$url = "https://s3.ap-northeast-2.amazonaws.com/net.xiles.public/download/$(($pageContent | Where-Object {$_ -match "file"} | Where-Object {$_ -match "_setup_"} | Where-Object {$_ -match "exe"}).split("'") | Where-Object {$_ -match "_setup_"} | Where-Object {$_ -notmatch "beta"} | Select-Object -First 1)"

	$version = Get-Version $url

	return @{ Version = $version }
}

update -ChecksumFor none
