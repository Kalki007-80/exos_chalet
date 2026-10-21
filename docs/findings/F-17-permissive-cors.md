# F-17 — Permissive CORS on /jsonrpc (`*` + Allow-Credentials: true)

| Field | Value |
|---|---|
| Severity | High |
| CVSS v3.1 | 7.3 — `AV:N/AC:L/PR:N/UI:R/S:U/C:H/I:L/A:N` |
| CWE | CWE-942 — Permissive Cross-domain Policy with Untrusted Domains |
| CVE | CVE-2023-43118 (amplified) |
| Status | Confirmed |
| Affected component | `/jsonrpc` CORS Response Headers |
| Evidence | [jsonrpc-401-anonymous.txt](../../evidence/http/jsonrpc-401-anonymous.txt), [jsonrpc-200-exception.txt](../../evidence/http/jsonrpc-200-exception.txt) |

## Summary

The `/jsonrpc` endpoint serves overly permissive Cross-Origin Resource Sharing (CORS) headers, specifying wildcard origin (`*`), `Access-Control-Allow-Credentials: true`, and allowing cross-origin `x-auth-token` headers across all responses (including 200, 401, and 500).

## Technical detail

Every response from `/jsonrpc` contains the following headers:
```text
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *
Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept, x-auth-token, Authorization
```
While standard browser implementations block credentialed requests to wildcard `*`, this configuration signals a design intention of universal trust and allows explicit cross-origin transmission of `x-auth-token`. Combined with missing `SameSite` cookie flags ([F-04](F-04-cookie-flags.md)), this materially amplifies Cross-Site Request Forgery risks (CVE-2023-43118).

## Evidence

> Access-Control-Allow-Credentials: true
> Access-Control-Allow-Origin: *

Full raw evidence: [jsonrpc-401-anonymous.txt](../../evidence/http/jsonrpc-401-anonymous.txt), [jsonrpc-200-exception.txt](../../evidence/http/jsonrpc-200-exception.txt)

## Impact

Facilitates cross-origin browser attacks and amplifies the impact of CVE-2023-43118 (CSRF to RCE).

## Remediation

1. Restrict `Access-Control-Allow-Origin` to the switch's own origin (`http://10.1.58.1` or `https://10.1.58.1`).
2. Disallow arbitrary external origins and remove `Access-Control-Allow-Credentials: true` if wildcarding is used.

## Verification

Send a CORS preflight request with an untrusted origin:
```bash
curl -H "Origin: http://evil.example" -I http://10.1.58.1/jsonrpc
```
Expected output: No wildcard origin header returned.

## References

- [CWE-942](https://cwe.mitre.org/data/definitions/942.html)
- [NVD — CVE-2023-43118](https://nvd.nist.gov/vuln/detail/CVE-2023-43118)
