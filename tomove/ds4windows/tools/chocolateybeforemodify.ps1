$packageName  = $env:ChocolateyPackageName

$p = Get-Process -Name "DS4Windows" -ea 0
if (!$p) {
    "$packageName is not running"
    return
}

"$packageName is running, trying to gracefully shut it down before upgrade/uninstall"
Stop-Process -InputObject $p -Force
