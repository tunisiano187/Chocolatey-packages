<#
.SYNOPSIS
  Test urls in ps1 files and if the server is TLS1.2+

.DESCRIPTION
  Check each url of the ps1 files and check the server is TLS1.2+
  If the url isn't OK and if the server is TLS1.2+
  Save the output in json file

.PARAMETER Name
  If specified it only updates the package matching the specified name

.PARAMETER PackagesDirectory
  The relative path to where packages are located (relative to the location of this script)

.PARAMETER UseStopwatch
  Uses a stopwatch to time how long this script used to execute

.PARAMETER Quiet
  Do not write normal output to host.
  NOTE: Output from git and Write-Warning will still be available

.OUTPUTS
  The packages that have errors

.EXAMPLE
  ps> .\Find-ps1errors.ps1

.EXAMPLE
  ps> .\Updates-Variables.ps1 -Name "bitvise-ssh-server" -UseStopwatch
  ps> .\Updates-Variables.ps1 -UseStopwatch
  While also updating the ps1 files this will also output the time it took for the script to finish
  output> "Time Used: 00:00:27.4720531"

#>

param(
  [string]$Name,
  [string]$PackagesDirectory = "../automatic",
  [switch]$UseStopwatch,
  [switch]$Quiet
)

$counts = @{
  replaced = 0
  uptodate = 0
}

function Test-ServerTLSSupport {
[CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$HostName,
        [UInt16]$Port = 443
    )
    process {
        $RetValue = New-Object psobject -Property @{
            Host = $HostName
            Port = $Port
            SSLv2 = $false
            SSLv3 = $false
            TLSv1_0 = $false
            TLSv1_1 = $false
            TLSv1_2 = $false
            TLSv1_3 = $false
            KeyExhange = $null
            HashAlgorithm = $null
        }
        "ssl2", "ssl3", "tls", "tls11", "tls12", "tls13" | ForEach-Object{
            $TcpClient = New-Object Net.Sockets.TcpClient
            $TcpClient.Connect($RetValue.Host, $RetValue.Port)
            $SslStream = New-Object Net.Security.SslStream $TcpClient.GetStream(),
                $true,
                ([System.Net.Security.RemoteCertificateValidationCallback]{ $true })
            $SslStream.ReadTimeout = 15000
            $SslStream.WriteTimeout = 15000
            try {
                $SslStream.AuthenticateAsClient($RetValue.Host,$null,$_,$false)
                $RetValue.KeyExhange = $SslStream.KeyExchangeAlgorithm
                $RetValue.HashAlgorithm = $SslStream.HashAlgorithm
                $status = $true
            } catch {
                $status = $false
            }
            switch ($_) {
                "ssl2" {$RetValue.SSLv2 = $status}
                "ssl3" {$RetValue.SSLv3 = $status}
                "tls" {$RetValue.TLSv1_0 = $status}
                "tls11" {$RetValue.TLSv1_1 = $status}
                "tls12" {$RetValue.TLSv1_2 = $status}
                "tls13" {$RetValue.TLSv1_3 = $status}
            }
            # dispose objects to prevent memory leaks
            $TcpClient.Dispose()
            $SslStream.Dispose()
        }
        $RetValue
    }
}

function Find-PS1Error {
  param(
    [string]$PS1Path
  )

  $ps1 = Get-Content "$PS1Path" -Encoding UTF8

  $array = ($ps1 | Where-Object {$_ -match "http"})
  $array | select-string -pattern '\b(?:(?:https?|ftp|file)://|www\.|ftp\.)(?:\([-A-Z0-9+&@#/%=~_|$?!:,.]*\)|[-A-Z0-9+&@#/%=~_|$?!:,.])*(?:\([-A-Z0-9+&@#/%=~_|$?!:,.]*\)|[A-Z0-9+&@#/%=~_|$])' | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }


}

if ($UseStopwatch) {
  $stopWatch = New-Object System.Diagnostics.Stopwatch
  $stopWatch.Start();
}

If ($Name) {
  $packages = Get-ChildItem -Path "$PSScriptRoot/$PackagesDirectory/$Name" -Filter "*.ps1"

  foreach ($package in $packages) {
    Find-PS1Error -Name $package.FullName -Quiet $Quiet
  }
}
else {
  $packages = Get-ChildItem -Path "$PSScriptRoot/$PackagesDirectory" -Filter "*.ps1" -Recurse;

  foreach ($package in $packages) {
    Find-PS1Error $package.FullName -Quiet $Quiet
  }
}

if ($UseStopwatch) {
  $stopWatch.Stop();
  if (!$Quiet) {
    Write-Output "Time Used: $($stopWatch.Elapsed)"
  }
}

if ($counts.replaced -eq 0 -and !$Quiet) {
  Write-Output "Congratulations, all found ps1 are correct."
} elseif (!$Quiet) {
  Write-Output "Updated $($counts.replaced) ps1";
}

if ($counts.uptodate -eq 1 -and !$Quiet) {
  Write-Output "$($counts.uptodate) ps1 was already up to date.";
} elseif ($counts.uptodate -gt 1 -and !$Quiet) {
  Write-Output "$($counts.uptodate) ps1 were already up to date.";
}