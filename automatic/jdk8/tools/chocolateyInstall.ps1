$script_path = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$common = $(Join-Path $script_path "common.ps1")
. $common
 
#installs jdk8
try {
    $params = "$env:chocolateyPackageParameters" 
    $params = (ConvertFrom-StringData $params.Replace(";", "`n")) 
     
    out-installdir($params)
    if (check-both($params)) {
        chocolatey-install $params $true
        chocolatey-install $params
        out-both($params)
    } else {
        out-i586($params)
        chocolatey-install $params
    }   
    set-path
} catch {
    if ($_.Exception.InnerException) {
        $msg = $_.Exception.InnerException.Message
    } else {
        $msg = $_.Exception.Message
    }
    throw 
}  