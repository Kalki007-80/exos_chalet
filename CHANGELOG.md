# Changelog

All notable changes to this security assessment repository will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.0.0] — 2026-10-20

### Fixed
- F-16 title and body corrected: JWT model observations (HS256, 24 h lifetime, dual-cookie, PYXTERM_AUTH token); removed erroneous localStorage and missing exp references.
- F-06 ng-show expression corrected to `ng-show="accessRight==='readWrite'"`.
- F-07 and F-08 CVE mapping corrected: F-07 has no CVE assigned (precondition note added); F-08 retains CVE-2023-43121.
- F-12 title and scope corrected to non-standard executables (`shell.py`, `testme.py`, `vmt/`); removed backup file references.
- F-01 wording updated to affected-version range comparison basis; noted no CVEs were exploited during assessment.
- Finding count updated: 17 findings plus one informational inventory item (N-01); F-15 was folded into F-16 and the ID is intentionally skipped.

### Added — Initial assessment release

- F-01: Outdated Firmware Predating 2023 Fixes (Critical) — inside published affected-version range
- F-02: Telnet Exposed (High) — TCP/23 open, cleartext credentials
- F-03: HTTP-Only Chalet Management Interface (High) — Port 443 closed, no TLS
- F-04: Missing Cookie Security Flags (Medium) — No Secure, HttpOnly, SameSite
- F-05: Missing HTTP Security Headers (Medium) — No CSP, X-Frame-Options, X-Content-Type-Options, HSTS
- F-06: Client-Side Authorization via `ng-show="accessRight==='readWrite'"` (Medium)
- F-07: CLI Terminal Plugin Publicly Served (High) — Last-Modified 2019-03-07, no CVE assigned
- F-08: Terminal Static File Handler Exposed (High) — /terminal/_static/ reachable unauthenticated, CVE-2023-43121
- F-09: Internal IP Address Disclosure (Low) — Four IPs hardcoded in chalet.min.js
- F-10: World-Writable Primary Configuration File (High) — primary.cfg at 0666
- F-11: World-Writable Log Directory (High) — cc_logs/ at 0777
- F-12: Non-Standard Executables in Configuration Directory (Info) — shell.py, testme.py, vmt/ present
- F-13: User Role Access to Configuration Directory (High) — User session can browse /usr/local/cfg/
- F-14: JSON-RPC Authentication Boundary (Medium, INCONCLUSIVE) — User JWT accepted; method-level enforcement unverified
- F-16: JWT Authentication Model Observations (Medium) — HS256, 24 h lifetime, dual-cookie
- F-17: Permissive CORS Policy (High) — Allow-Origin: *, Allow-Credentials: true
- F-18: Python Exception Disclosure via JSON-RPC (Medium) — Raw exception leaks internal function names
- N-01: Network Inventory Pending (Info) — FDB, ARP, routing, VLAN, port data not yet collected
