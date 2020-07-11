import-module au

$release = "https://dexpot.de/index.php?id=thankyou"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_GetLatest {
	$File = Join-Path($(Split-Path $script:MyInvocation.MyCommand.Path)) "dexpot.exe"
	$url32 = "https://dexpot.de/$($((Invoke-WebRequest -Uri $release -UseBasicParsing).Links | Where-Object {$_ -match 'exe'}).outerHTML.split('"')[1])"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion
	if($version -eq "1.6.14") { $version="1.6.14.1" } #Solve previously rejected

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32