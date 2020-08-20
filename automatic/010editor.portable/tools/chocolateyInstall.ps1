$ErrorActionPreference = 'Stop';

$url32       = 'https://www.sweetscape.com/download/010EditorWin32Portable.exe'
$url64       = 'https://www.sweetscape.com/download/010EditorWin64Portable.exe'
$checksum32  = '9fd5ed16a3786c6419f0fe3fd67ad71d6f7597e72dc9ef3ba7c8c0c4936f4555'
$checksum64  = 'b09bcf2b36f0d946ee35585512c317ff0ede341b7fe28b8e254e5849f161f00e'
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
  checksumType  = 'sha256'
  url           = $url32

  checksum64    = $checksum64
  checksumType64= 'sha256'
  url64bit      = $url64
}

Get-ChocolateyWebFile @packageArgs

$extractPath = (Join-Path "$installLocation" "..\extract")
innounp -x -b -y -d"$extractPath" "$full_dl_filename"
robocopy (Join-Path "$extractPath" "{app}") "$installLocation" /e /mov /NFL /NDL /NJH /NJS /nc /ns /np
Remove-Item -Path $extractPath -Recurse -Force
Remove-Item -Path "$full_dl_filename" -Force
