# agent.md — Handoff notes for a successor agent

This file exists so that a new Claude Code (or other) agent can pick up the
recurring maintenance function currently performed on this repository, in
case the agent that built up this operational knowledge is no longer
available. `CLAUDE.md` is the authoritative, append-only log of rules and
decisions — read it first and follow it exactly. This file adds the
*operational* context (routines, credentials, tooling, historical
rationale) that doesn't belong in CLAUDE.md's instruction set but that a
successor needs to actually function day to day.

## What this role is

A daily-recurring maintenance job across three related repos, all
developed on the shared branch `claude/choco-packages-cicd-zq09hd`:

- `tunisiano187/Chocolatey-packages` (primary — most of the work happens here)
- `tunisiano187/choco-packages`
- `tunisiano187/Chocolatey-packages1`

The job is defined in full in **`CLAUDE.md` → "Daily Session Task"**: check
open GitHub issues, check AppVeyor CI
(https://ci.appveyor.com/project/tunisiano187/chocolatey-packages), check
GitHub Actions, fix what's actionable, one PR per package, never push to
master directly. **Read that section and its full amendment history before
doing anything** — it encodes hard-won corrections (e.g. never touch
`.appveyor.yml`, never hand-set nuspec `<version>`, the Perplexity
rejection precedent) that are easy to silently violate if you re-derive
the rules from scratch.

## Branch / PR mechanics that aren't obvious from CLAUDE.md

- The shared branch `claude/choco-packages-cicd-zq09hd` can only carry
  **one open PR at a time** per repo. Workflow for each new fix once the
  previous PR on that branch has merged:
  ```
  git fetch origin master
  git checkout -B claude/choco-packages-cicd-zq09hd origin/master
  # make/cherry-pick exactly the commit(s) for this one package
  git push -u origin claude/choco-packages-cicd-zq09hd --force
  ```
  The `--force` is routinely needed: GitHub sometimes silently re-hashes
  a just-pushed commit (same content, new SHA) shortly after push. If a
  push is rejected, `git fetch` + `git diff` to confirm content is
  identical before force-pushing — don't assume a real conflict.
- After opening a PR: call `subscribe_pr_activity` on it immediately, and
  consider a `send_later` check-in (~1h out) as a safety net in case
  webhook events don't arrive. See the top-level system prompt's PR
  Activity Events section for the full posture on owned-PR CI/review
  handling — it is not optional, drive every opened PR to green or
  explain why not.
- One PR per package, always (CLAUDE.md, 2026-06-14). Never batch fixes
  for multiple packages into one PR even when the root cause and fix
  pattern are identical (e.g. the three-package 409-conflict batch below
  was still shipped as three separate PRs).
- Before opening a new PR for an issue/CI failure, check there isn't
  already an open PR addressing it.

## Established fix patterns (apply these, don't re-derive)

### The recurring 409-Conflict version-collision bug
Symptom: a package update run fails pushing to chocolatey.org with a 409
Conflict, over and over, even though the upstream software hasn't
actually changed.

Root cause: `.appveyor.yml`'s single-package push handler pushes
successfully to chocolatey.org but never commits the result back to git,
so the local nuspec stays stuck at a stale version (often `0.0`) forever,
and every subsequent run re-detects "new version available" and
re-attempts pushing the same already-published version. **`.appveyor.yml`
itself must not be touched** — this was an explicit standing user
instruction; only individual `update.ps1` workarounds are acceptable.

**Do not** fix this with a naive `Get-Date`-based version bump — that
mints a brand-new version *every single day forever*, since the
underlying git-commit gap never closes. That's worse than the original
bug (silent daily spam instead of a visible, if repetitive, 409).

**Correct pattern** (matches the pre-existing `windjview` package, now
also applied to `cports`, `projectlibre.install`, `wamp-server`):
compare the freshly-downloaded file's checksum against what's already
committed in `tools/chocolateyInstall.ps1`; only bump the version — using
the file's own HTTP `Last-Modified` header date (not "today") — when the
checksum has genuinely changed. See `automatic/wamp-server/update.ps1`
for a fully-commented reference implementation. Gotcha: `Get-FileVersion`
defaults to SHA512 — pass `-checksumType 'sha256'` explicitly if the
committed checksums in the repo are SHA256, or the comparison always
reports "different" and defeats the fix.

### Stale checksum on a rolling URL
If the upstream download URL is stable but its *content* changes without
the filename/version changing, AU can't detect this on its own (it only
recomputes checksums when the version string changes). This is one of
the few cases where manually setting the nuspec to `0.0` +
`-NoCheckChocoVersion` in `update.ps1` is appropriate (CLAUDE.md,
2026-07-24). Once AU successfully re-pushes and the version moves off
`0.0`, open a PR to remove `-NoCheckChocoVersion` (CLAUDE.md, 2026-07-26)
— never hand-edit the nuspec version itself (2026-08-01).

### Splatting convention
Prefer `$packageArgs = @{ ... }; Install-ChocolateyZipPackage @packageArgs`
over long `-Param "value" \`` backtick chains in `chocolateyInstall.ps1`.
Documented in CLAUDE.md under "Automatic package structure". Not a
dedicated repo-wide refactor pass — apply it opportunistically whenever a
package's `chocolateyInstall.ps1` is touched for any other reason.

