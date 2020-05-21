# AU Packages Template: https://github.com/majkinetor/au-packages-template
# Copy this file to update_vars.ps1 and set the variables there. Do not include it in the repository.

$Env:mail_user        = $Mail_user
$Env:mail_pass        = $Mail_pass
$Env:mail_server      = 'smtp.gmail.com'
$Env:mail_port        = '587'
$Env:mail_enablessl   = 'true'

$Env:api_key          = $choco_api          #Chocolatey api key
$Env:gist_id          = $Gist_id          #Specify your gist id or leave empty for anonymous gist
#$Env:github_user_repo = $Github_user_repo          #{github_user>/{repo}
$Env:github_api_key   = $Github_personal_token          #Github personal access token
$Env:au_Push          = 'true'     #Push to chocolatey
