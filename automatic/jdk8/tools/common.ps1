$jdk_version = '8u211'
$build = '12'
$java_version = "1.8.0_211"
$uninstall_id = "180211"
$id = "478a62b7d4e34b78b671c754eaaf38ab"
$script_path = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

function use64bit($Forcei586 = $false) {
    if ($Forcei586) {
        return $false
    }
    if (Test-Path (Join-Path $script_path "i586.txt")) {
        return $false
    }
    $is64bitOS = Get-ProcessorBits 64
    return $is64bitOS
}

function has_file($filename) {
    return Test-Path $filename
}

function get-programfilesdir() {
    if ((use64bit) -or (Get-ProcessorBits 32)) {
        $programFiles = (Get-Item "Env:ProgramFiles").Value
    } else {
        $programFiles = (Get-Item "Env:ProgramFiles(x86)").Value
    }

    return $programFiles
}


function download-from-oracle($url, $output_filename) {
    if (-not (has_file($output_fileName))) {
        Write-Host  "Downloading JDK from $url"
        $client = New-Object Net.WebClient
        $dummy = $client.DownloadFile($url, $output_filename)
    }
}

function download-jdk-file($url, $output_filename) {
    $dummy = download-from-oracle $url $output_filename
}

function download-jdk($Forcei586 = $false) {
    $arch = get-arch $Forcei586
    $filename = "jdk-$jdk_version-windows-$arch.exe"
    $url = "https://javadl.oracle.com/webapps/download/GetFile/$java_version-b$build/$id/windows-i586/$filename"
    $output_filename = Join-Path $script_path $filename

    $dummy = download-jdk-file $url $output_filename

    return $output_filename
}


function get-java-home() {
    if (Test-Path (Join-Path $script_path "installdir.txt")) {
        return Get-Content (Join-Path $script_path "installdir.txt")
    }

    $program_files = get-programfilesdir
    return Join-Path $program_files "Java\jdk$java_version"
}

function get-java-bin() {
    $java_home = get-java-home
    return Join-Path $java_home 'bin'
}

function get-arch($Forcei586 = $false) {
    if((use64bit $Forcei586)) {
        return "x64"
    } else {
        return "i586"
    }
}

function chocolatey-install($params, $Forcei586 = $false) {
    $jdk_file = download-jdk $Forcei586
    $arch = get-arch $Forcei586
    $java_home = get-java-home
    $java_bin = get-java-bin
    $install_options = '/s '
    if ($params.static -ne $false) {
        $install_options += 'STATIC=1 '
    }
    if ($params.installdir -ne $null) {
        $install_options += 'INSTALLDIR=' + $params.installdir + ' '
    }

    $install_options += 'ADDLOCAL="ToolsFeature'
    if ($params.source -ne $false) {
        $install_options += ',SourceFeature'
    }
    $install_options += '"'
    #if ($params.source -eq $false) {
    #    $install_options = '/s STATIC=1 ADDLOCAL="ToolsFeature"'
    #} else {
    #    $install_options = '/s STATIC=1 ADDLOCAL="ToolsFeature,SourceFeature"'
    #}
    Install-ChocolateyInstallPackage 'jdk8' 'exe' $install_options $jdk_file
}

function set-path() {
    $java_home = get-java-home
    $java_bin = get-java-bin
    Install-ChocolateyPath $java_bin 'Machine'

    if ([Environment]::GetEnvironmentVariable('CLASSPATH','Machine') -eq $null) {
        Install-ChocolateyEnvironmentVariable 'CLASSPATH' '.;' 'Machine'
    }

    Install-ChocolateyEnvironmentVariable 'JAVA_HOME' $java_home 'Machine'
}

function out-i586($params) {
    if ($env:ChocolateyForceX86 -eq 'true' -or $params.i586 -eq $true -or $params.x64 -eq $false) {
        Out-File (Join-Path $script_path "i586.txt")
    }
}

function check-both($params) {
    return ($params.both -eq $true) -and (use64bit)
}

function out-both($params) {
    if (check-both($params)) {
            Out-File (Join-Path $script_path "both.txt")
    }
}

function out-installdir($params) {
    if ($params.installdir -ne $null) {
        Out-File -InputObject $params.installdir -FilePath (Join-Path $script_path "installdir.txt")
    }
}
