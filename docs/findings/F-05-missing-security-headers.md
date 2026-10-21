# F-05 — Missing HTTP Security Headers

| Field | Value |
|---|---|
| Severity | Medium |
| CVSS v3.1 | 5.3 — `AV:N/AC:L/PR:N/UI:R/S:U/C:N/I:L/A:N` |
| CWE | CWE-693 — Protection Mechanism Failure |
| CVE | None assigned |
| Status | Confirmed |
| Affected component | Chalet HTTP Server Configuration |
| Evidence | [root-response-headers.txt](../../evidence/http/root-response-headers.txt) |

## Summary

The Chalet web server fails to implement standard defensive HTTP response headers, including Content Security Policy (CSP), X-Frame-Options, X-Content-Type-Options, and HTTP Strict Transport Security (HSTS).

## Technical detail

Header analysis of HTTP responses from `http://10.1.58.1/` reveals the complete absence of defensive response headers:
```text
HTTP/1.1 200 OK
Date: Tue, 20 Oct 2026 12:55:24 GMT
Content-Length: 18910
Content-Type: text/html;charset=utf-8
Set-Cookie: session_id=<REDACTED>; expires=...; Path=/
Connection: close
```
Specifically absent:
- `Content-Security-Policy`: No restrictions on script execution sources.
- `X-Frame-Options`: Interface can be framed by arbitrary external origins, enabling clickjacking.
- `X-Content-Type-Options: nosniff`: Browsers may MIME-sniff response payloads.
- `Strict-Transport-Security`: No enforcement of secure HTTPS transport.

## Evidence

> Content-Type: text/html;charset=utf-8
> (Defensive headers completely absent)

Full raw evidence: [root-response-headers.txt](../../evidence/http/root-response-headers.txt)

## Impact

Absence of defensive headers enables framing of the management UI (clickjacking), simplifies cross-site scripting exploitation, and leaves web sessions vulnerable to protocol downgrade attacks.

## Remediation

Configure the Chalet web server (CherryPy) to return the following baseline headers with every response:
```text
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
Content-Security-Policy: default-src 'self'; script-src 'self' 'unsafe-inline';
Strict-Transport-Security: max-age=31536000; includeSubDomains (once HTTPS enabled)
```

## Verification

Query the web server and verify header presence:
```bash
curl -I http://10.1.58.1/
```
Expected output: Headers `X-Frame-Options`, `X-Content-Type-Options`, and `Content-Security-Policy` are present in response.

## References

- [CWE-693](https://cwe.mitre.org/data/definitions/693.html)
