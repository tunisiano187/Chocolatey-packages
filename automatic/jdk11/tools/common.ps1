$jdk_version = '11.0.2'
$build = '9'
$id = "f51449fcd52f4d52b93a989c5c56ed3c"
$script_path = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

function has_file($filename) {
    return Test-Path $filename
}

function get-programfilesdir() {
    $programFiles = (Get-Item "Env:ProgramFiles").Value
 
    return $programFiles
}
 
function download-from-oracle($url, $output_filename) {
    if (-not (has_file($output_fileName))) {
        Write-Host  "Downloading JDK from $url"
 
        try {
            [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
 
            $client = New-Object Net.WebClient
            $dummy = $client.Headers.Add('Cookie', 'gpw_e24=http://www.oracle.com; oraclelicense=accept-securebackup-cookie')
 
            $defaultCreds = [System.Net.CredentialCache]::DefaultCredentials
            if ($defaultCreds -ne $null) {
                $client.Credentials = $defaultCreds
            }    
 
            # Copy from https://github.com/chocolatey/choco/blob/master/src/chocolatey.resources/helpers/functions/Get-WebFile.ps1
            # check if a proxy is required
            $explicitProxy = $env:chocolateyProxyLocation
            $explicitProxyUser = $env:chocolateyProxyUser
            $explicitProxyPassword = $env:chocolateyProxyPassword
            if ($explicitProxy -ne $null) {
                # explicit proxy
              $proxy = New-Object System.Net.WebProxy($explicitProxy, $true)
              if ($explicitProxyPassword -ne $null) {
                  $passwd = ConvertTo-SecureString $explicitProxyPassword -AsPlainText -Force
                  $proxy.Credentials = New-Object System.Management.Automation.PSCredential ($explicitProxyUser, $passwd)
              }
 
              Write-Host "Using explicit proxy server '$explicitProxy'."
                $client.Proxy = $proxy
 
            } elseif (!$client.Proxy.IsBypassed($url)) {
              # system proxy (pass through)
                $creds = [net.CredentialCache]::DefaultCredentials
                if ($creds -eq $null) {
                    Write-Debug "Default credentials were null. Attempting backup method"
                    $cred = get-credential
                    $creds = $cred.GetNetworkCredential();
                }
                $proxyaddress = $client.Proxy.GetProxy($url).Authority
                Write-Host "Using system proxy server '$proxyaddress'."
                $proxy = New-Object System.Net.WebProxy($proxyaddress)
                $proxy.Credentials = $creds
                $client.Proxy = $proxy
           }
               
           $dummy = $client.DownloadFile($url, $output_filename)
        } finally {
            [System.Net.ServicePointManager]::ServerCertificateValidationCallback = $null
        }
    }  
}
 
function download-jdk-file($url, $output_filename) {
    $dummy = download-from-oracle $url $output_filename
}
 
function download-jdk() {
    $filename = "jdk-" + $jdk_version + "_windows-x64_bin.exe"
    $url = "http://download.oracle.com/otn-pub/java/jdk/$jdk_version+$build/$id/$filename"
    $output_filename = Join-Path $script_path $filename
 
    $dummy = download-jdk-file $url $output_filename
 
    return $output_filename
}
 
 
function get-java-home() {
    if (Test-Path (Join-Path $script_path "installdir.txt")) {
        return Get-Content (Join-Path $script_path "installdir.txt")
    }

    $program_files = get-programfilesdir
    return Join-Path $program_files ("Java\jdk-" + $jdk_version)
}
 
function get-java-bin() {
    $java_home = get-java-home
    return Join-Path $java_home 'bin'
}
  
function chocolatey-install($params) {
    $jdk_file = download-jdk
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
    Install-ChocolateyInstallPackage 'jdk11' 'exe' $install_options $jdk_file          
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
 
function out-installdir($params) {
    if ($params.installdir -ne $null) {
        Out-File -InputObject $params.installdir -FilePath (Join-Path $script_path "installdir.txt")
    }
}
