import-module au

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$url32 = 'http://www.1space.dk/executor/ExecutorSetup.exe'
	$version='1.0.0'
	$File = Join-Path $env:TEMP "ver.html"
	Invoke-WebRequest -Uri 'http://www.1space.dk/executor/vhistory.html' -OutFile $File -Proxy "http://115.79.39.96:80"
	$version = $(Get-Content $File | Where-Object {$_ -match "h3"})[0].split('v')[1].split(' ')[0].trim()
	Write-Output "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32