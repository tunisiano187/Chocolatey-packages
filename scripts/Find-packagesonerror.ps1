Install-Module psgithubsearch -ErrorAction SilentlyContinue
Import-Module psgithubsearch
if(!(Test-Path Env:github_api_key)) {
    $Env:github_api_key   = $Github_personal_token          #Github personal access token
}
[string]$Owner = "tunisiano187"
[string]$Repository = "Chocolatey-packages"
$UserToken = $env:github_api_key
$Headers = @{
    Authorization='token '+$UserToken
}

$chocousers     = {tunisiano},{dtgm}
foreach ($user in $chocousers) {
    $chocoprofile = "https://community.chocolatey.org/profiles/$user"
    $chocoprofile
    $links = ((Invoke-WebRequest -Uri $chocoprofile -UseBasicParsing).links | Where-Object {$_.outerHTML -match "maintainer"}).href

    foreach ($package in $links) {
        $packageName    = $package.split("/")[-2]

        $issues = (Find-GitHubIssue -Type issue -Repo "$Owner/$Repository" -Labels "NeedsUpdate" -Keywords $packageName | Sort-Object -Property Number).Title.split('(|)')[1]
        $check=$issues | Where-Object {$_ -match "won't fix"}
        if($check -eq 0) {
            [string]$Label = "NeedsUpdate"
            [string]$Title = "($packageName) Needs update"
            [string]$Description = "([$packageName](https://community.chocolatey.org/packages/$packageName)) needs maintainer"
            New-GithubIssue -Title $Title -Description $Description -Label $Label -owner $Owner -Repository $Repository -Headers $Headers
        }
    }
}