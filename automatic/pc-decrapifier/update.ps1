$ErrorActionPreference = 'Stop'
import-module au

function global:au_SearchReplace {

}

function global:au_GetLatest {
	$version = "3.0.1.20240702"

	$Latest = @{ URL32 = 'https://www.bowlman.org'; Version = $version}

    return $Latest
}

update -ChecksumFor none -NoCheckUrl
