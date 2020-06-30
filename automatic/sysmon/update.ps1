import-module au

$releases = 'https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
		}
	}
}

function global:au_GetLatest {
	$url32 = (((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'sysmon.zip'}).href)[0]
	$File = "./sysmon.zip"
	Invoke-WebRequest -Uri $url32 -OutFile $ZipFile -UseBasicParsing
	Expand-Archive $ZipFile -DestinationPath .\sysmon
	$File = Get-ChildItem Sysmon.exe -Recurse
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File.FullName).FileVersion

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32