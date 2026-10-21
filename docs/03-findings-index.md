# Findings Index

Full findings table sorted by severity (Critical → High → Medium → Low → Info). 17 findings plus one informational inventory item (N-01); F-15 was folded into F-16 and the ID is intentionally skipped.

| # | Finding | Severity | CVSS | CWE | CVE | Status |
|---|---|---|---|---|---|---|
| F-01 | Outdated firmware predating 2023 fixes | Critical | 9.8 | CWE-1104 | 2023-43118/43119/43120/43121, 2020-18305 | Confirmed (version-based) |
| F-02 | Telnet management exposed | High | 7.4 | CWE-319 | — | Confirmed |
| F-03 | Chalet over HTTP only | High | 7.4 | CWE-319, 614 | — | Confirmed |
| F-04 | Cookie lacks Secure/HttpOnly/SameSite | Medium | 5.3 | CWE-1004, 614 | — | Confirmed |
| F-05 | Missing security headers | Medium | 5.3 | CWE-693 | — | Confirmed |
| F-06 | Client-side authz via `ng-show="accessRight==='readWrite'"` | Medium | 5.3 | CWE-602 | 2020-18305 (conditional) | Confirmed (UI) |
| F-07 | CLI Terminal plugin publicly served | High | 7.5 | CWE-284 | — | Confirmed |
| F-08 | `/terminal/_static/` handler unauthenticated | High | 7.5 | CWE-22 | 2023-43121 | Confirmed (exposure) |
| F-09 | Internal IPs in `chalet.min.js` | Low | 3.7 | CWE-200 | — | Confirmed |
| F-10 | `primary.cfg` mode 0666 | High | 7.1 | CWE-732 | — | Confirmed |
| F-11 | `cc_logs/` mode 0777 | High | 7.1 | CWE-732 | — | Confirmed |
| F-12 | Non-standard executables in config directory | Info | 0.0 | CWE-1188 | — | Presence confirmed |
| F-13 | `user` role browses `/usr/local/cfg` | High | 7.1 | CWE-269 | — | Confirmed |
| F-14 | `/jsonrpc` role filtering | Medium | 5.3 | CWE-269 | — | Inconclusive |
| F-16 | HS256 JWT, 24 h lifetime, dual-cookie | Medium | 5.9 | CWE-522, 326 | — | Confirmed |
| F-17 | Permissive CORS on `/jsonrpc` | High | 7.3 | CWE-942 | — | Confirmed |
| F-18 | Python exception disclosure on `/jsonrpc` | Medium | 4.3 | CWE-209 | — | Confirmed |
| N-01 | Network inventory | Info | 0.0 | — | — | Pending |

> **Note:** F-15 (concurrent XML session observation) was folded into F-16 during report finalization; the ID is intentionally skipped.
