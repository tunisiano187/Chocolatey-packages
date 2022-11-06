$ErrorActionPreference = 'Stop'
if ($Null -eq (get-process "Executor" -ea SilentlyContinue)) {
  Write-Output "Executor NOT running."
} else {
  Write-Output "Stopping Executor process..."
  Stop-Process -processname "Executor"
}
