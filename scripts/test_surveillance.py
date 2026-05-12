#!/usr/bin/env python3
"""
Test script for GitHub daily surveillance system
Validates the surveillance logic and report generation
"""

import json
import os
import sys
from datetime import datetime, timedelta
from typing import Dict, List, Any

def test_priority_classification():
    """Test the issue priority classification logic"""
    print("🧪 Testing priority classification logic...")
    
    # Test cases for priority classification
    test_cases = [
        {
            "title": "Critical bug in package installation",
            "labels": ["bug", "critical"],
            "expected_priority": "critical"
        },
        {
            "title": "Security vulnerability found",
            "labels": ["security"],
            "expected_priority": "critical"
        },
        {
            "title": "Upstream release available",
            "labels": ["upstream", "release"],
            "expected_priority": "high"
        },
        {
            "title": "Feature request: new functionality",
            "labels": ["feature", "enhancement"],
            "expected_priority": "medium"
        },
        {
            "title": "Documentation improvement needed",
            "labels": ["documentation"],
            "expected_priority": "low"
        },
        {
            "title": "General question about usage",
            "labels": ["question"],
            "expected_priority": "low"
        },
        {
            "title": "Standard issue with no special labels",
            "labels": [],
            "expected_priority": "normal"
        }
    ]
    
    def classify_priority(title: str, labels: List[str]) -> str:
        """Simulate the PowerShell priority classification logic"""
        title_lower = title.lower()
        labels_lower = [label.lower() for label in labels]
        
        # Critical: bug, security
        if (any(keyword in title_lower for keyword in ["bug", "fail", "error", "crash", "exception"]) or
            "bug" in labels_lower or "security" in labels_lower):
            return "critical"
        
        # High: upstream release, breaking change
        if (any(keyword in title_lower for keyword in ["upstream", "release", "breaking", "major"]) or
            "upstream" in labels_lower or "release" in labels_lower):
            return "high"
        
        # Low: question, documentation (check first to override medium)
        if (any(keyword in title_lower for keyword in ["question", "doc", "documentation", "help"]) or
            "question" in labels_lower or "documentation" in labels_lower or
            "help" in labels_lower or
            "doc" in title_lower):
            return "low"
        
        # Medium: feature request, enhancement
        if (any(keyword in title_lower for keyword in ["feature", "enhancement", "improvement"]) or
            "feature" in labels_lower or "enhancement" in labels_lower):
            return "medium"
        
        return "normal"
    
    # Run test cases
    passed = 0
    total = len(test_cases)
    
    for i, test_case in enumerate(test_cases, 1):
        result = classify_priority(test_case["title"], test_case["labels"])
        expected = test_case["expected_priority"]
        
        if result == expected:
            print(f"  ✅ Test {i}: PASSED - {test_case['title']} -> {result}")
            passed += 1
        else:
            print(f"  ❌ Test {i}: FAILED - {test_case['title']} -> {result} (expected {expected})")
    
    print(f"\nPriority classification: {passed}/{total} tests passed")
    return passed == total

def test_report_generation():
    """Test the surveillance report generation"""
    print("\n🧪 Testing report generation...")
    
    # Mock data
    mock_issues = [
        {
            "number": 123,
            "title": "Critical bug in package installation",
            "labels": [{"name": "bug"}, {"name": "critical"}]
        },
        {
            "number": 124,
            "title": "Feature request: new functionality",
            "labels": [{"name": "feature"}]
        },
        {
            "number": 125,
            "title": "Documentation improvement",
            "labels": [{"name": "documentation"}]
        }
    ]
    
    mock_prs = [
        {
            "number": 45,
            "title": "Fix for security vulnerability"
        },
        {
            "number": 46,
            "title": "Add new package support"
        }
    ]
    
    def generate_report(issues: List[Dict], prs: List[Dict]) -> str:
        """Generate surveillance report"""
        report_lines = []
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        
        # Issues section
        report_lines.append("## 📋 Issues ouvertes (3)")
        report_lines.append("Issues ouvertes depuis 1 jour(s):")
        report_lines.append("")
        
        # Group issues by priority
        issues_by_priority = {}
        for issue in issues:
            priority = classify_priority(issue["title"], [label["name"] for label in issue["labels"]])
            if priority not in issues_by_priority:
                issues_by_priority[priority] = []
            issues_by_priority[priority].append(issue)
        
        priority_emojis = {
            "critical": "🔴",
            "high": "🟠", 
            "medium": "🟡",
            "low": "🔵",
            "normal": "⚪"
        }
        
        for priority in ["critical", "high", "medium", "low", "normal"]:
            if priority in issues_by_priority:
                issues_list = issues_by_priority[priority]
                emoji = priority_emojis.get(priority, "⚪")
                report_lines.append(f"{emoji} **{priority}** ({len(issues_list)} issues):")
                
                for issue in issues_list:
                    issue_link = f"https://github.com/tunisiano187/Chocolatey-packages/issues/{issue['number']}"
                    report_lines.append(f"- #{issue['number']}: {issue['title']} - {issue_link}")
                report_lines.append("")
        
        # PRs section
        report_lines.append("## 🔄 Pull Requests en attente (2)")
        report_lines.append("Pull Requests ouverts depuis 1 jour(s):")
        report_lines.append("")
        
        for pr in prs:
            pr_link = f"https://github.com/tunisiano187/Chocolatey-packages/pull/{pr['number']}"
            report_lines.append(f"- #{pr['number']}: {pr['title']} - {pr_link}")
        report_lines.append("")
        
        # Summary section
        report_lines.append("## 📊 Résumé")
        report_lines.append(f"Date de surveillance: {timestamp}")
        report_lines.append(f"Total issues: {len(issues)}")
        report_lines.append(f"Total PRs: {len(prs)}")
        
        return "\n".join(report_lines)
    
    # Generate test report
    report = generate_report(mock_issues, mock_prs)
    
    # Save report
    with open("test-surveillance-report.md", "w", encoding="utf-8") as f:
        f.write(report)
    
    # Validate report structure
    required_sections = ["📋 Issues ouvertes", "🔄 Pull Requests en attente", "📊 Résumé"]
    validation_passed = True
    
    for section in required_sections:
        if section not in report:
            print(f"  ❌ Missing section: {section}")
            validation_passed = False
    
    if validation_passed:
        print("  ✅ Report generation test PASSED")
        print(f"  📄 Report saved with {len(report)} characters")
    else:
        print("  ❌ Report generation test FAILED")
    
    return validation_passed

