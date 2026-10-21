# Security Policy

## Scope of This Repository

This repository contains **security assessment documentation only**. It does NOT contain:

- Exploit code or proof-of-concept payloads
- Live credentials, session tokens, or private keys
- Automated attack tooling

## Reporting Documentation Issues

If you identify an error in the assessment documentation, an incorrectly attributed finding, or a missing redaction, please contact `<MAINTAINER>` directly via email. Do **not** open a public GitHub issue containing credentials, IP addresses, or any sensitive detail.

## Authorization Reminder

> **Do not test the target device (`POWERHOUSE-1-CORE`, 10.1.58.1) or any device on its network without the device owner's explicit written authorization.**

This assessment was conducted under a specific written authorization. Any independent reproduction of the testing described here without equivalent written authorization may be illegal under applicable computer fraud and abuse laws.

## Out of Scope

The following activities are explicitly out of scope for any follow-up testing without renewed authorization:

- Exploit payload delivery or command injection
- Configuration modification or save operations
- File read/write operations beyond directory listing
- Path traversal or SSRF testing against the production device
- Brute-force or credential stuffing attacks
- Denial-of-service testing

## Disclosure Policy

This assessment follows a 90-day disclosure timeline from the test date (2026-10-20). See [docs/06-disclosure-and-legal.md](../docs/06-disclosure-and-legal.md) for details.
