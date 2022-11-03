try
{
	#$targetUrl = "http://visualstudiogallery.msdn.microsoft.com/01516103-d487-4a7e-bb40-c15ec709afa3/file/31518/10/PowerGUIVsx.vsix"

	$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

	$targetUrl = Join-Path $(Split-Path -parent $scriptPath) 'PowerGUIVsx.vsix'
	$targetFileName = [System.IO.Path]::GetFileName($targetUrl)

	Write "Loading and installing file:[$targetFileName] from URL:[$targetUrl]"
	Install-ChocolateyVsixPackage "PowerGUIVSX" $targetUrl

	Write-ChocolateySuccess 'PowerGUIVSX'
}
catch
{
  	Write-ChocolateyFailure 'PowerGUIVSX' "$($_.Exception.Message)"
  	throw
}
