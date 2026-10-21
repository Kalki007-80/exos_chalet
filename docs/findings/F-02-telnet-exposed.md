# F-02 — Telnet Management Exposed (Cleartext CLI)

| Field | Value |
|---|---|
| Severity | High |
| CVSS v3.1 | 7.4 — `AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:H/A:N` |
| CWE | CWE-319 — Cleartext Transmission of Sensitive Information |
| CVE | None assigned |
| Status | Confirmed |
| Affected component | Telnet daemon (TCP port 23) |
| Evidence | [nmap-service-scan.txt](../../evidence/network/nmap-service-scan.txt) |

## Summary

The switch management plane exposes an unencrypted Telnet service on TCP port 23. All interactive CLI sessions, administrative credentials, and configuration commands are transmitted across the local network in plaintext.

## Technical detail

Port scanning identified TCP port 23 open and actively presenting an interactive ExtremeXOS login banner:
```text
PORT   STATE SERVICE VERSION
23/tcp open  telnet
```

Session captures confirm that administrative authentication occurs without transport encryption. Any party with local segment access, tap capability, or ARP spoofing position can intercept administrative credentials in transit.

## Evidence

> 23/tcp open  telnet

Full raw evidence: [nmap-service-scan.txt](../../evidence/network/nmap-service-scan.txt)

## Impact

Interception of cleartext management sessions allows adversaries to capture plaintext passwords, gain full administrative control of the core switch, alter VLAN and routing configurations, and intercept network data.

## Remediation

1. Enable the secure shell daemon:
   ```text
   enable ssh2
   ```
2. Disable the cleartext Telnet service:
   ```text
   disable telnet
   ```
3. Verify SSH key generation and cipher suite configurations using `show ssh2`.

## Verification

Verify port 23 is closed or filtered from an external audit workstation:
```bash
nmap -p 23 10.1.58.1
```
Expected output: `23/tcp closed` or `filtered`.

## References

- [CWE-319](https://cwe.mitre.org/data/definitions/319.html)
