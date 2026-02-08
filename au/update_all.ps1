# AU Packages Template: https://github.com/majkinetor/au-packages-template

param($Name = $null)

if (Test-Path $PSScriptRoot/update_vars.ps1) { . $PSScriptRoot/update_vars.ps1 }

$Options = [ordered]@{
    Timeout    = 100                                        #Connection timeout in seconds
    Threads    = 5                                          #Number of background jobs to use
    Push       = $Env:au_Push -eq 'true'                    #Push to chocolatey
    PluginPath = ''                                         #Path to user plugins
    au_groups  = 2                                          # Use 1 to test all, or N to split testing into N groups

    RepeatOn      = @(                                      #Error message parts on which to repeat package updater
      'Could not create SSL/TLS secure channel'             # https://github.com/chocolatey/chocolatey-coreteampackages/issues/718
      'Could not establish trust relationship'              # -||-
      'Unable to connect'
      'The remote name could not be resolved'
      'Choco pack failed with exit code 1'                  # https://github.com/chocolatey/chocolatey-coreteampackages/issues/721
      'The operation has timed out'
      'Internal Server Error'
      'An exception occurred during a WebClient request'
      'remote session failed with an unexpected state'
      'The connection was closed unexpectedly.'
    )
    RepeatSleep   = 30                                    #How much to sleep between repeats in seconds, by default 0
    RepeatCount   = 2                                      #How many times to repeat on errors, by default 1

    History = @{
        Lines = 120                                         #Number of lines to show
        Github_UserRepo = $Env:github_user_repo             #User repo to be link to commits
        Path = "$PSScriptRoot\Update-History.md"            #Path where to save history
    }

    Report = @{
        Type = 'markdown'                                   #Report type: markdown or text
        Path = "$PSScriptRoot\Update-AUPackages.md"         #Path where to save the report
        Params= @{                                          #Report parameters:
            Github_UserRepo = $Env:github_user_repo          #  Markdown: shows user info in upper right corner
            NoAppVeyor  = $false                            #  Markdown: do not show AppVeyor build shield
            UserMessage = "[Ignored](#ignored) | [History](#update-history) | [Force Test](https://gist.github.com/$Env:gist_id_test) | [Releases](https://github.com/$Env:github_user_repo/tags)"       #  Markdown, Text: Custom user message to show
        }
    }

    Gist = @{
        Id          = $Env:gist_id                          #Your gist id or leave empty for anonymous
        ApiKey      = $Env:github_api_key                   #Your github api key
        Path        = "$PSScriptRoot\Update-AUPackages.md", "$PSScriptRoot\Update-History.md", "$PSScriptRoot/../ToCorrect.md"  #List of files to add to gist
    }

    Git = @{
        User = 'tunisiano187'
        Password = $Env:github_api_key
    }

    GitLab = @{
        User			= 'tunisiano187'					#Git username, leave empty if github api key is used
        API_Key			= $env:Gitlab_api_key					#Password if username is not empty, otherwise api key
		PushURL			= $env:Gitlab_PushURL
		Force			= $True
		commitStrategy	= 'atomic'
    }
    #Issues = @{
    #    ApiToken    = $Env:github_api_key                   #Your github api key
    #    BaseBranch  = "master"
    #}

    RunInfo = @{
        Exclude = 'password', 'apikey'                      #Option keys which contain those words will be removed
        Path    = "$PSScriptRoot\update_info.xml"           #Path where to save the run info
    }

    Mail = if ($Env:mail_user) {
            @{
                To          = $Env:mail_user
                Server      = $Env:mail_server
                UserName    = $Env:mail_user
                Password    = $Env:mail_pass
                Port        = $Env:mail_port
                EnableSsl   = $True
                Attachments = "$PSScriptRoot\update_info.xml"
                UserMessage = "[Force Test](https://gist.github.com/$Env:gist_id)"
                SendAlways  = $false                        #Send notifications every time
             }
           } else {}
}

$global:au_Root = "$PSScriptRoot/../automatic"                           #Path to the AU packages
$info = updateall -Name $Name -Options $Options

#Uncomment to fail the build on AppVeyor on any package error
if (($null -ne $Env:APPVEYOR_PULL_REQUEST_NUMBER) -and ($Env:APPVEYOR_PULL_REQUEST_NUMBER -ne '')) {
    Write-Information "On Appveyor"
    if ($info.error_count.total) { throw "$($info.error_count.total) errors during update" }
}
# if($info.error_count.total) {
#    foreach ($issue in $info.error) {
#        # check the content of the $issue
#        if no created issue about it => create one
#        if issue exists but closed, reopen It
#        if issue exist and opened add a comment to show the date
#    }
# }