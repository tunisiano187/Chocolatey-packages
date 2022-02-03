#if(-not (test-path "hklm:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319\SKUs\.NETFramework,Version=v4.5")) {
Install-ChocolateyPackage `
	'MSAccess210-redist' 'exe' "/Passive /NoRestart /Log:$($env:temp)\MSAccess210-redist.log" `
	'http://download.microsoft.com/download/2/4/3/24375141-E08D-4803-AB0E-10F2E3A07AAA/AccessDatabaseEngine.exe' `
	'http://download.microsoft.com/download/2/4/3/24375141-E08D-4803-AB0E-10F2E3A07AAA/AccessDatabaseEngine_x64.exe'
#}
#else {
#     Write-Host "Microsoft Access 2010 Redistributable is already installed on your machine."
# } 
