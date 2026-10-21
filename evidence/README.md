# Evidence

Every file starts with a provenance header (collected, method, redactions).
Redacted values appear as `<REDACTED>` or `<JWT-REDACTED>`.

| File | Finding | Collected | Method |
|---|---|---|---|
| network/nmap-service-scan.txt | F-01,F-02,F-03 | 2026-10-20 21:37 | nmap -sV |
| network/nmap-http-scripts.txt | F-03,F-04,F-05 | 2026-10-20 21:39 | nmap --script |
| http/root-response-headers.txt | F-03,F-04,F-05 | 2026-10-20 12:55 | curl |
| http/terminal-plugin-response.txt | F-07 | 2026-10-20 12:58 | curl |
| http/terminal-static-handler-response.txt | F-08 | 2026-10-20 12:58 | curl |
| http/jsonrpc-401-anonymous.txt | F-14,F-17 | 2026-10-20 13:47 | curl |
| http/jsonrpc-200-exception.txt | F-14,F-18 | 2026-10-20 13:53 | curl |
| http/js-internal-ip-leak.txt | F-09 | 2026-10-20 12:58 | curl |
| cli/show-version.txt | F-01 | 2026-10-20 21:57 | EXOS CLI |
| cli/show-switch.txt | F-01 | 2026-10-20 21:59 | EXOS CLI |
| cli/show-session.txt | F-13,F-15 | 2026-10-20 21:59 | EXOS CLI |
| cli/cfg-directory-listing.txt | F-10,F-11,F-12,F-13 | 2026-10-20 21:55 | EXOS CLI |
| auth/jwt-claims-decoded.txt | F-16 | 2026-10-20 13:50 | DevTools |
