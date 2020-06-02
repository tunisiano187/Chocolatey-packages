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
		 $ok='no'
	}
}