# F-14 — /jsonrpc Accepts User JWT; Role Filtering Inconclusive

| Field | Value |
|---|---|
| Severity | Medium |
| CVSS v3.1 | 5.3 — `AV:N/AC:L/PR:L/UI:N/S:U/C:L/I:L/A:N` |
| CWE | CWE-269 — Improper Privilege Management |
| CVE | CVE-2020-18305 (conditional) |
| Status | **Inconclusive** |
| Affected component | `/jsonrpc` API Endpoint |
| Evidence | [jsonrpc-200-exception.txt](../../evidence/http/jsonrpc-200-exception.txt), [jwt-claims-decoded.txt](../../evidence/auth/jwt-claims-decoded.txt) |

## Summary

The `/jsonrpc` API endpoint accepted an authenticated request bearing a user-level JWT (`access_level: "user"`) with HTTP 200 OK, reaching the internal `cli()` dispatcher. Whether administrative role boundaries are enforced downstream could not be confirmed because parameter mismatch triggered an internal exception.

## Technical detail

A read-only API probe with a valid user-role JWT returned HTTP 200 OK:
```text
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 199
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: *

{
  "error": {
    "code": 500,
    "data": null,
    "message": "OtherError: cli() got an unexpected keyword argument 'command'",
    "name": "OtherError"
  },
  "id": "1",
  "jsonrpc": "2.0"
}
```
Key observations:
1. The request was not rejected with 401 or 403; the token authentication gate passed.
2. Method invocation reached the internal Python `cli()` function handler.
3. The method rejected parameter name `'command'`. Further parameter enumeration was deliberately suspended to avoid fuzzing a live core switch.

> **Not verified — out of scope:** Whether the backend enforces role boundaries when given valid method parameters remains **Inconclusive**. A lab replica test of build 22.7.1.2 is required to definitively close this finding.

## Evidence

> HTTP/1.1 200 OK with OtherError: cli() got an unexpected keyword argument 'command'

Full raw evidence: [jsonrpc-200-exception.txt](../../evidence/http/jsonrpc-200-exception.txt)

## Impact

If backend methods lack role enforcement, a user-level account could execute privileged administrative commands via `/jsonrpc` (confirming CVE-2020-18305). If role filtering is enforced downstream, the risk is Low.

## Remediation

1. Verify that the JSON-RPC dispatcher validates `access_level` on all administrative methods.
2. Return explicit `403 Forbidden` for unauthorized method calls.

## Verification

Perform controlled parameter testing against an isolated lab image of ExtremeXOS 22.7.1.2.

## References

- [NVD — CVE-2020-18305](https://nvd.nist.gov/vuln/detail/CVE-2020-18305)
- [CWE-269](https://cwe.mitre.org/data/definitions/269.html)
