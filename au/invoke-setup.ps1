$ok='no';
while ($ok -eq 'no')
{
	$ok='yes'
	try
	{
		$download_page = Invoke-WebRequest -Uri "https://github.com/htacg/tidy-html5/releases" -ErrorAction SilentlyContinue
	}
	catch
	{
		Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Value 2
		Write-Host -fore Red $_
		$ok='no'
		start-sleep -Seconds 1
	}
}