# F-03 — Chalet Served Over HTTP Only (Port 443 Closed)

| Field | Value |
|---|---|
| Severity | High |
| CVSS v3.1 | 7.4 — `AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:H/A:N` |
| CWE | CWE-319 — Cleartext Transmission of Sensitive Information, CWE-614 |
| CVE | None assigned |
| Status | Confirmed |
| Affected component | Chalet Web Interface (CherryPy on TCP port 80) |
| Evidence | [nmap-service-scan.txt](../../evidence/network/nmap-service-scan.txt), [root-response-headers.txt](../../evidence/http/root-response-headers.txt) |

## Summary

The Chalet web management interface is accessible only over cleartext HTTP on TCP port 80. HTTPS (port 443) is closed, forcing all browser management traffic, session cookies, and authentication tokens to traverse the network unencrypted.

## Technical detail

Nmap service scanning identified port 80 open (CherryPy wsgiserver) and port 443 absent/closed. Direct HTTP requests return standard web management responses with authentication cookies transmitted over cleartext HTTP:
```text
HTTP/1.1 200 OK
Content-Type: text/html;charset=utf-8
Set-Cookie: session_id=<REDACTED>; expires=...; Path=/
```
Because TLS is completely absent, authentication tokens (`x-auth-token`, `session`) and user credentials are subject to passive network eavesdropping and active machine-in-the-middle manipulation.

## Evidence

> 80/tcp open  http    CherryPy wsgiserver

Full raw evidence: [nmap-service-scan.txt](../../evidence/network/nmap-service-scan.txt), [root-response-headers.txt](../../evidence/http/root-response-headers.txt)

## Impact

Network-adjacent adversaries can intercept web authentication tokens, hijack active operator sessions, view real-time port utilization data, and alter switch state without knowledge of the operator's password.

## Remediation

1. Generate or import a trusted TLS certificate onto the switch.
2. Enable secure web management:
   ```text
   configure web https enable
   ```
3. Disable cleartext web management or configure a strict HTTP-to-HTTPS redirect:
   ```text
   configure web http disable
   ```

## Verification

Test HTTPS accessibility and HTTP termination:
```bash
curl -k -I https://10.1.58.1/
```
Expected output: `HTTP/1.1 200 OK` over TLS, while HTTP requests fail to connect or redirect with `301/302`.

## References

- [CWE-319](https://cwe.mitre.org/data/definitions/319.html)
- [CWE-614](https://cwe.mitre.org/data/definitions/614.html)
