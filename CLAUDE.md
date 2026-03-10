# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This Documents folder contains the `Chocolatey-packages` project: a collection of Chocolatey packages for Windows, maintained automatically using the [AU (Automatic Updater)](https://github.com/chocolatey-community/chocolatey-au) PowerShell module. Packages are published to [chocolatey.org](https://chocolatey.org/profiles/tunisiano).

The main project is under `Chocolatey-packages/`.

## Common Commands

All commands are PowerShell and should be run from `Chocolatey-packages/`.

**Run all package updaters:**
```powershell
.\au\update_all.ps1
```

**Update a single package:**
```powershell
cd automatic\<package-name>
.\update.ps1
```

**Test a specific package (update + install + uninstall):**
```powershell
.\scripts\Test-RepoPackage.ps1 -packageName <package-name>
.\scripts\Test-RepoPackage.ps1 -packageName <package-name> -type update   # AU update only
.\scripts\Test-RepoPackage.ps1 -packageName <package-name> -type install  # install only
```

**Create a new package scaffold:**
```powershell
.\scripts\New-Package.ps1 -packageName <package-name>
```

**Initial environment setup (run once):**
```powershell
.\setup\au_setup.ps1
```

**Lint with PSScriptAnalyzer:**
```powershell
Invoke-ScriptAnalyzer -Path . -Settings PSScriptAnalyzerSettings.psd1 -Recurse
```

## Architecture

### Package types
- `automatic/` — Packages updated daily via AU. Each package has an `update.ps1` that scrapes the upstream source for the latest version.
- `manual/` — Packages updated by hand (no `update.ps1`).
- `Notupdatedanymore/` — Retired packages, kept for historical reference.

### Automatic package structure
Each package under `automatic/<name>/` contains:
- `<name>.nuspec` — Chocolatey package metadata (version, URLs, description, tags)
- `update.ps1` — AU update script; must define `au_GetLatest` (and optionally `au_SearchReplace`, `au_BeforeUpdate`, `au_AfterUpdate`)
- `tools/chocolateyInstall.ps1` — The actual installation script run by Chocolatey

### AU update.ps1 conventions
Every automatic package's `update.ps1` follows this pattern:
```powershell
Import-Module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

function global:au_GetLatest {
    # Scrape upstream; return hashtable with at minimum: Version, URL32 (and/or URL64)
    return @{ Version = ...; URL32 = ...; URL64 = ... }
}

function global:au_SearchReplace {
    # Return hashtable of file => regex replacements applied after version bump
    @{ 'tools/chocolateyInstall.ps1' = @{ '(pattern)' = 'replacement' } }
}

update -ChecksumFor none  # or 32, 64, all
```

Global AU hooks (`au_BeforeUpdate`, `au_AfterUpdate`) are also supported and used for checksum calculation and VirusTotal scanning.

### Helper scripts (`scripts/`)
Shared utilities imported by update scripts:
- `au_extensions.psm1` — AU extensions (e.g. `Invoke-VirusTotalScan`)
- `Get-FileVersion.ps1` — Downloads a file and returns its version (from PE FileVersionInfo) and checksum. Call it without specifying `-checksumType` so it picks the appropriate algorithm automatically. Use `.Checksum` and `.ChecksumType` from the returned object:
  ```powershell
  . ..\..\scripts\Get-FileVersion.ps1
  $FileVersion = Get-FileVersion $url
  $Latest = @{ ...; Checksum32 = $FileVersion.Checksum; ChecksumType32 = $FileVersion.ChecksumType }
  ```
- `checks.ps1`, `Find-*.ps1` — Auditing and QA helpers

### AU configuration (`au/`)
- `update_all.ps1` — Runs all updaters with push, retry, and reporting options
- `update_vars.ps1` — **Not committed**; copy from `update_vars_default.ps1` and set secrets: `$Env:au_Push`, `$Env:github_api_key`, `$Env:github_user_repo`, `$Env:gist_id`, etc.

### CI (AppVeyor)
Packages are updated daily in AppVeyor. The `au_Push = 'true'` environment variable triggers publishing to chocolatey.org. Pull requests run `Test-RepoPackage.ps1` against only the changed packages (detected via `git diff origin/master...`).

### Linting
`PSScriptAnalyzerSettings.psd1` excludes `PSAvoidGlobalVars` and `PSUseShouldProcessForStateChangingFunctions` (both intentionally used by AU's global function pattern).
