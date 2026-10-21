# F-08 — Terminal Static Handler Unauthenticated (`/terminal/_static/`)

| Field | Value |
|---|---|
| Severity | High |
| CVSS v3.1 | 7.5 — `AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N` |
| CWE | CWE-22 — Path Traversal |
| CVE | CVE-2023-43121 |
| Status | Confirmed (exposure) |
| Affected component | `/terminal/_static/` static file handler |
| Evidence | [terminal-static-handler-response.txt](../../evidence/http/terminal-static-handler-response.txt) |

## Summary

The `/terminal/_static/` endpoint serves files without authentication. On ExtremeXOS firmware builds prior to 22.7.1.4, this handler is vulnerable to unauthenticated arbitrary file read via path traversal (CVE-2023-43121).

> **Note:** Traversal was NOT attempted; exposure is established by handler reachability + firmware version (F-01).

## Technical detail

HTTP probing verified that the `/terminal/_static/` handler responds to unauthenticated HTTP requests:
```text
HTTP/1.1 200 OK
Content-Type: text/html
```
Under CVE-2023-43121, this static file handler fails to properly sanitize dot-dot-slash (`../`) directory traversal sequences, enabling unauthenticated remote attackers to read arbitrary files from the underlying Linux operating system.

> **Not verified — out of scope:** Active exploitation of directory traversal was explicitly omitted to protect switch stability and prevent unauthorized extraction of system files.

## Evidence

> Unauthenticated access confirmed to /terminal/_static/ handler on affected firmware build

Full raw evidence: [terminal-static-handler-response.txt](../../evidence/http/terminal-static-handler-response.txt)

## Impact

An unauthenticated remote attacker can read sensitive files from the switch filesystem, including `/usr/local/cfg/primary.cfg` (which contains account credentials and network configurations).

## Remediation

1. Upgrade ExtremeXOS to version `22.7.1.4` or higher.
2. Restrict access to the management plane via network ACLs.

## Verification

Test static handler accessibility post-upgrade:
```bash
curl -I http://10.1.58.1/terminal/_static/
```
Expected output: `401 Unauthorized` or `404 Not Found`.

## References

- [NVD — CVE-2023-43121](https://nvd.nist.gov/vuln/detail/CVE-2023-43121)
- [CWE-22](https://cwe.mitre.org/data/definitions/22.html)
