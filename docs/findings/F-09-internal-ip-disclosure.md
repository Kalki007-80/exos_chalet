# F-09 — Internal IPs Hardcoded in `chalet.min.js`

| Field | Value |
|---|---|
| Severity | Low |
| CVSS v3.1 | 3.7 — `AV:N/AC:H/PR:N/UI:N/S:U/C:L/I:N/A:N` |
| CWE | CWE-200 — Exposure of Sensitive Information to an Unauthorized Actor |
| CVE | None assigned |
| Status | Confirmed |
| Affected component | `/chalet.min.js` client-side script |
| Evidence | [js-internal-ip-leak.txt](../../evidence/http/js-internal-ip-leak.txt) |

## Summary

The unauthenticated client-side JavaScript file `chalet.min.js` contains hardcoded internal IPv4 addresses, disclosing details of internal network topology.

## Technical detail

Static inspection of client-side assets retrieved from the web interface revealed four hardcoded internal IPv4 addresses embedded in application scripts:
```text
192.168.0.1
192.168.1.1
10.0.0.1
172.16.0.1
```
These addresses are accessible to any unauthenticated client retrieving the web interface scripts.

## Evidence

> Disclosed internal IPv4 addresses identified in chalet.min.js

Full raw evidence: [js-internal-ip-leak.txt](../../evidence/http/js-internal-ip-leak.txt)

## Impact

Disclosed IP addressing schemes facilitate internal reconnaissance and targeted lateral movement.

## Remediation

Refactor front-end scripts to use dynamic configuration or relative paths rather than hardcoded internal IP strings.

## Verification

Inspect `chalet.min.js` post-patch:
```bash
curl -s http://10.1.58.1/chalet.min.js | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
```
Expected output: No sensitive internal addressing disclosed.

## References

- [CWE-200](https://cwe.mitre.org/data/definitions/200.html)
