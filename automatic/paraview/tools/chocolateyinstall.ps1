$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.6&type=binary&os=Windows&downloadFile=ParaView-5.6.1-Windows-msvc2015-64bit.exe' # download url, HTTPS preferred

$packageArgs = @{
  packageName   = 'paraview'
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'paraview*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum      = '7E755DC7E6D3F0A4DC130BEC8D2C512E2A5A9457E3A02AFFD934CE56B650C9C0'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
}

Install-ChocolateyZipPackage @packageArgs # https://chocolatey.org/docs/helpers-install-chocolatey-zip-package