import-module au

$releases = 'https://www.citrix.com/downloads/sharefile/clients-and-plug-ins/sharefile-sync-for-windows.html'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      	= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')"	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	$urls=$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.rel -match '.msi'}).rel)
	$url32 = "https:$($urls[0].split('?')[0])"
	$url64 = "https:$($urls[1].split('?')[0])"

    $version = $url32.split('v')[-1].replace('.msi','')

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }

	return $Latest
}

update