# F-04 — Auth Cookies Lack Secure, HttpOnly, and SameSite Flags

| Field | Value |
|---|---|
| Severity | Medium |
| CVSS v3.1 | 5.3 — `AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N` |
| CWE | CWE-1004 — Sensitive Cookie Without 'HttpOnly' Flag, CWE-614 |
| CVE | None assigned |
| Status | Confirmed |
| Affected component | Chalet Session Management / `Set-Cookie` Header |
| Evidence | [root-response-headers.txt](../../evidence/http/root-response-headers.txt), [nmap-http-scripts.txt](../../evidence/network/nmap-http-scripts.txt) |

## Summary

Cookies issued by the Chalet web management interface — including pre-authentication session identifiers and post-authentication tokens — omit the `Secure`, `HttpOnly`, and `SameSite` protective attributes.

## Technical detail

HTTP response inspection shows `session_id` cookies issued without security flags:
```text
Set-Cookie: session_id=<REDACTED>; expires=Tue, 20 Oct 2026 14:40:14 GMT; Path=/
```
Inspection of authenticated sessions via browser DevTools confirmed that `x-auth-token`, `session`, and `PYXTERM_AUTH` likewise lack these attributes:
- **Missing `HttpOnly`**: Allows client-side JavaScript to read and exfiltrate authentication cookies in the event of cross-site scripting (XSS).
- **Missing `Secure`**: Allows cookies to be transmitted over unencrypted HTTP connections.
- **Missing `SameSite`**: Allows the browser to include authentication cookies in cross-origin requests, directly facilitating Cross-Site Request Forgery (CSRF).

## Evidence

> Set-Cookie: session_id=<REDACTED>; expires=...; Path=/

Full raw evidence: [root-response-headers.txt](../../evidence/http/root-response-headers.txt)

## Impact

Lack of cookie protections significantly lowers the barrier for session hijacking via XSS, network sniffing, and CSRF attacks (amplifying CVE-2023-43118).

## Remediation

1. Configure the web application server to append `; Secure; HttpOnly; SameSite=Strict` to all session and authentication cookies.
2. Invalidate sessions server-side immediately upon logout.

## Verification

Inspect response headers on cookie issuance:
```bash
curl -sS -D - http://10.1.58.1/ -o /dev/null | grep -i "Set-Cookie"
```
Expected output: Cookies include `Secure; HttpOnly; SameSite=Strict`.

## References

- [CWE-1004](https://cwe.mitre.org/data/definitions/1004.html)
- [CWE-614](https://cwe.mitre.org/data/definitions/614.html)
