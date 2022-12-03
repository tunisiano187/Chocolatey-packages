$ErrorActionPreference = 'Stop'
import-module au
$padVersionUnder = '5.8.0.600'

$release = 'https://prod-rel-ffc-ccm.oobesaas.adobe.com/adobe-ffc-external/core/v1/wam/download?sapCode=KCCC&productName=Creative%20Cloud&os=win&environment=prod'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}


function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = Join-Path($(Split-Path $script:MyInvocation.MyCommand.Path)) "adobe-creative-cloud.exe"
	Invoke-WebRequest -Uri $release -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()
	$version="5.8.0.593"


	$Latest = @{ URL32 = $release; Version = Get-FixVersion $version -OnlyFixBelowVersion $padVersionUnder }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion