$Issues=Get-GitHubIssue -OwnerName Tunisiano187 -RepositoryName chocolatey-packages -State Open | Where-Object {$_.IssueNumber -ne 3784}
$search = $Issues.title.Split('(|)')[1]
$search

$page = Invoke-WebRequest -Uri "https://community.chocolatey.org/packages/$($search)" -UseBasicParsing
if($page.Links | Where-Object {$_.href -match 'tunisiano'}) {
    Write-Output "tunisiano is maintainer"
    if($page.Links | Where-Object {$_.href -match 'tunisiano187/Chocolatey-packages'}) {
        Write-Output "package published"
        Install-Module -Name PowerShellForGitHub -Force
        Import-Module PowerShellForGitHub
        $secureString = ("$env:GITHUB_TOKEN" | ConvertTo-SecureString -AsPlainText -Force)
        $cred = New-Object System.Management.Automation.PSCredential "username is ignored", $secureString
        Set-GitHubAuthentication -Credential $cred
        $secureString = $null # clear this out now that it's no longer needed
        $cred = $null # clear this out now that it's no longer needed
        Set-GitHubConfiguration -DisableTelemetry

        Update-GitHubIssue -OwnerName Tunisiano187 -RepositoryName chocolatey-packages -Issue $issues.number -State Closed
        Write-Output "$($Issues.title) closed"
    } else {
        Write-Output "$($Issues.title) still opened"
    }
} else {
    Write-Output "$($Issues.title) still opened"
}