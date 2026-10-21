# F-10 — `primary.cfg` Mode 0666 (World Readable and Writable)

| Field | Value |
|---|---|
| Severity | High |
| CVSS v3.1 | 7.1 — `AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:N` |
| CWE | CWE-732 — Incorrect Permission Assignment for Critical Resource |
| CVE | None assigned |
| Status | Confirmed |
| Affected component | `/usr/local/cfg/primary.cfg` |
| Evidence | [cfg-directory-listing.txt](../../evidence/cli/cfg-directory-listing.txt) |

## Summary

The primary switch configuration file (`primary.cfg`) has world-readable and world-writable file permissions (`-rw-rw-rw-`, mode 0666). Any local system process or low-privilege user can read or overwrite the switch configuration.

## Technical detail

Directory listing of `/usr/local/cfg/` captured during an authenticated CLI session shows:
```text
-rw-rw-rw-    1 admin    admin      1219707 Sep 23 12:32 primary.cfg
```
Because the file is mode 0666, it can be read and written by any process running under any user ID on the switch operating system. `primary.cfg` contains complete switch configurations, including local account credentials, SNMP community strings, and network topology configurations.

## Evidence

> -rw-rw-rw-    1 admin    admin      1219707 Sep 23 12:32 primary.cfg

Full raw evidence: [cfg-directory-listing.txt](../../evidence/cli/cfg-directory-listing.txt)

## Impact

Any low-privilege account or compromised daemon on the switch can read sensitive credentials or modify the configuration to introduce backdoors, disable security features, or create denial-of-service conditions.

## Remediation

1. Restrict permissions on `primary.cfg` to root/admin only:
   ```bash
   chmod 0600 /usr/local/cfg/primary.cfg
   ```
2. Coordinate with Extreme Networks TAC to ensure permission changes persist across system reboots and firmware updates.
3. Rotate all credentials, passwords, and SNMP secrets stored in `primary.cfg`.

## Verification

Inspect file permissions via CLI:
```text
ls -la /usr/local/cfg/primary.cfg
```
Expected output: `-rw-------` (mode 0600).

## References

- [CWE-732](https://cwe.mitre.org/data/definitions/732.html)
