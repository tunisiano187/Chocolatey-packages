$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = "https://1111-releases.cloudflareclient.com/windows/Cloudflare_WARP_Release-x64.msi"

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL64
	$Latest.Checksum64 = $FileVersion.Checksum
	$Latest.ChecksumType64 = $FileVersion.checksumType
}

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	$url64=$releases

	# Get-Version's .Version is a typed [System.Version], whose default ToString() drops the
	# 4th component when it's unset (-1) but keeps it when it's explicitly 0 -- which component
	# count comes back depends on incidental FileVersionInfo details of whatever build the
	# Cloudflare redirect currently resolves to. That non-determinism is exactly what caused the
	# 409: the live chocolatey.org version ("2026.8.2115", 3 components) and a freshly recomputed
	# 4-component one ("2026.8.2115.0") are NuGet-equal, but AU's own exact-string feed check
	# can't tell, so it attempts a push the server then rejects as a duplicate. Force exactly 3
	# components every time (pad or truncate) so the computed version is always the same string.
	$rawVersion = (Get-Version(Get-RedirectedUrl($url64))).Version.ToString()
	$parts = $rawVersion.Split('.')
	while ($parts.Count -lt 3) { $parts += '0' }
	$version = ($parts[0..2]) -join '.'

	$Latest = @{ URL64 = $url64; Version = $version}

    return $Latest
}

update -ChecksumFor none
