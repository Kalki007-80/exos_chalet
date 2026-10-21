# Target Information

## Device Identity

| Field | Value | Source |
|---|---|---|
| Hostname | POWERHOUSE-1-CORE | `show switch` |
| Model | Extreme Networks X460G2-48x-10G4 | `show switch` |
| Serial Number | `<REDACTED>` | `show switch` |
| IP Address | 10.1.58.1 | Network / `show switch` |
| MAC Address | 00:04:96:XX:XX:XX | Nmap, `show switch` |

## Firmware and Software

| Field | Value | Source |
|---|---|---|
| Firmware Version | ExtremeXOS 22.7.1.2-patch1-24 | `show version` |
| Build Date | Tue Feb 25 15:17:20 EST 2020 | `show version` |
| Primary Image | 22.7.1.2 patch1-24 | `show version` |
| Secondary Image | 21.1.5.2 patch1-5 | `show version` |
| Kernel | EXOS Linux 3.18.123 | `show version` |
| FIPS Module | fips-ecp-2.0.16 | `show version` |
| BootROM | 1.0.2.1 | `show version` |
| Diagnostics | 5.12 | `show version` |

> [!IMPORTANT]
> The build date of **February 25, 2020** is the root cause of F-01. The firmware predates patches for CVE-2023-43118 through 43121 by approximately 3.5 years. The minimum safe version is 22.7.1.4.

## System State

| Field | Value | Source |
|---|---|---|
| Boot Time | Sat Jun 6 21:33:06 2026 | `show switch` |
| Uptime at Test | ~136 days | `show switch` |
| Boot Count | 29 | `show switch` |
| Active Configuration | primary.cfg | `show switch` |
| Config Size | 1,219,707 bytes | `show switch` / `cfg-directory-listing` |
| Config Last Saved | Sep 23 12:32:02 2026 | `cfg-directory-listing` |
| Pending Config Changes | Yes (unsaved changes at test time) | `show switch` |

> [!WARNING]
> Pending unsaved configuration changes were present at the time of assessment. **Do NOT save configuration** until the pending changes have been reviewed. See [docs/04-remediation-roadmap.md](04-remediation-roadmap.md) for the note on config save.

## Services

| Port | Protocol | Service | Status |
|---|---|---|---|
| 23/tcp | Telnet | EXOS CLI | Open |
| 80/tcp | HTTP | Chalet (CherryPy) | Open |
| 443/tcp | HTTPS | — | **Closed** |

## Configuration Directory Observations

From `show switch` and `ls /usr/local/cfg/` (evidence: [cfg-directory-listing.txt](../evidence/cli/cfg-directory-listing.txt)):

| File / Directory | Permissions | Size | Date | Notes |
|---|---|---|---|---|
| primary.cfg | -rw-rw-rw- (0666) | 1,219,707 bytes | Sep 23 12:32 2026 | Active config — world-writable (F-10) |
| primary.cfg.bak | -rw-rw-rw- (0666) | — | — | Backup config — also world-writable |
| primary.cfg.codexbak.1773817912 | -rw-rw-rw- (0666) | — | — | Non-standard backup file observed |
| cc_logs/ | drwxrwxrwx (0777) | — | Apr 23 2020 | World-writable log directory (F-11) |
| shell.py | — | 306 bytes | Mar 18 2026 | Non-standard file — origin unknown (F-12) |
| testme.py | — | 79 bytes | Mar 18 2026 | Non-standard file — origin unknown (F-12) |
| vmt/ | — | — | Jun 6 21:33 | Non-standard directory — origin unknown (F-12) |

> [!CAUTION]
> The `.bak` and `.codexbak` backup files are also world-readable/writable. These may contain configuration snapshots with credentials. The `shell.py`, `testme.py`, and `vmt/` items are not part of a standard ExtremeXOS installation. Their contents were not read and they were not executed. Investigate with Extreme TAC before taking any action.

## Hardware

| Field | Value |
|---|---|
| PSU-1 | Present (Internal PSU) |
| PSU-2 | Present (Internal PSU) |

## Active Sessions at Test Time

From `show session` (evidence: [show-session.txt](../evidence/cli/show-session.txt)):

| Session ID | Type | Role | Source |
|---|---|---|---|
| 901 | Telnet | user | 10.1.58.XXX |
| 902 | XML (JSON-RPC / Chalet) | user | 10.1.58.XXX |
