$name='Eclipse'
$url32='http://mirror.ibcp.fr/pub/eclipse/eclipse/downloads/drops4/R-4.2.2-201302041200/eclipse-SDK-4.2.2-win32.zip'
$url64='http://eclipse.ialto.com/eclipse/downloads/drops4/R-4.2.2-201302041200/eclipse-SDK-4.2.2-win32-x86_64.zip'

Install-ChocolateyZipPackage "$name" "$url32" C:\Eclipse "$url64" 

