$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://www.videolan.org/vlc/skins2/vlc-skins.zip'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt" = @{
			"(url32+:).*"  			= "`${1} $($Latest.URL32)"
			"(checksum32+:).*" 		= "`${1} $($Latest.Checksum32)"
			"(checksumtype+:).*" 	= "`${1} $($Latest.ChecksumType32)"
			"(pagehash+:).*" 		= "`${1} $($Latest.PageHash)"
		}
	}
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileInfos = Get-FileVersion -url $releases -keep

	# Root cause of every "The system cannot find the file specified: tools\vlc-skins.zip"
	# verifier failure this package has ever had (confirmed via git history: no zip was EVER
	# committed for this package, going back to its creation) -- this function used to only
	# embed the freshly-downloaded file inside the "checksum changed" branch below, and without
	# $ErrorActionPreference = 'Stop' a failed/misnamed Move-Item was silently swallowed: AU still
	# committed a bumped VERIFICATION.txt with no zip ever actually present in the repo.
	# tools\chocolateyinstall.ps1 hardcodes the expected filename as "vlc-skins.zip", so use that
	# directly rather than trusting Get-FileVersion's $FileInfos.FileName -- for a plain,
	# non-SourceForge URL like this one it falls back to the URL's second-to-last path segment
	# ("skins2"), not the actual file name. Embed the file every run, unconditionally -- the
	# checksum/page-hash comparison further below only ever decides the *version string*, never
	# whether to place the file.
	Copy-Item -Path $FileInfos.TempFile -Destination "tools\vlc-skins.zip" -Force
	if (-not (Test-Path "tools\vlc-skins.zip") -or (Get-Item "tools\vlc-skins.zip").Length -eq 0) {
		throw "Failed to embed tools\vlc-skins.zip from $($FileInfos.TempFile)"
	}

	$fileContent = Get-Content -Path '.\legal\VERIFICATION.txt'
	$hash = ''
	if ($fileContent -match $FileInfos.checksum) {
		Write-Debug "Checksum $($FileInfos.checksum) match, won't be updating the version"
		$version = "0.0"
	} else {
		$response = Invoke-WebRequest -Uri $releases -Method Head -UseBasicParsing
		$FileDate = [datetime]::Parse($response.Headers["Last-Modified"])
		$version = "{0:0000}.{1:00}.{2:00}" -f $FileDate.Year, $FileDate.Month, $FileDate.Day
		$pageurl = 'https://www.videolan.org/vlc/skins.html?sort=date_mod'
		$page = (New-TemporaryFile).FullName
		Invoke-WebRequest -Uri $pageurl -OutFile $page
		$hash = (Get-FileHash $page).Hash
		if ($fileContent -match $hash) {
			Write-Debug "Checksum $hash match, won't be updating the version"
			$version = "0.0"
		}
	}

	$Latest = @{ URL32 = $releases; Version = $version; Checksum32 = $FileInfos.CHECKSUM; ChecksumType32 = $FileInfos.ChecksumType; PageHash = $hash }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