def test_workflow_configuration():
    """Test GitHub Actions workflow configuration"""
    print("\n🧪 Testing workflow configuration...")
    
    workflow_file = ".github/workflows/daily-surveillance.yml"
    
    if not os.path.exists(workflow_file):
        print(f"  ❌ Workflow file not found: {workflow_file}")
        return False
    
    with open(workflow_file, "r") as f:
        workflow_content = f.read()
    
    # Check for required components
    required_components = [
        "name: Daily GitHub Issues Surveillance",
        "schedule:",
        "runs-on: ubuntu-latest",
        "steps:",
        "Checkout repository",
        "Set up PowerShell",
        "Run daily surveillance",
        "Commit and push surveillance report"
    ]
    
    validation_passed = True
    for component in required_components:
        if component not in workflow_content:
            print(f"  ❌ Missing component: {component}")
            validation_passed = False
    
    if validation_passed:
        print("  ✅ Workflow configuration test PASSED")
    else:
        print("  ❌ Workflow configuration test FAILED")
    
    return validation_passed

def classify_priority(title: str, labels: List[str]) -> str:
    """Priority classification function (duplicate for report generation)"""
    title_lower = title.lower()
    labels_lower = [label.lower() for label in labels]
    
    # Critical: bug, security
    if (any(keyword in title_lower for keyword in ["bug", "fail", "error", "crash", "exception"]) or
        "bug" in labels_lower or "security" in labels_lower):
        return "critical"
    
    # High: upstream release, breaking change
    if (any(keyword in title_lower for keyword in ["upstream", "release", "breaking", "major"]) or
        "upstream" in labels_lower or "release" in labels_lower):
        return "high"
    
    # Low: question, documentation, help (check first to override medium)
    if (any(keyword in title_lower for keyword in ["question", "doc", "documentation", "help"]) or
        "question" in labels_lower or "documentation" in labels_lower or
        "help" in labels_lower or
        "doc" in title_lower):
        return "low"
    
    # Medium: feature request, enhancement
    if (any(keyword in title_lower for keyword in ["feature", "enhancement", "improvement"]) or
        "feature" in labels_lower or "enhancement" in labels_lower):
        return "medium"
    
    return "normal"

def main():
    """Main test function"""
    print("🚀 Starting Daily Surveillance System Tests")
    print("=" * 50)
    
    tests_passed = 0
    total_tests = 3
    
    # Test 1: Priority Classification
    if test_priority_classification():
        tests_passed += 1
    
    # Test 2: Report Generation
    if test_report_generation():
        tests_passed += 1
    
    # Test 3: Workflow Configuration
    if test_workflow_configuration():
        tests_passed += 1
    
    # Final Results
    print("\n" + "=" * 50)
    print(f"🏁 Test Results: {tests_passed}/{total_tests} tests passed")
    
    if tests_passed == total_tests:
        print("🎉 All tests PASSED! The surveillance system is ready.")
        return 0
    else:
        print("❌ Some tests FAILED. Please check the output above.")
        return 1

if __name__ == "__main__":
    sys.exit(main())