## Package-specific precedents (don't re-litigate these)

- **Perplexity AI**: rejected five times (PRs #4329, #4332, #4342, #4345,
  #4348) on ToS grounds — redistribution/automation-tooling prohibition.
  If a Perplexity PR/branch resurfaces, close it citing CLAUDE.md's
  2026-08-14 entry with no further licensing analysis. Stale branches to
  delete if you have access: `claude/stoic-galileo-ik2hlm`,
  `claude/stoic-galileo-en0d6x`, `claude/stoic-galileo-t4fxq2`,
  `claude/stoic-galileo-ut5oln`.
- **windjview**: flagged by chocolatey-ops moderation for bundled
  Yandex adware. Independently verified via VirusTotal (genuine
  detection, not a false positive). User decision: leave the package
  as-is, do not retire, let the stuck moderation review expire on its
  own (~15 days from the 2026-08-14 flag date). No further action unless
  the user raises it again.
- **electron**: upstream dropped the win32-ia32 (32-bit) build as of
  v44 — package now ships win32-x64 only, `update.ps1`'s `$url32`
  filter was narrowed accordingly (see comments in that file).
- **openhab**: `au_GetLatest`'s zip-matching regex didn't allow
  milestone/RC suffixes (e.g. `openhab-5.3.0.M1.zip`), causing a silent
  empty-URL failure. Fixed to `"/openhab-\d[\d.]*(\.\w+)?\.zip$"`.
- **network-inventory-advisor, packetstream, vnc-connect**: retired
  (`git mv` from `automatic/` to `Notupdatedanymore/`) — each had no
  viable free/current download source left upstream. If upstream ever
  resurfaces a working source, they could in principle be revived, but
  that hasn't been evaluated.

## Auxiliary system: helpdesk.choc@gmail.com email triage

Separate from the Chocolatey package work, but running on its own daily
routine (trigger `trig_017axRnenvJ5ax7KgUbsJ9P8`, fires 08:00 UTC daily):
checks the `helpdesk.choc@gmail.com` inbox and trashes already-handled
mail.

- **Why a custom script instead of the native Gmail connector**: the
  native Claude Gmail MCP connector is already bound to a different
  account (`tunisiano187@gmail.com`) and can only hold one account at a
  time. IMAP/SMTP (port 993/587) are fully blocked by this sandbox's
  network egress policy (HTTPS-only via proxy) — confirmed by a direct
  socket test timing out. Zapier was tried first but its task quota was
  exhausted and the user found it too expensive ("trop cher"); fully
  migrated off it.
- **Implementation**: `/home/user/scripts_helpdesk_gmail/gmail_check.py`
  — a from-scratch OAuth2 REST client (token refresh via
  `oauth2.googleapis.com/token`, mail operations via
  `gmail.googleapis.com/gmail/v1/users/me/...`). Subcommands: `list
  --max N`, `show <message_id>`, `trash <message_id>`.
- **Credentials**: `/home/user/.credentials/helpdesk_gmail/credentials.json`
  (`client_id`, `client_secret`, `refresh_token`), directory `chmod 700`,
  file `chmod 600`, deliberately kept **outside any git repo**. If this
  file is missing/rotated, the OAuth flow needs to be redone with the
  user (walk them through creating a Google Cloud OAuth client and
  authorizing it; see conversation history for the exact steps if
  needed) — do not attempt IMAP as a fallback, it's network-blocked here.
  If a session ever prints or otherwise exposes these values in plain
  chat, tell the user to rotate them.
- **VirusTotal API key**: `/home/user/.credentials/virustotal/apikey.txt`
  (`chmod 600`), used for ad-hoc moderation-flag verification (e.g. the
  windjview case above) via `GET
  https://www.virustotal.com/api/v3/files/{sha256}` with header
  `x-apikey: <key>`. Not tied to the AU `au_AfterUpdate` VirusTotal scan
  hook (that uses its own configured key inside `au/update_vars.ps1`,
  not committed).

## General operating notes

- Read access to *any* public GitHub repo works via `add_repo` (or a bare
  `git clone`) even if it's outside this session's declared repo scope —
  useful for checking an upstream project's actual release-asset naming
  before writing a regex fix (e.g. was done for `openhab/openhab-distro`).
- This environment has no interactive rebase (`git rebase -i`). To fix a
  mid-branch commit, reset the branch to `origin/master` and rebuild the
  remaining commits from scratch in order, rather than trying to amend
  history in place.
- `git stash` / `git stash pop` is the right tool when you need to keep
  an unrelated in-progress change (e.g. a CLAUDE.md doc edit) off an
  in-flight PR branch temporarily.
- All secrets across this whole operation live under
  `/home/user/.credentials/<service>/` with `700`/`600` permissions,
  never inside a git repository. Keep it that way for anything new.
- When in doubt about a convention, CLAUDE.md's amendment history is the
  source of truth — it exists specifically because the user has
  corrected this role's behavior multiple times and asked for those
  corrections to persist. Read the whole "Task history / amendments"
  section before acting, not just the top-level task description.
