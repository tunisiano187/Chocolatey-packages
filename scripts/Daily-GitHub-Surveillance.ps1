<#
.SYNOPSIS
Daily surveillance script for GitHub issues in Chocolatey packages repository

.DESCRIPTION
This script runs daily at 08:30 Europe/Brussels to:
- Query GitHub API for new issues opened in the last 24 hours
- Check for pending PRs that need attention
- Identify bug reports and security issues
- Create child issues or comment with summaries and direct links
- Prioritize critical issues (bug, security, upstream release)

.NOTES
Author: GitHubManager
Run daily at 08:30 Europe/Brussels
#>

param(
    [Parameter(Mandatory = $false)]
    [string]$Repository = "tunisiano187/Chocolatey-packages",
    
    [Parameter(Mandatory = $false)]
    [string]$GitHubToken = $env:GITHUB_TOKEN,
    
    [Parameter(Mandatory = $false)]
    [int]$DaysBack = 1
)

# Set error preference
$ErrorActionPreference = 'Continue'

# Import required modules
try {
    Import-Module PowerShellGet
    Import-Module Microsoft.PowerShell.Utility
}
catch {
    Write-Warning "Some modules may not be available: $($_.Exception.Message)"
}

# Function to get GitHub API data
function Get-GitHubApiData {
    param(
        [string]$Endpoint,
        [string]$Token
    )
    
    $headers = @{
        'Authorization' = "token $Token"
        'Accept' = 'application/vnd.github.v3+json'
        'User-Agent' = 'Chocolatey-Packages-Surveillance'
    }
    
    $uri = "https://api.github.com/repos/$Endpoint"
    
    try {
        $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
        return $response
    }
    catch {
        Write-Error "Failed to get data from GitHub API: $($_.Exception.Message)"
        return $null
    }
}

# Function to get issues from the last N days
function Get-GitHubIssues {
    param(
        [string]$Repository,
        [string]$Token,
        [int]$DaysBack
    )
    
    $since = (Get-Date).AddDays(-$DaysBack).ToString("yyyy-MM-ddTHH:mm:ssZ")
    $endpoint = "$Repository/issues?state=open&since=$since&sort=created&direction=desc"
    
    Write-Host "Fetching issues since: $since"
    $issues = Get-GitHubApiData -Endpoint $endpoint -Token $Token
    
    if ($issues) {
        # Filter to only actual issues (not PRs)
        $issues = $issues | Where-Object { -not $_.pull_request }
        return $issues
    }
    return @()
}

# Function to get pull requests
function Get-GitHubPullRequests {
    param(
        [string]$Repository,
        [string]$Token,
        [int]$DaysBack
    )
    
    $since = (Get-Date).AddDays(-$DaysBack).ToString("yyyy-MM-ddTHH:mm:ssZ")
    $endpoint = "$Repository/pulls?state=open&since=$since&sort=created&direction=desc"
    
    Write-Host "Fetching pull requests since: $since"
    $prs = Get-GitHubApiData -Endpoint $endpoint -Token $Token
    
    if ($prs) {
        return $prs
    }
    return @()
}

# Function to categorize issues by priority
function Get-IssuePriority {
    param(
        [object]$Issue
    )
    
    $title = $Issue.title.ToLower()
    $labels = $Issue.labels | ForEach-Object { $_.name.ToLower() }
    
    # Critical: bug, security
    if ($title -match "bug|fail|error|crash|exception" -or $labels -contains "bug" -or $labels -contains "security") {
        return "critical"
    }
    
    # High: upstream release, breaking change
    if ($title -match "upstream|release|breaking|major" -or $labels -contains "upstream" -or $labels -contains "release") {
        return "high"
    }
    
    # Low: question, documentation, help (check first to override medium)
    if ($title -match "question|doc|documentation|help" -or $labels -contains "question" -or $labels -contains "documentation" -or $labels -contains "help" -or $title -match "doc") {
        return "low"
    }
    
    # Medium: feature request, enhancement
    if ($title -match "feature|enhancement|improvement" -or $labels -contains "feature" -or $labels -contains "enhancement") {
        return "medium"
    }
    
    return "normal"
}

# Function to create surveillance report
function Create-SurveillanceReport {
    param(
        [array]$Issues,
        [array]$PullRequests
    )
    
    $report = @()
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    # Add issues summary
    if ($Issues.Count -gt 0) {
        $report += "## 📋 Issues ouvertes ($($Issues.Count))"
        $report += "Issues ouvertes depuis $($DaysBack) jour(s):"
        $report += ""
        
        $groupedIssues = $Issues | Group-Object { Get-IssuePriority $_ }
        
        foreach ($group in $groupedIssues | Sort-Object Name -Descending) {
            $priority = $group.Name
            $priorityEmoji = @{
                "critical" = "🔴"
                "high" = "🟠"
                "medium" = "🟡"
                "low" = "🔵"
                "normal" = "⚪"
            }[$priority]
            
            $report += "$priorityEmoji **$priority** ($($group.Count) issues):"
            
            foreach ($issue in $group.Group) {
                $issueLink = "https://github.com/$Repository/issues/$($issue.number)"
                $report += "- #$($issue.number): $($issue.title) - $issueLink"
            }
            $report += ""
        }
    }
    else {
        $report += "Aucune nouvelle issue ouverte depuis $($DaysBack) jour(s)"
        $report += ""
    }
    
    # Add PRs summary
    if ($PullRequests.Count -gt 0) {
        $report += "## 🔄 Pull Requests en attente ($($PullRequests.Count))"
        $report += "Pull Requests ouverts depuis $($DaysBack) jour(s):"
        $report += ""
        
        foreach ($pr in $PullRequests) {
            $prLink = "https://github.com/$Repository/pull/$($pr.number)"
            $report += "- #$($pr.number): $($pr.title) - $prLink"
        }
        $report += ""
    }
    else {
        $report += "Aucun nouveau Pull Request depuis $($DaysBack) jour(s)"
        $report += ""
    }
    
    # Add summary
    $report += "## 📊 Résumé"
    $report += "Date de surveillance: $timestamp"
    $report += "Total issues: $($Issues.Count)"
    $report += "Total PRs: $($PullRequests.Count)"
    
    return $report -join "`n"
}

# Main execution
Write-Host "Starting daily GitHub surveillance for $Repository"
Write-Host "Running at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

# Check if GitHub token is available
if (-not $GitHubToken) {
    Write-Error "GitHub token is required. Set GITHUB_TOKEN environment variable."
    exit 1
}

# Get issues and PRs
$issues = Get-GitHubIssues -Repository $Repository -Token $GitHubToken -DaysBack $DaysBack
$prs = Get-GitHubPullRequests -Repository $Repository -Token $GitHubToken -DaysBack $DaysBack

Write-Host "Found $($issues.Count) issues and $($prs.Count) pull requests"

# Create report
$report = Create-SurveillanceReport -Issues $issues -PullRequests $prs

# Save report to file
$reportFile = Join-Path $PSScriptRoot "..\..\Daily-GitHub-Surveillance-Report.md"
$report | Out-File -FilePath $reportFile -Encoding UTF8
Write-Host "Report saved to: $reportFile"

# Display report
Write-Host "`n=== SURVEILLANCE REPORT ==="
Write-Host $report
Write-Host "============================"

# For now, just output the report. In production, this would:
# 1. Create child issues for critical/high priority items
# 2. Comment on the main surveillance issue with the report
# 3. Set appropriate labels and assignees

Write-Host "Daily surveillance completed successfully"