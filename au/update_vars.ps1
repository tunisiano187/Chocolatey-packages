# AU Packages Template: https://github.com/majkinetor/au-packages-template
# Copy this file to update_vars.ps1 and set the variables there. Do not include it in the repository.

if(!(Test-Path Env:mail_user)) {
    $Env:mail_user        = $Mail_user
    $Env:mail_pass        = $Mail_pass
    $Env:mail_server      = 'smtp.gmail.com'
    $Env:mail_port        = '587'
    $Env:mail_enablessl   = 'true'
}

if(!(Test-Path Env:api_key)) {
    $Env:api_key                = $choco_api                # Chocolatey api key
}
if(!(Test-Path Env:gist_id)) {
    $Env:gist_id                = $Gist_id                  # Specify your gist id or leave empty for anonymous gist
}
if(!(Test-Path Env:github_user_repo)) {
    $Env:github_user_repo       = $Github_user_repo         # {github_user>/{repo}
}
if(!(Test-Path Env:github_api_key)) {
    $Env:github_api_key         = $Github_personal_token    # Github personal access token
}
$Env:au_Push                    = 'true'                    # Push to chocolatey

