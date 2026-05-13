<#
.SYNOPSIS
Simple test script for GitHub surveillance
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

Write-Host "Starting simple surveillance test..."
Write-Host "Repository: $Repository"
Write-Host "Days back: $DaysBack"
Write-Host "GitHub token length: $($GitHubToken.Length)"

# Test GitHub API connection
try {
    $headers = @{
        'Authorization' = "token $GitHubToken"
        'Accept' = 'application/vnd.github.v3+json'
    }
    
    $response = Invoke-RestMethod -Uri "https://api.github.com/repos/$Repository/issues?state=open&per_page=10" -Headers $headers -Method Get
    Write-Host "GitHub API call successful"
    Write-Host "Found $($response.Count) issues"
    
    # Generate simple report
    $reportContent = @"
## 📋 Simple Surveillance Report

Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
Repository: $Repository
Days analyzed: $DaysBack

### Issues Found: $($response.Count)

$(foreach ($issue in $response) {
    "- #$(($issue.number).ToString()): $($issue.title) - https://github.com/$Repository/issues/$(($issue.number).ToString())"
})

### Summary
- Total issues: $($response.Count)
- Report generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
"@

    # Save report
    $reportContent | Out-File -FilePath "Daily-GitHub-Surveillance-Report.md" -Encoding UTF8
    Write-Host "Report saved successfully"
    
    # Check for critical issues
    $criticalIssues = $response | Where-Object {
        ($_.title -match "bug|fail|error|crash|exception" -or 
         $_.labels.name -contains "bug" -or 
         $_.labels.name -contains "security")
    }
    
    if ($criticalIssues.Count -gt 0) {
        Write-Host "Found $($criticalIssues.Count) critical issues"
    } else {
        Write-Host "No critical issues found"
    }
    
}
catch {
    Write-Error "GitHub API call failed: $($_.Exception.Message)"
    exit 1
}

Write-Host "Simple surveillance test completed successfully"