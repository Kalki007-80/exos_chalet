# Remediation Roadmap

> [!IMPORTANT]
> **Do NOT save the switch configuration** until pending configuration changes have been reviewed. A `save configuration` command before review could persist an unknown or unintended state. Confirm with the device owner what the pending changes are before proceeding.

---

## Phase 1 — Immediate (0–7 days)

| Action | Findings Closed | Owner | Verification |
|---|---|---|---|
| Upgrade ExtremeXOS firmware to ≥ 22.7.1.4 | F-01, F-07, F-08 (and removes CVE-2023-43118/43119/43120/43121) | Network Admin | `show version` — build date post-2023, version ≥ 22.7.1.4 |
| Backup running config before upgrade | Pre-upgrade hygiene | Network Admin | Config file archived to secure, permission-controlled location |
| Disable Telnet: `disable telnet` | F-02 | Network Admin | `nmap -p 23 10.1.58.1` — state: closed/filtered |
| Enable SSH2: `enable ssh2` | F-02 (replacement) | Network Admin | `show management` — SSH2 enabled |
| Disable HTTP or enforce HTTPS-only: `configure web http disable` | F-03 | Network Admin | `curl -I http://10.1.58.1/` — connection refused or redirect to HTTPS |
| Rotate all credentials stored in primary.cfg (usernames, passwords, SNMP community strings) | F-10, F-13 | Security Team | Credentials confirmed rotated; old values invalidated |

> [!NOTE]
> ExtremeXOS CLI syntax — verify each command with `?` in your specific EXOS version before execution:
> - `disable telnet` — disables Telnet server
> - `enable ssh2` — enables SSH2 server
> - `configure web http disable` — disables HTTP; requires TLS cert to be installed first for HTTPS access

---

## Phase 2 — Short-term (7–30 days)

| Action | Findings Closed | Owner | Verification |
|---|---|---|---|
| Fix primary.cfg permissions: `chmod 0600 /usr/local/cfg/primary.cfg` | F-10 | Network Admin / Extreme TAC | `ls -la /usr/local/cfg/primary.cfg` shows `-rw-------` |
| Fix cc_logs/ permissions: `chmod 0750 /usr/local/cfg/cc_logs/` | F-11 | Network Admin / Extreme TAC | `ls -la /usr/local/cfg/` shows `drwxr-x---` for cc_logs/ |
| Remediate CORS policy — replace `*` with device origin; remove Allow-Credentials if cookies used | F-17 | Vendor (firmware fix, or TAC workaround) | `curl -H "Origin: http://evil.example" -I http://10.1.58.1/jsonrpc` — no wildcard origin returned |
| Harden JSON-RPC exception handling — catch all exceptions, return generic error | F-18 | Vendor (firmware fix) | Malformed JSON-RPC call returns `{"error":{"code":-32603,"message":"Internal error"}}` with no internal names |
| Add cookie security flags (Secure; HttpOnly; SameSite=Strict) to all auth cookies | F-04 | Vendor (firmware fix) | `curl -I http://10.1.58.1/` — Set-Cookie includes all three flags |
| Add HTTP security headers (CSP, X-Frame-Options, X-Content-Type-Options, HSTS) | F-05 | Vendor (firmware fix) | `curl -I https://10.1.58.1/` — all four headers present |
| Implement management ACL or dedicated management VLAN | Defense-in-depth | Network Admin | Management interfaces reachable only from authorized subnets |
| Enforce access_level in JSON-RPC dispatcher for every method call | F-06, F-14 | Vendor (firmware fix) | Admin-only JSON-RPC method with user JWT returns 403 |

> [!CAUTION]
> Permission fixes for `primary.cfg` and `cc_logs/` should be **coordinated with Extreme TAC** before implementation. Firmware upgrades may reset these permissions, and there may be platform-specific guidance for the correct permission set on this hardware.

---

## Phase 3 — Follow-up (30–90 days)

| Action | Findings Closed | Owner | Verification |
|---|---|---|---|
| Investigate origin of shell.py, testme.py, and vmt/ with Extreme TAC | F-12 | Network Admin / Extreme TAC | Origin confirmed; files removed or authorized |
| Collect network inventory evidence (FDB, ARP, routing, VLAN, port info) | N-01 | Network Admin | All five evidence files populated; N-01 closed |
| Verify JWT signing key is per-device and per-boot (not shared across devices) | F-16 | Vendor / TAC | Confirmed with Extreme TAC |
| Lab retest of F-14: JSON-RPC access_level enforcement | F-14 | Security Team | Lab replica of 22.7.1.2 — admin-only method with user JWT returns 403 or confirmed bypass |
| Remove hardcoded internal IPs from client-side JavaScript (chalet.min.js) | F-09 | Vendor (firmware fix) | `curl http://10.1.58.1/chalet.min.js | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'` returns no internal IPs |
| Restrict user-role CLI to minimal EXOS command set; disable terminal plugin for non-admin | F-13, F-07 | Network Admin | User-role session cannot `ls /usr/local/cfg/` or access terminal plugin |
