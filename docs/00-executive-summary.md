# Executive Summary

## What Was Tested

A time-boxed security assessment was conducted on 2026-10-20 against a single Extreme Networks X460G2-48x-10G4 core switch (`POWERHOUSE-1-CORE`, 10.1.58.1) running ExtremeXOS firmware version 22.7.1.2-patch1-24. Testing was performed from an authenticated user-role session via both the Chalet web interface (HTTP, port 80) and the EXOS CLI (Telnet, port 23), supplemented by unauthenticated network scanning and static asset retrieval. All testing was read-only and conducted under written authorization from the device owner. The assessment produced 17 findings plus one informational inventory item (N-01); F-15 was folded into F-16 and the ID is intentionally skipped.

## Headline Findings

Three findings define the critical risk posture of this device. First, the firmware is more than six years old (built February 2020) and is inside the published affected-version range for CVE-2023-43118, CVE-2023-43119, CVE-2023-43120, CVE-2023-43121, and CVE-2020-18305. None of these CVEs were exploited in this assessment; applicability is established by version comparison only. Second, all management access — both Telnet (TCP/23) and the Chalet web interface (TCP/80) — operates entirely in cleartext; there is no TLS, meaning any network-adjacent attacker can intercept credentials, session tokens, and configuration data in transit. Third, the primary switch configuration file (`primary.cfg`, 1.2 MB) has world-writable permissions (0666), and an authenticated user-level CLI session was able to browse the configuration directory, observe file names and sizes, and — combined with the 0666 permission — would be able to read the configuration file directly.

## Overall Risk Rating: Critical

The combination of publicly-known, unpatched RCE-class vulnerabilities reachable from the network, cleartext credential transmission, and filesystem permission failures yields an overall **Critical** risk rating. The business impact is severe: a network-adjacent attacker with no credentials could exploit CVE-2023-43118 (CSRF to RCE) in combination with the permissive CORS policy (F-17) and missing cookie security flags (F-04) to execute arbitrary commands on the switch. An attacker with a valid low-privilege user credential — obtainable via Telnet interception — could read the switch configuration, escalate privilege, and disrupt or redirect network traffic for all devices served by this core switch.

## Remediation Priorities

1. **Upgrade ExtremeXOS firmware** to version 22.7.1.4 or later immediately — this single action closes five CVEs and the two terminal handler findings (F-07, F-08).
2. **Disable Telnet and enable SSH2** — eliminates cleartext credential and session exposure on the management plane.
3. **Rotate all credentials** in `primary.cfg` before and after the firmware upgrade, as the file's 0666 permissions mean any local user process may have already read it.
4. **Fix configuration file and directory permissions** (`primary.cfg` to 0600, `cc_logs/` to 0750) in coordination with Extreme TAC to prevent regression after upgrade.
5. **Remediate the CORS policy, cookie flags, and HTTP security headers** (F-17, F-04, F-05) to eliminate the browser-based attack surface that amplifies the CVE-2023-43118 CSRF chain.
