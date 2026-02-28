$Issues=Get-GitHubIssue -OwnerName Tunisiano187 -RepositoryName Chocolatey-packages1 -State Open | Where-Object {$_.IssueNumber -ne 3784}
$search = $Issues.title.Split('(|)')[1]
Write-Output "search: $search"

try {
    $page = Invoke-WebRequest -Uri "https://community.chocolatey.org/packages/$($search)" -UseBasicParsing -ErrorAction Stop
} catch {
    Write-Output "Package page not found or error for '$search': $_"
    return
}

if($page.Links | Where-Object {$_.href -match 'tunisiano'}) {
    Write-Output "tunisiano is maintainer"
    if($page.Links | Where-Object {$_.href -match 'tunisiano187/Chocolatey-packages1'}) {
        Write-Output "package published"
        Install-Module -Name PowerShellForGitHub -Force
        Import-Module PowerShellForGitHub
        $secureString = ("$env:GITHUB_TOKEN" | ConvertTo-SecureString -AsPlainText -Force)
        $cred = New-Object System.Management.Automation.PSCredential "username is ignored", $secureString
        Set-GitHubAuthentication -Credential $cred
        $secureString = $null
        $cred = $null
        Set-GitHubConfiguration -DisableTelemetry
        Update-GitHubIssue -OwnerName Tunisiano187 -RepositoryName Chocolatey-packages1 -Issue $issues.number -State Closed
        Write-Output "$($Issues.title) closed"
    } else {
        Write-Output "$($Issues.title) still opened"
    }
} else {
    Write-Output "$($Issues.title) still opened"
}
