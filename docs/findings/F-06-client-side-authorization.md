# F-06 — Client-Side-Only Authorization (`ng-show="accessRight==='readWrite'"`)

| Field | Value |
|---|---|
| Severity | Medium |
| CVSS v3.1 | 5.3 — `AV:N/AC:L/PR:L/UI:N/S:U/C:L/I:L/A:N` |
| CWE | CWE-602 — Client-Side Enforcement of Server-Side Security |
| CVE | CVE-2020-18305 (conditional) |
| Status | Confirmed (UI) |
| Affected component | Chalet AngularJS Front-end Routing |
| Evidence | [root-response-headers.txt](../../evidence/http/root-response-headers.txt) |

## Summary

The Chalet web interface restricts access to sensitive administrative features (User Accounts, File Manager, and Configuration) entirely within client-side AngularJS directives (`ng-show="accessRight==='readWrite'"`).

## Technical detail

DOM inspection of the Chalet management interface indicates that navigation menu items for administrative functions are hidden from read-only users using client-side directives:
```html
<li ng-show="accessRight==='readWrite'"><a ui-sref="admin.userAccounts">User Accounts</a></li>
<li ng-show="accessRight==='readWrite'"><a ui-sref="apps.fileList">File Manager</a></li>
<li ng-show="accessRight==='readWrite'"><a ui-sref="chaletConfig">Chalet Configuration</a></li>
```
Direct HTTP GET requests to these paths return `404 Not Found` because they are client-side UI-Router state definitions, not server endpoints. Consequently, the only boundary preventing a low-privilege user from viewing or initiating these workflows is client-side JavaScript execution. Backend API authorization relies on whether the `/jsonrpc` dispatcher enforces role boundaries (see [F-14](F-14-jsonrpc-auth-boundary.md)).

> **Not verified — out of scope:** Whether `/jsonrpc` validates role permissions for every administrative method was not fully verified due to parameter signature limitations (see F-14).

## Evidence

> Direct GET to /admin/userAccounts returns 404; state toggles solely via client-side AngularJS `ng-show="accessRight==='readWrite'"`

Full raw evidence: [root-response-headers.txt](../../evidence/http/root-response-headers.txt)

## Impact

If backend API methods fail to enforce server-side role validation, an authenticated low-privilege operator can bypass UI restrictions to manipulate administrative accounts and device configuration.

## Remediation

1. Implement strict server-side authorization checks on all JSON-RPC methods and API handlers.
2. Treat client-side UI visibility toggles purely as presentation conveniences, never as security boundaries.

## Verification

Submit a privileged JSON-RPC request using an authenticated `user` role token:
```bash
# Privileged API call should receive explicit 403 Forbidden
```

## References

- [CWE-602](https://cwe.mitre.org/data/definitions/602.html)
- [NVD — CVE-2020-18305](https://nvd.nist.gov/vuln/detail/CVE-2020-18305)
