# ExtremeXOS / Chalet Security Assessment — `POWERHOUSE-1-CORE`

![Status](https://img.shields.io/badge/status-final%20v1.0.0-blue) ![Severity](https://img.shields.io/badge/severity-critical-red) ![Findings](https://img.shields.io/badge/findings-17-red) ![License](https://img.shields.io/badge/license-restricted-lightgrey)

---

## Abstract

A time-boxed security assessment of an Extreme Networks X460G2-48x-10G4 core switch (`POWERHOUSE-1-CORE`, 10.1.58.1) running ExtremeXOS 22.7.1.2-patch1-24 (built February 2020) was conducted on 2026-10-20. The assessment identified an overall **Critical** risk posture driven by outdated firmware with five applicable public CVEs, cleartext management protocols, and world-writable configuration files. No exploit payloads were executed; all testing was read-only and conducted under written authorization.

---

## Legal & Disclosure

> **Authorized assessment only.** All testing was performed under written authorization from the device owner. This repository contains no exploit code. Evidence files have been redacted per the conventions in [docs/07-evidence-guide.md](docs/07-evidence-guide.md). See the full disclosure and legal statement: [docs/06-disclosure-and-legal.md](docs/06-disclosure-and-legal.md).

---

## Table of Contents

1. [Findings at a Glance](#findings-at-a-glance)
2. [Target Information](#target-information)
3. [Repository Structure](#repository-structure)
4. [How to Read This Repo](#how-to-read-this-repo)
5. [Verification Commands](#verification-commands)
6. [Remediation Priority](#remediation-priority)
7. [CVE/CWE Coverage](#cvecwe-coverage)
8. [Evidence Integrity](#evidence-integrity)
9. [Screenshots](#screenshots)
10. [Disclaimer](#disclaimer)
11. [Contact](#contact)

---

## Findings at a Glance

| # | Finding | Severity | CVSS | CWE | CVE | Status |
|---|---|---|---|---|---|---|
| F-01 | Outdated firmware predating 2023 fixes | Critical | 9.8 | CWE-1104 | 2023-43118/43119/43120/43121, 2020-18305 | Confirmed (version-based) |
| F-02 | Telnet management exposed | High | 7.4 | CWE-319 | — | Confirmed |
| F-03 | Chalet over HTTP only | High | 7.4 | CWE-319, 614 | — | Confirmed |
| F-04 | Cookie lacks Secure/HttpOnly/SameSite | Medium | 5.3 | CWE-1004, 614 | — | Confirmed |
| F-05 | Missing security headers | Medium | 5.3 | CWE-693 | — | Confirmed |
| F-06 | Client-side authz via `ng-show="accessRight==='readWrite'"` | Medium | 5.3 | CWE-602 | 2020-18305 (conditional) | Confirmed (UI) |
| F-07 | CLI Terminal plugin publicly served | High | 7.5 | CWE-284 | — | Confirmed |
| F-08 | `/terminal/_static/` handler unauthenticated | High | 7.5 | CWE-22 | 2023-43121 | Confirmed (exposure) |
| F-09 | Internal IPs in `chalet.min.js` | Low | 3.7 | CWE-200 | — | Confirmed |
| F-10 | `primary.cfg` mode 0666 | High | 7.1 | CWE-732 | — | Confirmed |
| F-11 | `cc_logs/` mode 0777 | High | 7.1 | CWE-732 | — | Confirmed |
| F-12 | Non-standard executables in config directory | Info | 0.0 | CWE-1188 | — | Presence confirmed |
| F-13 | `user` role browses `/usr/local/cfg` | High | 7.1 | CWE-269 | — | Confirmed |
| F-14 | `/jsonrpc` role filtering | Medium | 5.3 | CWE-269 | — | Inconclusive |
| F-16 | HS256 JWT, 24 h lifetime, dual-cookie | Medium | 5.9 | CWE-522, 326 | — | Confirmed |
| F-17 | Permissive CORS on `/jsonrpc` | High | 7.3 | CWE-942 | — | Confirmed |
| F-18 | Python exception disclosure on `/jsonrpc` | Medium | 4.3 | CWE-209 | — | Confirmed |
| N-01 | Network inventory | Info | 0.0 | — | — | Pending |

---

## Target Information

| Field | Value |
|---|---|
| Hostname | POWERHOUSE-1-CORE |
| Model | Extreme Networks X460G2-48x-10G4 |
| Serial | `<REDACTED>` |
| IP Address | 10.1.58.1 |
| MAC Address | 00:04:96:XX:XX:XX |
| Firmware | ExtremeXOS 22.7.1.2-patch1-24 |
| Build Date | Tue Feb 25 15:17:20 EST 2020 |
| Kernel | EXOS Linux 3.18.123, FIPS fips-ecp-2.0.16 |
| BootROM | 1.0.2.1 |
| Diagnostics | 5.12 |
| Primary Image | 22.7.1.2 patch1-24 |
| Secondary Image | 21.1.5.2 patch1-5 |
| Services | 23/tcp telnet, 80/tcp HTTP (CherryPy); 443 closed |
| Session Role Tested | `user` |
| Boot Time | Sat Jun 6 21:33:06 2026 |
| Uptime | ~136 days at test time |
| Boot Count | 29 |
| Active Config | primary.cfg (1,219,707 bytes, saved Sep 23 12:32:02 2026) |
| PSU | PSU-1 and PSU-2 present (Internal) |
| Test Date | 2026-10-20, 21:30–22:00 IST (UTC+5:30) |

---

## Repository Structure

```
extreme-exos-chalet-assessment/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   └── finding-request.md       # Issue template for evidence gaps
│   ├── workflows/
│   │   └── redact-check.yml         # CI: blocks commits with unredacted secrets
│   ├── PULL_REQUEST_TEMPLATE.md     # PR checklist
│   └── SECURITY.md                  # Disclosure policy
├── docs/
│   ├── findings/
│   │   ├── F-01-outdated-firmware.md
│   │   ├── F-02-telnet-exposed.md
│   │   ├── F-03-http-only-chalet.md
│   │   ├── F-04-cookie-flags.md
│   │   ├── F-05-missing-security-headers.md
│   │   ├── F-06-client-side-authorization.md
│   │   ├── F-07-terminal-plugin-public.md
│   │   ├── F-08-terminal-static-handler.md
│   │   ├── F-09-internal-ip-disclosure.md
│   │   ├── F-10-primary-cfg-permissions.md
│   │   ├── F-11-cc-logs-permissions.md
│   │   ├── F-12-nonstandard-files.md
│   │   ├── F-13-readonly-cfg-directory-access.md
│   │   ├── F-14-jsonrpc-auth-boundary.md
│   │   ├── F-16-jwt-model.md
│   │   ├── F-17-permissive-cors.md
│   │   ├── F-18-python-exception-disclosure.md
│   │   └── N-01-network-inventory.md
│   ├── 00-executive-summary.md      # Plain-language summary for management
│   ├── 01-scope-and-methodology.md  # What was and was not tested
│   ├── 02-target-information.md     # Full device detail from evidence
│   ├── 03-findings-index.md         # Master findings table with CVSS
│   ├── 04-remediation-roadmap.md    # Phased remediation plan
│   ├── 05-cve-and-cwe-mapping.md    # CVE/CWE cross-reference
│   ├── 06-disclosure-and-legal.md   # Authorization and disclosure terms
│   ├── 07-evidence-guide.md         # How evidence files are structured
│   └── 08-screenshot-guide.md       # Screenshot capture and redaction steps
├── evidence/
│   ├── auth/
│   │   └── jwt-claims-decoded.txt
│   ├── cli/
│   │   ├── cfg-directory-listing.txt
│   │   ├── show-fdb.txt             # Pending
│   │   ├── show-iparp.txt           # Pending
│   │   ├── show-iproute.txt         # Pending
│   │   ├── show-ports-information.txt # Pending
│   │   ├── show-session.txt
│   │   ├── show-switch.txt
│   │   ├── show-version.txt
│   │   └── show-vlan.txt            # Pending
│   ├── http/
│   │   ├── js-internal-ip-leak.txt
│   │   ├── jsonrpc-200-exception.txt
│   │   ├── jsonrpc-401-anonymous.txt
│   │   ├── root-response-headers.txt
│   │   ├── terminal-plugin-response.txt
│   │   └── terminal-static-handler-response.txt
│   ├── network/
│   │   ├── nmap-http-scripts.txt
│   │   └── nmap-service-scan.txt
│   └── screenshots/
│       └── README.md
├── templates/
│   ├── evidence-header-template.txt
│   ├── finding-template.md
│   └── screenshot-redaction-checklist.md
├── tools/
│   └── redact-check.sh
├── .gitignore
├── CHANGELOG.md
├── LICENSE
└── README.md
```

---

## How to Read This Repo

1. **Start with the executive summary** — [docs/00-executive-summary.md](docs/00-executive-summary.md) — for a plain-language overview of risk and business impact.
2. **Review the findings index** — [docs/03-findings-index.md](docs/03-findings-index.md) — for the full table of findings sorted by severity with CVSS scores.
3. **Open any individual finding doc** in [docs/findings/](docs/findings/) to read the technical detail, observed evidence, impact, and remediation steps.
4. **Follow the evidence link** in each finding doc to the corresponding file in [evidence/](evidence/) to review the raw (redacted) output that supports the finding.

---

## Verification Commands

| Finding | Command | Expected Output |
|---|---|---|
| F-01 (firmware version) | `show version` (EXOS CLI) | Build date post-2023, version ≥ 22.7.1.4 after remediation |
| F-03 (HTTP accessible) | `curl -I http://10.1.58.1/` | `HTTP/1.1 200 OK` (pre-remediation) |
| F-02/F-03 (port 443 closed) | `nmap -p 443 10.1.58.1` | `443/tcp closed https` |
| Redact check | `./tools/redact-check.sh` | `[OK] No sensitive patterns detected.` |

---

## Remediation Priority

See [docs/04-remediation-roadmap.md](docs/04-remediation-roadmap.md) for the full phased plan. Top priorities:

- **Immediate:** Upgrade ExtremeXOS firmware to ≥ 22.7.1.4 (closes F-01, F-07, F-08 and removes five CVEs)
- **Immediate:** Disable Telnet (`disable telnet`), enable SSH2 (`enable ssh2`) — closes F-02
- **Immediate:** Rotate all credentials stored in primary.cfg before and after firmware upgrade
- **Short-term:** Fix configuration file and log directory permissions (F-10, F-11) — coordinate with Extreme TAC
- **Short-term:** Remediate CORS policy (F-17), add cookie flags (F-04), and add HTTP security headers (F-05)

---

## CVE/CWE Coverage

See [docs/05-cve-and-cwe-mapping.md](docs/05-cve-and-cwe-mapping.md) for the full CVE and CWE cross-reference table, including applicability basis and fixed versions.

---

## Evidence Integrity

- **Provenance headers** — every evidence file begins with a structured header identifying the collector, collection timestamp, target, method, authorization reference, and redactions applied. See [docs/07-evidence-guide.md](docs/07-evidence-guide.md).
- **Redaction convention** — sensitive values are replaced with `<REDACTED>` or `<REDACTED:tag:12hex>`. No live credentials appear anywhere in this repository.
- **Automated check** — `./tools/redact-check.sh` scans all tracked files for common credential patterns (JWT prefixes, session IDs, private keys, passwords). This check runs on every push and pull request via GitHub Actions.

---

## Screenshots

Screenshots are not committed to this repository pending redaction review. See:

- [evidence/screenshots/README.md](evidence/screenshots/README.md) — table of required screenshots with finding references and redaction requirements
- [docs/08-screenshot-guide.md](docs/08-screenshot-guide.md) — step-by-step capture and redaction instructions using Flameshot

---

## Disclaimer

> This assessment was conducted under explicit written authorization from the owner of the tested device. All testing was performed in a read-only, non-destructive manner. No exploit payloads were executed against the production device. Evidence files have been redacted to remove credentials and personally identifying information. This documentation is provided for remediation purposes only.
>
> The authors make no warranty, express or implied, regarding the completeness or accuracy of this assessment. Security assessments are point-in-time snapshots; the risk posture of the device may change at any time. A 90-day disclosure timeline is suggested from the test date (2026-10-20), after which unpatched findings may be disclosed per responsible disclosure norms. See [docs/06-disclosure-and-legal.md](docs/06-disclosure-and-legal.md) for the agreed timeline.

---

## Contact

Maintainer: `<MAINTAINER>`
