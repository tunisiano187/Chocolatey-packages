#!/usr/bin/env python3
"""
Enhanced GitHub surveillance script that generates reports in the format expected by the workflow
"""

import json
import os
import sys
import requests
from datetime import datetime
from typing import Dict, List, Any

def get_github_issues(repository: str, token: str, days_back: int = 1) -> List[Dict]:
    """Get issues from GitHub API"""
    headers = {
        'Authorization': f'token {token}',
        'Accept': 'application/vnd.github.v3+json'
    }
    
    issues = []
    page = 1
    
    while True:
        url = f"https://api.github.com/repos/{repository}/issues?state=open&per_page=100&page={page}"
        response = requests.get(url, headers=headers)
        
        if response.status_code != 200:
            print(f"❌ API Error: {response.status_code}")
            break
            
        page_issues = response.json()
        if not page_issues:
            break
            
        issues.extend(page_issues)
        page += 1
        
        # Respect rate limits
        if 'X-RateLimit-Remaining' in response.headers:
            remaining = int(response.headers['X-RateLimit-Remaining'])
            if remaining < 10:
                print(f"⚠️  Rate limit low: {remaining} remaining")
                break
    
    return issues

def classify_priority(title: str, labels: List[str]) -> str:
    """Classify issue priority"""
    title_lower = title.lower()
    labels_lower = [label.lower() for label in labels]
    
    # Critical: bug, security
    if (any(keyword in title_lower for keyword in ["bug", "fail", "error", "crash", "exception", "security", "vulnerability"]) or
        "bug" in labels_lower or "security" in labels_lower or "critical" in labels_lower):
        return "🔴 critical"
    
    # High: upstream release, breaking change
    if (any(keyword in title_lower for keyword in ["upstream", "release", "breaking", "major", "urgent"]) or
        "upstream" in labels_lower or "release" in labels_lower or "major" in labels_lower):
        return "🟠 high"
    
    # Medium: feature request, enhancement
    if (any(keyword in title_lower for keyword in ["feature", "enhancement", "improvement"]) or
        "feature" in labels_lower or "enhancement" in labels_lower):
        return "🟡 medium"
    
    # Low: question, documentation, help
    if (any(keyword in title_lower for keyword in ["question", "doc", "documentation", "help"]) or
        "question" in labels_lower or "documentation" in labels_lower or
        "help" in labels_lower):
        return "🔵 low"
    
    return "⚪ normal"

def generate_enhanced_report(issues: List[Dict], repository: str) -> str:
    """Generate enhanced surveillance report in the format expected by the workflow"""
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC')
    
    # Group issues by priority
    issues_by_priority = {}
    for issue in issues:
        priority = classify_priority(issue['title'], [label['name'] for label in issue.get('labels', [])])
        if priority not in issues_by_priority:
            issues_by_priority[priority] = []
        issues_by_priority[priority].append(issue)
    
    # Generate report
    report_lines = [
        f"## 📋 Rapport de Surveillance Quotidienne GitHub",
        f"",
        f"**Date**: {timestamp}  ",
        f"**Repository**: {repository}  ",
        f"**Période**: 1 jour(s)  ",
        f"",
        f"---",
        f"",
        f"### 🚀 Issues Ouverts ({len(issues)} total)",
        f""
    ]
    
    # Add issues by priority
    for priority in ["🔴 critical", "🟠 high", "🟡 medium", "🔵 low", "⚪ normal"]:
        if priority in issues_by_priority:
            issues_list = issues_by_priority[priority]
            report_lines.append(f"$(Format-IssueList $response)")
            
            for issue in issues_list:
                link = f"https://github.com/{repository}/issues/{issue['number']}"
                report_lines.append(f"- #{issue['number']}: {issue['title']} - {link} [{priority}]")
            report_lines.append("")
    
    # Add PRs section (empty for now)
    report_lines.extend([
        f"### 🔄 Pull Requests en Attente (0 total)",
        f"",
        f"Aucun Pull Request détecté",
        f"",
        f"---",
        f"",
        f"### 📊 Résumé par Priorité",
        f""
    ])
    
    # Add priority summary
    for priority in ["🔴 critical", "🟠 high", "🟡 medium", "🔵 low", "⚪ normal"]:
        if priority in issues_by_priority:
            count = len(issues_by_priority[priority])
            report_lines.append(f"- {priority}: {count}")
    
    report_lines.extend([
        f"",
        f"### 📈 Statistiques Globales",
        f"- **Total issues**: {len(issues)}",
        f"- **Total PRs**: 0",
        f"- **Critiques**: {len(issues_by_priority.get('🔴 critical', []))}",
        f"- **Hautes priorités**: {len(issues_by_priority.get('🟠 high', []))}",
        f"",
        f"### 🚀 Actions Recommandées",
        f"- 🔴 **Critique**: Répondre dans les 24 heures",
        f"- 🟠 **Haute**: Traiter dans les 3 jours  ",
        f"- 🟡 **Moyenne**: À traiter bientôt",
        f"- 🔵 **Basse**: Peut attendre",
        f"- ⚪ **Normale**: Surveillance standard",
        f"",
        f"---",
        f"",
        f"*Généré automatiquement par Enhanced Surveillance Script à {timestamp}*"
    ])
    
    return "\n".join(report_lines)

def main():
    """Main function"""
    repository = "tunisiano187/Chocolatey-packages"
    token = os.environ.get('GITHUB_TOKEN', '')
    days_back = 1
    
    if not token:
        print("❌ GITHUB_TOKEN environment variable not set")
        return 1
    
    print(f"🚀 Starting enhanced surveillance for {repository}")
    
    try:
        # Get issues
        issues = get_github_issues(repository, token, days_back)
        print(f"✅ Found {len(issues)} issues")
        
        # Generate report
        report = generate_enhanced_report(issues, repository)
        
        # Save report
        with open("Daily-GitHub-Surveillance-Report.md", "w", encoding="utf-8") as f:
            f.write(report)
        
        print("✅ Report saved successfully")
        
        # Check for critical issues
        critical_count = len([issue for issue in issues 
                             if classify_priority(issue['title'], [label['name'] for label in issue.get('labels', [])]) == "🔴 critical"])
        
        if critical_count > 0:
            print(f"🚨 Found {critical_count} critical issues - creating flag file")
            with open("critical_issues_flag.txt", "w") as f:
                f.write("CRITICAL_ISSUES_FOUND")
        
        return 0
        
    except Exception as e:
        print(f"❌ Error: {e}")
        return 1

if __name__ == "__main__":
    sys.exit(main())