import-module chocolatey-AU

$releases = 'https://support.logi.com/api/v2/help_center/en-us/articles.json?label_names=webcontent=productdownload,websoftware=ebfd2163-8e0b-11e9-9708-d17ec0ebcb31&page[size]=1'

function global:au_SearchReplace {
   @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $json = Invoke-RestMethod -Method Get -Uri $releases
    $var = $json.articles[0].body
    $regex = 'href="([^"]+\.exe)"'
    $match = $var | Select-String -Pattern $regex
    if ($match) {
        $url = [regex]::Match($match, $regex).Groups[1].Value
        $url32 = $url.Replace('Smart','32')
        $url64 = $url.Replace('Smart','64')
        Write-Output "URL found : $url32"
    }
    $version = (Get-Version $url32).Version
    @{
        Version      = $version
        baseVersion  = $baseVersion
        URL32        = $url32
        URL64        = $url64
    }
}

update
