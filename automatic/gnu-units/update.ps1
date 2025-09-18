import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://ftp.gnu.org/gnu/units/windows/'

function global:au_SearchReplace {
	@{
		'.\legal\VERIFICATION.txt' = @{
			"(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
			"(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL32)"
			"(?i)(\s+checksum32:).*"            = "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32 -keep
	Move-Item -Path $FileVersion.TempFile -Destination "tools\units-setup.exe"
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
	Invoke-WebRequest -Uri "$($Latest.URL32).sig" -OutFile "tools\units-setup.exe.sig"
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	# URL of the GNU FTP directory
	$url = "https://ftp.gnu.org/gnu/units/windows/"

	# Fetch the HTML content from the page
	$response = Invoke-WebRequest -Uri $url

	# Extract all the file links from the page
	$fileLinks = $response.Links | Where-Object { $_.href -match '\.exe$' }

	# Define a regex pattern to extract the version numbers
	$versionPattern = '(\d+\.\d+)'

	# Initialize variables to store the highest version and its URL
	$highestVersion = [Version]"0.0"
	$highestVersionUrl = ""

	# Iterate over each file link and compare versions
	foreach ($link in $fileLinks) {
		if ($link.href -match $versionPattern) {
			$version = [Version]$matches[1]

			# Compare the current version with the highest version found so far
			if ($version -gt $highestVersion) {
				$highestVersion = $version
				$highestVersionUrl = $url + $link.href
			}
		}
	}

	# Output the URL of the file with the highest version
	if ($highestVersionUrl) {
		$url = $highestVersionUrl
		$version = $highestVersion
}

	$Latest = @{ URL32 = $url; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
