# Evidence Guide

This document describes how evidence was collected, formatted, verified, and protected throughout the assessment.

## Provenance Header

Every raw evidence artifact in the `evidence/` directory begins with a structured provenance header adhering to [templates/evidence-header-template.txt](../../templates/evidence-header-template.txt):

```text
# Evidence: <Descriptive title>
Finding ID:      F-XX, F-YY
Collected:       <ISO-8601 timestamp with timezone>
Collector:       <Tester handle>
Target:          10.1.58.1 (POWERHOUSE-1-CORE)
Method:          <Specific CLI command, curl request, or tool>
Authorization:   <AUTH-REF-REDACTED>
Redactions:      <List of applied redactions>
Notes:           <Operational context>
────────────────────────────────────────────────────────────────────
<Raw command or response output>
```

This header provides a verified chain of custody linking every claim in the report directly to an authenticated or unauthenticated capture event.

## Redaction Convention

To prevent credential leakage in the repository while preserving structural fidelity:

1. **Authentication Tokens / JWTs**: Redacted as `<REDACTED:jwt:placeholder>` or `<REDACTED>`. Signatures are never committed.
2. **Session Identifiers**: Session cookies (such as `session_id` and `PYXTERM_AUTH`) are replaced with `<REDACTED>`.
3. **System Identifiers**: Hardware MAC addresses have their last two octets masked (`00:04:96:XX:XX:XX`).
4. **Source IPs**: Interactive CLI source locations are masked (`10.1.58.XXX`).
5. **Raw Logs**: The complete interactive terminal capture (`evidence/cli/_raw-telnet-session.log`) is excluded from Git via `.gitignore` to prevent incidental exposure of typing artifacts or timing data.

## Evidence Mapping

| Evidence File | Relevant Findings | Description |
|---|---|---|
| `evidence/network/nmap-service-scan.txt` | F-01, F-02, F-03 | TCP port scan showing ports 23 and 80 open, 443 closed |
| `evidence/network/nmap-http-scripts.txt` | F-03, F-04, F-05 | Nmap HTTP methods, title, and default response headers |
| `evidence/http/root-response-headers.txt` | F-03, F-04, F-05, F-06 | HTTP GET / headers showing cookie attributes and missing security headers |
| `evidence/http/terminal-plugin-response.txt` | F-01, F-07 | GET /terminal/ headers showing `Last-Modified: 2019-03-07` |
| `evidence/http/terminal-static-handler-response.txt` | F-08 | Reachability of unauthenticated `/terminal/_static/` static handler |
| `evidence/http/jsonrpc-401-anonymous.txt` | F-14, F-17 | POST /jsonrpc without credentials returning 401 and CORS wildcard headers |
| `evidence/http/jsonrpc-200-exception.txt` | F-14, F-17, F-18 | POST /jsonrpc with user JWT returning HTTP 200 and Python `OtherError` |
| `evidence/http/js-internal-ip-leak.txt` | F-09 | Four internal IPv4 addresses extracted from `chalet.min.js` |
| `evidence/cli/show-version.txt` | F-01 | EXOS version, patch level, and kernel build date (Feb 25 2020) |
| `evidence/cli/show-switch.txt` | F-01 | Hostname, uptime (136 days), boot count, and config save timestamp |
| `evidence/cli/show-session.txt` | F-13, F-15 | Active CLI sessions showing authenticated `user` role |
| `evidence/cli/cfg-directory-listing.txt` | F-10, F-11, F-12, F-13 | `ls -la /usr/local/cfg` showing 0666 on `primary.cfg` and 0777 on `cc_logs/` |
| `evidence/auth/jwt-claims-decoded.txt` | F-16 | Decoded JWT payload showing `access_level: "user"` and HS256 algorithm |
| `evidence/cli/show-fdb.txt` | N-01 | Pending network inventory capture |
| `evidence/cli/show-iparp.txt` | N-01 | Pending network inventory capture |
| `evidence/cli/show-iproute.txt` | N-01 | Pending network inventory capture |
| `evidence/cli/show-vlan.txt` | N-01 | Pending network inventory capture |
| `evidence/cli/show-ports-information.txt` | N-01 | Pending network inventory capture |
