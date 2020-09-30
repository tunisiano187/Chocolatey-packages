$ErrorActionPreference = 'Stop';

$url32            = 'https://www.sweetscape.com/download/010EditorWin32Portable.exe'
$url64            = 'https://www.sweetscape.com/download/010EditorWin64Portable.exe'
$checksum32       = 'ad272b1b99af4abc121f74b3624d331576f94b0c16a3e2b6b6a3eaf3bf036bc9'
$checksum64       = '927299ef2de4fe6cf735853ec887cb29068ba24a5347fd7280d26f557a415e8a'
$checksumType32   = 'sha256'
$checksumType64   = 'sha256'
$installLocation = Join-Path "$env:ChocolateyInstall\lib" "010editor.portable\tools"

$cwd = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne $true) {
	$unzip_file = Split-Path $url64 -leaf
} else {
	$unzip_file = Split-Path $url32 -leaf
}

New-Item "$installLocation\010EditorPortable.exe.gui" -type file -force | Out-Null
New-Item "$installLocation\AppData\assistant.exe.ignore" -type file -force | Out-Null
New-Item "$installLocation\AppData\010Editor.exe.ignore" -type file -force | Out-Null

$full_dl_filename = (Join-Path "$cwd" "$unzip_file")

$packageArgs = @{
  packageName   = '010editor.portable'
  fileType      = 'EXE'
  softwareName  = '010 Editor*'
  FileFullPath  = $full_dl_filename

  checksum      = $checksum32
  checksumType  = $checksumType32
  url           = $url32

  checksum64    = $checksum64
  checksumType64= $checksumType64
  url64bit      = $url64
}

Get-ChocolateyWebFile @packageArgs

$extractPath = (Join-Path "$installLocation" "..\extract")
innounp -x -b -y -d"$extractPath" "$full_dl_filename"
robocopy (Join-Path "$extractPath" "{app}") "$installLocation" /e /mov /NFL /NDL /NJH /NJS /nc /ns /np
Remove-Item -Path $extractPath -Recurse -Force
Remove-Item -Path "$full_dl_filename" -Force
