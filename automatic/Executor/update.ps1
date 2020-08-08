import-module au

$url32 = 'http://www.1space.dk/executor/ExecutorSetup.exe'

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
	$File = Join-Path($(Split-Path $script:MyInvocation.MyCommand.Path)) "executor.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File

	$version=$([Regex]::Matches($(Invoke-WebRequest -Uri 'http://www.1space.dk/executor/vhistory.html').Content, $pattern)[0]).value.split('v')[1].split(' ')[0]
	Write-Output "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32