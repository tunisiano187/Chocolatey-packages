import-module au

$releases = 'https://github.com/arduino/Arduino/releases'    


function global:au_SearchReplace {
    @{
        'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
		}
    }
}


function global:au_GetLatest {
    $url = $(((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match '.tar.xz'} | Select-Object -First 1).href)
    
    $version = $url -split '/' | select -Last 1 -Skip 1
    
    $url32 = 'https://downloads.arduino.cc/arduino-' + $version + '-windows.exe'
    
    return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32
