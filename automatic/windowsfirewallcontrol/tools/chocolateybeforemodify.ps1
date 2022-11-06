$ErrorActionPreference = 'Stop'
Start-Process 'sc.exe' -Verb "runas" -ArgumentList 'stop wfcs'
