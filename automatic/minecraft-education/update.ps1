import-module au

$release = 'https://aka.ms/downloadmee-desktopApp'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$File = Join-Path($(Split-Path $script:MyInvocation.MyCommand.Path)) "minecraft.exe"
	Invoke-WebRequest -Uri $release -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()

	$Latest = @{ URL32 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor 32