# F-16 — JWT Authentication Model Observations

| Field | Value |
|---|---|
| Severity | Medium |
| CVSS v3.1 | 5.9 — `AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:N/A:N` |
| CWE | CWE-522 — Insufficiently Protected Credentials, CWE-326 |
| CVE | — |
| Status | Confirmed |
| Affected component | Chalet Authentication Subsystem |
| Evidence | [jwt-claims-decoded.txt](../../evidence/auth/jwt-claims-decoded.txt) |

## Summary

The session uses an HS256 JWT carried in two cookies (`x-auth-token` and `session`) with identical values. The token has a 24-hour lifetime (`iat` → `exp` = 86,400 s) and no visible refresh mechanism. Because HS256 is symmetric, the `access_level` claim inside the token is only as trustworthy as the signing key; if that key is weak, default, or shared across devices, a `user` token can be forged to `admin`. The duplicate cookie also doubles the exposure surface. `PYXTERM_AUTH` is a separate 32-hex token used by the terminal plugin; its generation and lifetime should be documented by the vendor.

## Technical detail

Decoded JWT header and payload inspection shows:
```json
Header:  {"alg":"HS256","typ":"JWT"}
Payload: {"username":"<REDACTED>","access_level":"user"}
```
Security observations:
- **Symmetric HS256**: If the HMAC secret key is static, default, or extracted from firmware, an attacker can forge arbitrary tokens with `access_level: "admin"`.
- **24-Hour Expiration**: The token lifetime (86,400 seconds) provides an excessively long window of exposure if a token is intercepted.
- **Cookie Redundancy**: Identical JWT values are transmitted simultaneously in both `x-auth-token` and `session` cookies.

## Evidence

> Decoded payload carries access_level: "user" under HS256 signature algorithm

Full raw evidence: [jwt-claims-decoded.txt](../../evidence/auth/jwt-claims-decoded.txt)

## Impact

Potential token forgery if HMAC keys are compromised, prolonged session hijacking windows, and unnecessary exposure across multiple cookie parameters.

## Remediation

1. Verify that HMAC secret keys are generated with high entropy per device and rotated upon reboot.
2. Consider migrating to asymmetric signing (RS256).
3. Reduce token lifetime to 1 hour with a secure refresh mechanism.

## Verification

Inspect token headers and lifetimes via DevTools or decoded claims file.

## References

- [CWE-522](https://cwe.mitre.org/data/definitions/522.html)
- [CWE-326](https://cwe.mitre.org/data/definitions/326.html)
