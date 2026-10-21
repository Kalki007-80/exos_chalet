# F-01 — Outdated ExtremeXOS Build (Feb 2020) Predating 2023 Chalet Fixes

| Field | Value |
|---|---|
| Severity | Critical |
| CVSS v3.1 | 9.8 — `AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H` |
| CWE | CWE-1104 — Use of Unmaintained Third-Party Component |
| CVE | CVE-2023-43118, CVE-2023-43119, CVE-2023-43120, CVE-2023-43121, CVE-2020-18305 |
| Status | Confirmed (version-based) |
| Affected component | ExtremeXOS core image / Chalet Web UI |
| Evidence | [show-version.txt](../../evidence/cli/show-version.txt) |

## Summary

The switch runs ExtremeXOS version `22.7.1.2-patch1-24`, compiled on February 25, 2020. This build predates critical security patches released in 2023 and is inside the published affected-version range for CVE-2023-43118, CVE-2023-43119, CVE-2023-43120, CVE-2023-43121, and CVE-2020-18305. None of these CVEs were exploited in this assessment; applicability is established by version comparison only.

## Technical detail

CLI version output confirms the target firmware version:
```text
Image : ExtremeXOS version 22.7.1.2 22.7.1.2-patch1-24 by release-manager on Tue Feb 25 15:17:20 EST 2020
```

Extreme Networks addressed five significant vulnerabilities in subsequent maintenance patches (version 22.7.1.4 and later):
- **CVE-2023-43118**: Cross-Site Request Forgery (CSRF) leading to Remote Code Execution via Chalet.
- **CVE-2023-43119**: Arbitrary file read in the web interface.
- **CVE-2023-43120**: Server-Side Request Forgery (SSRF) in web endpoints.
- **CVE-2023-43121**: Path traversal in the CLI Terminal plugin (`/terminal/_static/`).
- **CVE-2020-18305**: Client-side enforcement of authorization controls.

Running a firmware build over six years old exposes the switch management plane to risks associated with these unpatched vulnerabilities. The build falls inside the published affected-version range for CVE-2023-43118, CVE-2023-43119, CVE-2023-43120, CVE-2023-43121, and CVE-2020-18305. None of these CVEs were exploited in this assessment; applicability is established by version comparison only.

## Evidence

> Image   : ExtremeXOS version 22.7.1.2 22.7.1.2-patch1-24 by release-manager
>           on Tue Feb 25 15:17:20 EST 2020

Full raw evidence: [show-version.txt](../../evidence/cli/show-version.txt)

## Impact

The firmware is inside the published affected-version range for CVE-2023-43118, CVE-2023-43119, CVE-2023-43120, CVE-2023-43121, and CVE-2020-18305. None of these CVEs were exploited in this assessment; applicability is established by version comparison only. If exploited in an unpatched environment, these vulnerabilities could allow unauthorized remote command execution, file disclosure, or request forgery.

## Remediation

1. Upgrade ExtremeXOS to the latest supported patch release on the 22.7 branch (minimum `22.7.1.4` or higher) or migrate to a currently maintained major release.
2. Back up `primary.cfg` to an external, permission-controlled server prior to initiating the upgrade.
3. Review Extreme Networks release notes for platform-specific upgrade paths and BootROM prerequisites.

## Verification

Execute `show version` in the EXOS CLI to verify the upgraded version string and build date:
```text
show version
```
Expected output: Version `22.7.1.4` or later with build timestamp postdating 2023.

## References

- [NVD — CVE-2023-43118](https://nvd.nist.gov/vuln/detail/CVE-2023-43118)
- [NVD — CVE-2023-43121](https://nvd.nist.gov/vuln/detail/CVE-2023-43121)
- [CWE-1104](https://cwe.mitre.org/data/definitions/1104.html)
