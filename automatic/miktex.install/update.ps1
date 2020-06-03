import-module au

$releases = 'http://mirrors.ctan.org/systems/win32/miktex/setup/windows-x86/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
		}
	}
}

function global:au_GetLatest {
	$filename32 = ((Invoke-WebRequest -Uri $releases).Links | Where-Object {$_ -match 'basic-'}  | Where-Object {$_ -match 'exe'}).href
	$url32 = Join-Path $releases $filename32
	$url64 = $url32.replace('x86','X64');
	$version=$filename32.split('-')[2].replace('.exe','')
	
	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update