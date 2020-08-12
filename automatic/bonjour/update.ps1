import-module au

$releases = 'https://support.apple.com/downloads/DL999/en_US/BonjourPSSetup.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$url32 = $releases
	$working_dir = "."
	$install_fname = 'bonjour.exe'
	Write-Output 'Download'
	$File = "$working_dir\$install_fname"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	Write-Output 'Get version'
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()
	Write-Output "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32