param(
    [Parameter(Position=0, Mandatory=$false)]
    [string]$File,
    [Parameter(Position=1, Mandatory=$false)]
    [string]$Url
)

# Determine the path of the executable to analyze
if ($File) {
    $ExePath = $File
} elseif ($Url) {
    $tempFile = Join-Path $env:TEMP (Split-Path $Url -Leaf)
    try {
        Invoke-WebRequest -Uri $Url -OutFile $tempFile -UseBasicParsing
        $ExePath = $tempFile
    } catch {
        Write-Output "Error downloading the file from the URL."
        exit 1
    }
} else {
    Write-Output "Please specify -File (local path) or -Url (download link)."
    exit 1
}

# Check for Chocolatey
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    $installScript = Invoke-WebRequest -Uri 'https://community.chocolatey.org/install.ps1' -UseBasicParsing
    & ([ScriptBlock]::Create($installScript.Content))
}

# Upgrade Sysinternals (installs if missing)
choco upgrade sysinternals -y

# Refresh PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

if (-not (Get-Command strings.exe -ErrorAction SilentlyContinue)) {
    Write-Output "strings.exe not found after install."; exit 1
}


if (-not (Test-Path $ExePath)) {
    Write-Output "EXE file not found: $ExePath";
    exit 1
}

$strings = & strings.exe $ExePath | Out-String

$results = @()
if ($strings | Select-String "Nullsoft|NSIS" -Quiet) { $results += "$ExePath /S" }
if ($strings | Select-String "Inno Setup|InnoSetup" -Quiet) { $results += "$ExePath /VERYSILENT /SUPPRESSMSGBOXES /NORESTART" }
if ($strings | Select-String "InstallShield|ISScript|Setup.exe" -Quiet) { $results += "$ExePath -s" }
if ($strings | Select-String "Wise|Wise Installation" -Quiet) { $results += "$ExePath /s" }
if ($strings | Select-String "msi|MSIEXEC" -Quiet) { $results += "msiexec /i `"$ExePath`" /qn /norestart" }
if ($strings | Select-String "Jordan Russell|JRSetup" -Quiet) { $results += "$ExePath /VERYSILENT" }
if ($strings | Select-String "7-Zip|LZMA" -Quiet -and $ExePath -like "*7z.sfx*") { $results += "$ExePath" }
if ($results.Count -eq 0) { $results += "$ExePath /?  # Or try /S, /silent, /quiet, /q" }

$results | ForEach-Object { Write-Output $_ }
