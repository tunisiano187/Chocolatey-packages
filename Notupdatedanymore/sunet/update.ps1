import-module au

$release = 'https://boinc-client.oss-accelerate.aliyuncs.com/SUNET%20Setup.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_GetLatest {
	$url32 = $release

	$File = './sunet.exe'

	Write-Output "Downloading"
	Invoke-WebRequest -Uri $url32 -OutFile $File

	Write-Output "Installation"
	. $File /S

	$sunet=$(../../tools/Get-InstalledApps.ps1 -ComputerName $env:COMPUTERNAME -NameRegex 'sunet')
    while($sunet.count -eq 0)
    {
        $sunet=$(../../tools/Get-InstalledApps.ps1 -ComputerName $env:COMPUTERNAME -NameRegex 'sunet')
    }
	$version=$sunet.DisplayVersion
	if($version -eq "0.0.0") {
		$versiondate = Get-Date $([Net.HttpWebRequest]::Create($url32).GetResponse().LastModified) -Format "yyyyMMdd"
		$version = "0.0.0.$versiondate"
	}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32