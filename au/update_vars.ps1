# AU Packages Template: https://github.com/majkinetor/au-packages-template
# Copy this file to update_vars.ps1 and set the variables there. Do not include it in the repository.

$Env:mail_user        = $Mail_user
$Env:mail_pass        = $Mail_pass
$Env:mail_server      = 'smtp.gmail.com'
$Env:mail_port        = '465'
$Env:mail_enablessl   = 'true'

$Env:api_key          = $choco_api          #Chocolatey api key
$Env:gist_id          = $Gist_id          #Specify your gist id or leave empty for anonymous gist
$Env:github_user_repo = $Github_user_repo          #{github_user>/{repo}
$Env:github_api_key   = $Github_personal_token          #Github personal access token
$Env:au_Push          = 'true'     #Push to chocolatey

$Env:gitlab_user            = $Gitlab_user   # GitLab username to use for the push
$Env:gitlab_api_key         = $Gitlab_api   # GitLab API key associated with gitlab_user
$Env:gitlab_push_url        = $Gitlab_PushURL   # GitLab URL to push to. Must be HTTP or HTTPS. e.g. https://jekotia:MyPassword@git.example.org/jekotia/au.git
$Env:gitlab_commit_strategy = 'atomic'   # Same values as the Git plugin; single, atomic, or atomictag