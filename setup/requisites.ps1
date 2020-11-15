cup -y checksum keepass

# http://techrena.net/disable-ie-set-up-first-run-welcome-screen/
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Value 1 -PropertyType "DWord" -Force | Out-Null
Write-Output "IE first run welcome screen has been disabled."

Write-Output 'Setting Windows Update service to Manual startup type.'
Set-Service -Name wuauserv -StartupType Manual

Write-Output "Set DNS to cloudflare"

$DNSAddresses = @(
  ([IPAddress]'1.1.1.1').IPAddressToString
  ([IPAddress]'1.0.0.1').IPAddressToString
  ([IPAddress]'2606:4700:4700::1111').IPAddressToString
  ([IPAddress]'2606:4700:4700::1001').IPAddressToString
)

$(Get-DnsClientServerAddress).InterfaceIndex | Get-Unique | Sort-Object | ForEach-Object{
        Set-DnsClientServerAddress -InterfaceIndex $_ -ServerAddresses $DNSAddresses
}