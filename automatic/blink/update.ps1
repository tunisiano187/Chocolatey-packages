import-module au

$release = 'https://blink.sipthor.net/download.phtml?download&os=nt'

function Set-UseUnsafeHeaderParsing
{
    param(
        [Parameter(Mandatory,ParameterSetName='Enable')]
        [switch]$Enable,

        [Parameter(Mandatory,ParameterSetName='Disable')]
        [switch]$Disable
    )

    $ShouldEnable = $PSCmdlet.ParameterSetName -eq 'Enable'

    $netAssembly = [Reflection.Assembly]::GetAssembly([System.Net.Configuration.SettingsSection])

    if($netAssembly)
    {
        $bindingFlags = [Reflection.BindingFlags] 'Static,GetProperty,NonPublic'
        $settingsType = $netAssembly.GetType('System.Net.Configuration.SettingsSectionInternal')

        $instance = $settingsType.InvokeMember('Section', $bindingFlags, $null, $null, @())

        if($instance)
        {
            $bindingFlags = 'NonPublic','Instance'
            $useUnsafeHeaderParsingField = $settingsType.GetField('useUnsafeHeaderParsing', $bindingFlags)

            if($useUnsafeHeaderParsingField)
            {
              $useUnsafeHeaderParsingField.SetValue($instance, $ShouldEnable)
            }
        }
    }
}

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]referer\s*=\s*)('.*')" 		= "`$1'$($Latest.Referer)'"
		}
	}
}

function global:au_GetLatest {
	Set-UseUnsafeHeaderParsing -Enable
	$referer        = 'http://icanblink.com/download/'
	Invoke-WebRequest -Uri $referer -OutFile "$env:TEMP/icanblink.html" #  Required to be allowed just after
	$url32 = $release
	$File = Join-Path($(Split-Path $script:MyInvocation.MyCommand.Path)) "blink.exe"
	Set-UseUnsafeHeaderParsing -Enable
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=$(Get-Command $File).FileVersionInfo.ProductVersion.trim()

	$Latest = @{ URL32 = $url32; Version = $version; Referer = $referer }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion