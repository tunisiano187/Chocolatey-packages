$Issues=Get-GitHubIssue -OwnerName Tunisiano187 -RepositoryName chocolatey-packages -State Open | Where-Object {$_.IssueNumber -ne 3784}

Write-Output $Issues