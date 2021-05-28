import-module au

$releases = 'https://github.com/arduino/Arduino/releases'    


function global:au_SearchReplace {
    
}


function global:au_GetLatest {
    $url = $(((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match '.tar.xz'} | Select-Object -First 1).href)
    
    $version = $url -split '/' | select -Last 1 -Skip 1
    
    $url32 = 'https://downloads.arduino.cc/arduino-' + $version + '-windows.exe'
    
    $location='tools/arduino-' + $version + '-windows.exe'
    
    Invoke-WebRequest -Uri $url32 -OutFile $location
    return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32
