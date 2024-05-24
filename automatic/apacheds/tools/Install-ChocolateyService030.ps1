function Install-ChocolateyService030 {
    <#
    .SYNOPSIS
    Installs a service

    .DESCRIPTION
    This will install a service

    .PARAMETER PackageName
    The name of the package for whom the service will be installed.

    .PARAMETER ServiceName
    The name of service which will be used to install and start the service.

    .PARAMETER CreateServiceCommand
    The command which installs the service.

    .PARAMETER AvailablePort (OPTIONAL)
        The port which needs to be available in order to start the service.

        .EXAMPLE
        Install-ChocolateyService030 'PACKAGE_NAME' 'SERVICE_NAME' 'INSTALL_COMMAND' 'PORT'
        Install-ChocolateyService030 "dcm4chee" "DCM4CHEE" "nssm install DCM4CHEE `"java`" -jar `"%DCM4CHEE_HOME%/bin/run.jar"`" "8090"
        Install-ChocolateyService030 "postgresqlzip" "PostgreSQL" "pg_ctl register -N `"PostgreSQL`" -U `"LocalSystem`" -w" "5432"
        Install-ChocolateyService030 "apacheds" "ApacheDS" "nssm install ApacheDS `"java`" -jar `"%APACHEDS_HOME%/lib/apacheds-service-${version}.jar`" `"%APACHEDS_HOME%/instances/default`"" "10389"
        Install-ChocolateyService030 "test" "test" "nssm install test `"$testDirectory\testService.bat`""

        .OUTPUTS
        None

        .NOTES
        This helper reduces the number of lines one would have to write to install a service to 1 line.
        This method has error handling built into it.

        .LINK
        UnInstall-ChocolateyService030
        Get-ServiceExistence
#>
        param(
            [string] $packageName,
            [string] $serviceName,
            [string] $createServiceCommand,
            [int] $availablePort
        )
        Write-debug "Running 'Install-ChocolateyService030' for $packageName with serviceName:`'$serviceName`', createServiceCommand: `'$createServiceCommand`', availablePort: `'$availablePort`' ";

    if (!$packageName) {
        Write-ChocolateyFailure "Install-ChocolateyService030" "Missing PackageName input parameter."
        return
        }

    if (!$serviceName) {
        Write-ChocolateyFailure "Install-ChocolateyService030" "Missing ServiceName input parameter."
        return
        }

    if (!$createServiceCommand) {
        Write-ChocolateyFailure "Install-ChocolateyService030" "Missing CreateServiceCommand input parameter."
        return
        }

        Uninstall-ChocolateyService030 -serviceName "$serviceName"

    if ($availablePort -and (Get-StatePort)) {
        Write-ChocolateyFailure "Install-ChocolateyService030" "$availablePort is in LISTENING state and not available."
        return
        }

    try {
        Write-Host "$packageName service will be installed"
        iex $createServiceCommand
    } catch {
    Write-ChocolateyFailure "Install-ChocolateyService030" "The createServiceCommand is incorrect: '$_'."
    return
}

if (Get-ServiceExistence030) {
        Write-Host "$packageName service will be started"

        for ($i=0;$i -lt 12; $i++) {
            $serviceStatus = Get-Service -Name $serviceName

                             start-service $serviceName

            if (($serviceStatus.Status -eq "running") -and (Get-StatePort)) {
                Write-Host "$packageName service has been started"
                return
            } else {
                Write-Host "$packageName service cannot be started. Attempt $i to start the service."
            }

            if ($i -eq 11) {
                Write-ChocolateyFailure "Install-ChocolateyService030" "service $serviceName cannot be started."
                return
                }

                Start-Sleep -s 10
            }
    } else {
        Write-ChocolateyFailure "Install-ChocolateyService030" "service $serviceName does not exist."
        return
        }
    }

function Get-ServiceExistence030 {
    param(
        [string] $serviceName = $serviceName
    )
    Get-WmiObject -Class Win32_Service -Filter "Name='$serviceName'"
}

function Uninstall-ChocolateyService030 {
    param(
        [string] $serviceName = $serviceName
    )
    $service = Get-ServiceExistence030 -serviceName $serviceName

    if ($service) {
        Write-Host "$serviceName service already exists and will be removed"
        stop-service $serviceName
        $service.delete()
    }
}

function Get-StatePort {
    return Get-NetTCPConnection -State Listen | Where-Object {$_.LocalAddress -match "::|0.0.0.0" -and $_.LocalPort -eq "$availablePort"}
}