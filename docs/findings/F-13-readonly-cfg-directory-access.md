# F-13 — User Role Browses `/usr/local/cfg`

| Field | Value |
|---|---|
| Severity | High |
| CVSS v3.1 | 7.1 — `AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:L/A:N` |
| CWE | CWE-269 — Improper Privilege Management |
| CVE | None assigned |
| Status | Confirmed |
| Affected component | EXOS CLI Shell / User Role Permissions |
| Evidence | [cfg-directory-listing.txt](../../evidence/cli/cfg-directory-listing.txt), [show-session.txt](../../evidence/cli/show-session.txt) |

## Summary

An operator authenticated strictly with read-only `user` privileges is able to browse `/usr/local/cfg/`, list directory contents, and observe all configuration and backup filenames.

## Technical detail

Session tracking confirms the active CLI session authenticated under the low-privilege `user` account:
```text
    #     Login Time               User  Type   Auth  Auth Location
*901      Tue Oct 20 21:54:01 2026 user  telnet local dis   10.1.58.XXX
```
Despite holding only `user` permissions, the session executed `ls -la /usr/local/cfg/` without restriction. In combination with [F-10](F-10-primary-cfg-permissions.md) (mode 0666 on `primary.cfg`), a low-privilege user can read the entire switch configuration.

## Evidence

> Session authenticated as 'user' successfully listed /usr/local/cfg contents

Full raw evidence: [cfg-directory-listing.txt](../../evidence/cli/cfg-directory-listing.txt), [show-session.txt](../../evidence/cli/show-session.txt)

## Impact

Enables low-privilege users to view sensitive filenames, assess configuration state, and read world-readable configuration files.

## Remediation

1. Restrict CLI command permissions for the `user` role so filesystem directory traversal is disallowed.
2. Correct underlying file permissions on configuration files (see F-10).

## Verification

Attempt directory listing from an authenticated `user` session:
```text
ls /usr/local/cfg
```
Expected output: Permission denied.

## References

- [CWE-269](https://cwe.mitre.org/data/definitions/269.html)
