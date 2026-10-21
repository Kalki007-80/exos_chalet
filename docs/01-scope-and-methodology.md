# Scope and Methodology

## Scope

| Attribute | Value |
|---|---|
| Target | 10.1.58.1 (POWERHOUSE-1-CORE) |
| Device | Extreme Networks X460G2-48x-10G4 |
| Firmware | ExtremeXOS 22.7.1.2-patch1-24 |
| Test Date | 2026-10-20, 21:30–22:00 IST (UTC+5:30) |
| Test Duration | ~30 minutes |
| Authorization | Written authorization from device owner (reference: `<AUTH-REF>`) |

## In-Scope Activities

The following activities were explicitly authorized and performed:

- **Nmap service and script scanning** — port discovery and HTTP header enumeration against 10.1.58.1
- **HTTP header probing** — unauthenticated `curl` requests to retrieve response headers from key endpoints
- **Authenticated web session — user role** — login to Chalet web interface using provided user credentials; navigation, DOM inspection, DevTools review
- **Authenticated CLI — user role** — login to EXOS CLI via Telnet using provided user credentials; read-only EXOS `show` commands (`show version`, `show switch`, `show session`, `ls /usr/local/cfg/`)
- **Static asset retrieval** — unauthenticated retrieval of JavaScript files, plugin endpoints, and static handler endpoints
- **Read-only JSON-RPC probe** — single authenticated POST to `/jsonrpc` with a malformed-but-valid-credential request to observe error handling and CORS headers

## Out-of-Scope Activities

The following activities were explicitly NOT performed:

- Exploit payload delivery, command injection, or remote code execution attempts
- Path traversal or directory traversal against `/terminal/_static/` or any other handler
- SSRF payloads or server-side request forgery attempts
- Reading the contents of `primary.cfg`, `shell.py`, `testme.py`, or any file within `vmt/`
- Executing any file found in the configuration directory
- State-changing CLI commands (e.g., `configure`, `save configuration`, `reboot`)
- Brute-force or credential stuffing against any interface
- Saving or modifying the switch configuration
- Fuzzing the JSON-RPC parameter space against the production device

## Limitations

- The test window was approximately 30 minutes, limiting the breadth of evidence collection. Network inventory data (FDB, ARP table, routing table, VLAN table, port information) was not collected and is tracked as N-01.
- Testing was conducted from an authenticated **user-role** session only. Admin-role behavior was not observed.
- CVE applicability for CVE-2023-43118 through 43121 and CVE-2020-18305 is based on **version range comparison** against NVD and Extreme Networks advisories. Exploitation was not attempted on the production device.
- F-14 (JSON-RPC authentication boundary) remains **INCONCLUSIVE** because the correct parameter name for the `cli()` function was not known, and parameter fuzzing against the production core switch was out of scope.

## Tool Versions

| Tool | Version | Purpose |
|---|---|---|
| Nmap | 7.991 | Port scanning, HTTP script scanning |
| curl | System default | HTTP header retrieval, endpoint probing |
| Browser DevTools | Chromium (current) | DOM inspection, cookie analysis, network tab |
