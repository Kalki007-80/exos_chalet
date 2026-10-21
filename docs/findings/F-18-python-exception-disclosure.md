# F-18 — Python Exception Disclosure on /jsonrpc (`cli()` Signature)

| Field | Value |
|---|---|
| Severity | Medium |
| CVSS v3.1 | 4.3 — `AV:N/AC:L/PR:L/UI:N/S:U/C:L/I:N/A:N` |
| CWE | CWE-209 — Generation of Error Message Containing Sensitive Information, CWE-200 |
| CVE | None assigned |
| Status | Confirmed |
| Affected component | `/jsonrpc` Error Handler |
| Evidence | [jsonrpc-200-exception.txt](../../evidence/http/jsonrpc-200-exception.txt) |

## Summary

The `/jsonrpc` endpoint returns verbose internal Python exception strings in HTTP 200 JSON responses, disclosing internal function names and calling parameter signatures.

## Technical detail

When sent an authenticated JSON-RPC request with unexpected parameter formatting, the API returned:
```json
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
This discloses that the backend runs Python, exposes the internal handler function name (`cli()`), and informs attackers that `'command'` is an invalid keyword argument, facilitating reverse-engineering of the internal API surface.

## Evidence

> message: "OtherError: cli() got an unexpected keyword argument 'command'"

Full raw evidence: [jsonrpc-200-exception.txt](../../evidence/http/jsonrpc-200-exception.txt)

## Impact

Leaks implementation details to authenticated clients, assisting adversaries in mapping backend API parameters.

## Remediation

Catch general exceptions at the JSON-RPC dispatcher level and return generic error messages:
```json
{"error": {"code": -32603, "message": "Internal error"}}
```

## Verification

Submit a malformed request to `/jsonrpc`:
```bash
curl -s -X POST http://10.1.58.1/jsonrpc -H 'Content-Type: application/json' --data '{"jsonrpc":"2.0","id":"1","method":"cli"}'
```
Expected output: Generic error payload without Python tracebacks or parameter names.

## References

- [CWE-209](https://cwe.mitre.org/data/definitions/209.html)
- [CWE-200](https://cwe.mitre.org/data/definitions/200.html)
