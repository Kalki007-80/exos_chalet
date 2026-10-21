# F-11 — `cc_logs/` Mode 0777 (World-Writable)

| Field | Value |
|---|---|
| Severity | High |
| CVSS v3.1 | 7.1 — `AV:L/AC:L/PR:L/UI:N/S:U/C:N/I:H/A:H` |
| CWE | CWE-732 — Incorrect Permission Assignment for Critical Resource |
| CVE | None assigned |
| Status | Confirmed |
| Affected component | `/usr/local/cfg/cc_logs/` directory |
| Evidence | [cfg-directory-listing.txt](../../evidence/cli/cfg-directory-listing.txt) |

## Summary

The configuration log directory `/usr/local/cfg/cc_logs` has world-writable permissions (`drwxrwxrwx`, mode 0777). Any local user or process can create, modify, or delete log files stored in this directory.

## Technical detail

Directory inspection reveals unrestricted directory permissions on the log directory:
```text
drwxrwxrwx    2 root     root          1024 Apr 23  2020 cc_logs
```
Unrestricted write permissions allow low-privilege actors to delete audit logs, overwrite forensic evidence, or plant symlinks targeting other administrative files.

## Evidence

> drwxrwxrwx    2 root     root          1024 Apr 23  2020 cc_logs

Full raw evidence: [cfg-directory-listing.txt](../../evidence/cli/cfg-directory-listing.txt)

## Impact

An attacker with local system access can tamper with system logs, conceal unauthorized configuration changes, or disrupt logging daemons.

## Remediation

1. Restrict directory permissions:
   ```bash
   chmod 0750 /usr/local/cfg/cc_logs
   ```
2. Confirm ownership is assigned to `root:admin`.

## Verification

Inspect directory permissions via CLI:
```text
ls -la /usr/local/cfg
```
Expected output: `drwxr-x---` (mode 0750) for `cc_logs`.

## References

- [CWE-732](https://cwe.mitre.org/data/definitions/732.html)
