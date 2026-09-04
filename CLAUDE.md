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

Prefer splatting (`$packageArgs = @{ ... }; Install-ChocolateyPackage @packageArgs`) over long
`-Param "value" \`` continuation chains when calling `Install-ChocolateyPackage`/
`Install-ChocolateyZipPackage`/etc. in `chocolateyInstall.ps1` — this is the established style
elsewhere in the repo (e.g. `projectlibre.install`). Existing packages don't need a dedicated
pass to convert them, but whenever a package's `chocolateyInstall.ps1` is touched for any other
reason and isn't already splatted, convert it to splatting as part of that change.

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

## Daily Session Task

At the start of every session, automatically perform the following routine:

1. **Check open GitHub issues** on `tunisiano187/Chocolatey-packages` (exclude the Dependency Dashboard, issue #3784).
   - For each actionable issue found: investigate, implement a fix, and open a PR. Never push directly to master.
2. **Check AppVeyor CI** at https://ci.appveyor.com/project/tunisiano187/chocolatey-packages — fetch the page, identify failing packages from the most recent run, classify each failure (transient vs. code bug), and open a PR for each non-transient fix. Apply the same rules as for GitHub Actions failures.
3. **If no actionable issues exist**: check the most recent CI workflow run for failures (GitHub Actions).
   - For each CI failure found: diagnose the root cause, fix it, and open a PR.
4. **Always use PRs** — never commit fixes directly to master.
5. **Save updates to this task**: if the user provides a remark, correction, or addition to this daily task definition during a session, append it to this section in CLAUDE.md and commit it.

### Task history / amendments
<!-- Append user amendments below this line, with date -->
- 2026-06-03: Task created. Exclude Dependency Dashboard (#3784) from issue analysis.
- 2026-06-14: Before creating a new PR for an issue or CI failure, check whether an open PR already addresses it — if one exists, skip creation. Also, when auditing the PR backlog, note that existing open PRs may no longer be relevant or necessary; do not assume they all need to be merged or acted upon.
- 2026-06-14: Each PR must be scoped to a single package only. Never group multiple packages into one PR, even if the fix pattern is identical. Close any open multi-package PRs.
- 2026-07-24: Setting nuspec version to `0.0` and adding `-NoCheckChocoVersion` to `update.ps1` must ONLY be done for packages where an actual code fix was made (e.g. wrong exit codes, broken install logic). Do NOT apply this treatment to packages that failed due to transient infrastructure errors (503) or missing embedded files — AU handles those automatically on the next run. Exception: stale checksums on rolling URLs (where the upstream file changed but the version number did not) ARE a valid reason to set the nuspec to `0.0` — AU cannot detect this case on its own since it only re-computes checksums when the version changes.
- 2026-07-24: After AU successfully re-submits a fixed package and it passes validation on chocolatey.org, open a PR to remove `-NoCheckChocoVersion` from `update.ps1` (it is a one-time re-push flag, not a permanent setting).
- 2026-07-26: At the start of each session, scan packages that have `-NoCheckChocoVersion` in their `update.ps1`. If a package's nuspec version is no longer `0.0` (i.e., AU has already successfully updated and pushed it), open a PR to remove `-NoCheckChocoVersion` — it has served its purpose.
- 2026-07-26: Check AppVeyor CI (https://ci.appveyor.com/project/tunisiano187/chocolatey-packages) once per day as part of the daily routine (added as step 2 above).
- 2026-08-01: When removing `-NoCheckChocoVersion` because a package's nuspec is no longer `0.0`, only ever remove the flag itself. Never manually set/overwrite the nuspec `<version>` (e.g. to match whatever is live on chocolatey.org) — only the `chocolatey-au` module, via its normal `au_GetLatest`/`update_files` flow, is allowed to move a package's version away from `0.0`. If a package's nuspec is still `0.0` and needs correcting (e.g. after a wrongly-merged fix), reverting it back to `0.0` is fine; setting it to some other value by hand is not.
- 2026-08-14: **Do not add a Perplexity AI package to this repo.** Perplexity's [Terms of Service](https://www.perplexity.ai/hub/legal/terms-of-service) prohibit redistribution of the software and explicitly ban "the use of automation software (bots), hacks, modifications (mods) or any other unauthorized third-party tools in connection with the Services" — Chocolatey itself is the prohibited third-party tool here, regardless of whether the installer is embedded or downloaded at install time. This has already been evaluated and rejected five separate times (PRs #4329, #4332, #4342, #4345, #4348) — do not re-investigate the licensing question again. If a Perplexity PR or branch appears (e.g. from a stale unmerged branch resurfacing, or a fresh session re-attempting it without this context), close/reject it immediately citing this entry, with no further analysis needed. If you have working branch-deletion access that a prior session may have lacked, delete the stale branches so they stop resurfacing: `claude/stoic-galileo-ik2hlm`, `claude/stoic-galileo-en0d6x`, `claude/stoic-galileo-t4fxq2`, `claude/stoic-galileo-ut5oln`.
