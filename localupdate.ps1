Set-Location C:\Users\fabia\Documents\Git\Chocolatey-package\Chocolatey-packages\

# Nom partiel de l'interface réseau que vous voulez surveiller
$interfaceNameFilter = "netxtreme gigabit ethernet _3"

# Récupérer les données réseau avant l'exécution du script pour l'interface spécifiée
$networkStatsBefore = Get-WmiObject -Query "SELECT * FROM Win32_PerfRawData_Tcpip_NetworkInterface" | Where-Object { $_.Name -like "*$interfaceNameFilter*" }

if (-not $networkStatsBefore) {
    Write-Output "Interface réseau non trouvée."
    exit
}

# Exécuter votre script (ou simuler l'exécution avec une pause)
.\au\update_all.ps1

# Récupérer les données réseau après l'exécution du script pour l'interface spécifiée
$networkStatsAfter = Get-WmiObject -Query "SELECT * FROM Win32_PerfRawData_Tcpip_NetworkInterface" | Where-Object { $_.Name -like "*$interfaceNameFilter*" }

# Calculer la quantité de données transférées
$bytesSentBefore = ($networkStatsBefore | Measure-Object -Sum -Property BytesSentPersec).Sum
$bytesSentAfter = ($networkStatsAfter | Measure-Object -Sum -Property BytesSentPersec).Sum
$bytesReceivedBefore = ($networkStatsBefore | Measure-Object -Sum -Property BytesReceivedPersec).Sum
$bytesReceivedAfter = ($networkStatsAfter | Measure-Object -Sum -Property BytesReceivedPersec).Sum

$totalBytesSent = $bytesSentAfter - $bytesSentBefore
$totalBytesReceived = $bytesReceivedAfter - $bytesReceivedBefore

$totalBytesTransferred = $totalBytesSent + $totalBytesReceived

# Afficher la quantité transférée en Mo
$totalMBTransferred = [math]::round($totalBytesTransferred / 1MB, 2)
Write-Output "Total data transferred on interface '$interfaceNameFilter': $totalMBTransferred MB"
