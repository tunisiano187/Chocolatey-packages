$bits = Get-ProcessorBits
$packageName = $env:ChocolateyPackageName
$extensionID = 'aeblfdkhhhdcdjpifhhbdiojplfjncoa'

if ($bits -eq 64) {
    Remove-Item "HKLM:\SOFTWARE\Wow6432node\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | out-null
   }else{
    Remove-Item "HKLM:\SOFTWARE\Google\Chrome\Extensions\$extensionID" -Force -ErrorAction SilentlyContinue | out-null
}
