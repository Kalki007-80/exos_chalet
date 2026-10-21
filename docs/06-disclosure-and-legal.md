# Disclosure and Legal Notice

## Authorization Statement

This security assessment was conducted strictly under explicit written authorization from the device owner. Testing activities were scoped exclusively to the single network switch identified in [Target Information](../02-target-information.md) (`POWERHOUSE-1-CORE`, 10.1.58.1). All testing methods used non-destructive, read-only techniques and adhered to the agreed engagement boundaries.

Reference: `<AUTH-REF-REDACTED>`

## Responsible Disclosure

The findings documented in this repository encompass both device-specific configuration weaknesses and known public vulnerabilities affecting legacy ExtremeXOS firmware. Because this device operates in an active production environment, the following disclosure principles apply:

1. **Vendor Awareness**: The CVEs identified in this report (CVE-2023-43118 through CVE-2023-43121, CVE-2020-18305) have been publicly disclosed and patched by Extreme Networks.
2. **Device-Specific Protection**: Configuration details, network topology, internal IP addresses, and credential traces have been strictly redacted.
3. **Disclosure Window**: Any broader dissemination or external reporting must allow a minimum 90-day remediation window following formal handoff to the device administrators.

## No Live Credentials or Exploit Code

This repository contains no live authentication tokens, valid session cookies, plaintext passwords, private keys, or functional exploit payloads. All evidence captures have been audited with automated redaction tooling (`tools/redact-check.sh`) and verified against the provenance standards described in [Evidence Guide](../07-evidence-guide.md).

## Disclaimer

The information in this repository is provided "as is" for security auditing, compliance, and remediation verification purposes only. No warranty of completeness or fitness for a particular purpose is provided. The authors accept no liability for any unintended operational impact resulting from the application of recommendations or commands described herein.

## Contact

For security inquiries, vulnerability reporting, or remediation coordination regarding this assessment, please contact:

`<SECURITY-CONTACT-EMAIL>` / `<MAINTAINER>`
