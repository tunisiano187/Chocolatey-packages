while(!Invoke-WebRequest -Uri "https://github.com/htacg/tidy-html5/releases" -ErrorAction SilentlyContinue)
{
	start-sleep -Seconds 1
}