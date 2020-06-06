cup -y googlechrome

$chromePath = "${Env:ProgramFiles}\Google\Chrome\Application\" 
$chromeApp = "chrome.exe"
$chromeCommandArgs = "--make-default-browser"
& "$chromePath$chromeApp" $chromeCommandArgs