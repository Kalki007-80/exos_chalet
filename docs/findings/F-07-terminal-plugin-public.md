# F-07 — CLI Terminal Plugin Publicly Served (Last-Modified 2019-03-07)

| Field | Value |
|---|---|
| Severity | High |
| CVSS v3.1 | 7.5 — `AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N` |
| CWE | CWE-284 — Improper Access Control |
| CVE | — |
| Status | Confirmed |
| Affected component | Chalet Terminal Plugin (`/terminal/`, `/plugins/terminal/`) |
| Evidence | [terminal-plugin-response.txt](../../evidence/http/terminal-plugin-response.txt) |

## Summary

The Chalet CLI web terminal plugin is accessible without authentication. The static assets carry a timestamp of March 7, 2019, confirming that an outdated, unmaintained terminal component is exposed directly to the network.

> **Note:** This finding is a precondition for CVE-2023-43120 and CVE-2023-43121 but is not itself assigned a CVE.

## Technical detail

HTTP inspection of `/terminal/` confirms that the plugin interface responds to unauthenticated requests:
```text
HTTP/1.1 200 OK
Date: Tue, 20 Oct 2026 13:21:44 GMT
Content-Length: 1774
Content-Type: text/html
Last-Modified: Thu, 07 Mar 2019 19:25:28 GMT
```
The build timestamp (`2019-03-07`) predates both the 2020 firmware image build and the 2023 security advisories.

## Evidence

> Last-Modified: Thu, 07 Mar 2019 19:25:28 GMT

Full raw evidence: [terminal-plugin-response.txt](../../evidence/http/terminal-plugin-response.txt)

## Impact

Unauthenticated access to the terminal plugin exposes web terminal assets directly to the network without authentication controls, serving as an operational entry point for downstream terminal handler exploitation.

## Remediation

1. Upgrade ExtremeXOS firmware to version 22.7.1.4 or higher to apply vendor patches.
2. If web terminal capabilities are not strictly required for operations, disable the terminal plugin via EXOS CLI or web configuration.

## Verification

Request the terminal plugin endpoint without authentication:
```bash
curl -I http://10.1.58.1/terminal/
```
Expected output: `401 Unauthorized`, `403 Forbidden`, or `404 Not Found`.

## References

- [CWE-284](https://cwe.mitre.org/data/definitions/284.html)
