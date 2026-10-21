# F-12 — Non-Standard Executables in Configuration Directory

| Field | Value |
|---|---|
| Severity | Info |
| CVSS v3.1 | 0.0 — `None` |
| CWE | CWE-1188 — Insecure Default Initialization of Resource |
| CVE | — |
| Status | Presence confirmed |
| Affected component | `/usr/local/cfg/` filesystem directory |
| Evidence | [cfg-directory-listing.txt](../../evidence/cli/cfg-directory-listing.txt) |

## Summary

Two Python files (`shell.py`, `testme.py`) and one directory (`vmt/`) are present in `/usr/local/cfg/`. None are part of a stock EXOS image. They are `admin`-owned and dated March/June 2026 — after the Feb-2020 build date. Origin was not determined. They were NOT executed during this assessment. Recommend the device owner identify their origin; if they were not placed by an administrator, treat as indicators of prior activity.

## Technical detail

Directory inspection identified three unexpected entries:
```text
-rw-r--r--    1 admin    admin          306 Mar 18  2026 shell.py
-rw-r--r--    1 admin    admin           79 Mar 18  2026 testme.py
drwxr-xr-x    2 root     root          1024 Jun  6 21:33 vmt
```

> **Not verified — out of scope:** File contents were not read and execution was not attempted.

## Evidence

> -rw-r--r--    1 admin    admin          306 Mar 18  2026 shell.py
> -rw-r--r--    1 admin    admin           79 Mar 18  2026 testme.py
> drwxr-xr-x    2 root     root          1024 Jun  6 21:33 vmt

Full raw evidence: [cfg-directory-listing.txt](../../evidence/cli/cfg-directory-listing.txt)

## Impact

The presence of non-standard Python scripts in the configuration directory may represent previous administrative testing artifacts or potential indicators of prior activity.

## Remediation

1. Review file contents and origins with Extreme Networks TAC and device administrators.
2. Archive and remove unauthorized files from production storage.

## Verification

Audit directory contents against known standard baselines:
```text
ls -la /usr/local/cfg/
```

## References

- [CWE-1188](https://cwe.mitre.org/data/definitions/1188.html)
