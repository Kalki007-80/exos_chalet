# Screenshot Redaction Checklist

Use this checklist prior to staging and committing visual artifacts to `evidence/screenshots/`.

- [ ] **Cookie and Token Values**: All values in DevTools Application tab (specifically for `x-auth-token`, `session`, `session_id`, `PYXTERM_AUTH`) are completely blurred or blacked out.
- [ ] **URL Query Parameters**: No sensitive session tokens or authorization codes are visible in browser URL address bars.
- [ ] **Network Source Addresses**: The last octet of management client source IPs (e.g., `10.1.58.XXX`) is masked.
- [ ] **Hardware Identifiers**: Serial numbers and full MAC addresses are masked where applicable.
- [ ] **Visual Clarity**: Redaction obscures sensitive data without concealing the structural evidence being demonstrated (e.g., column headers indicating missing flags must remain readable).
- [ ] **Automated Inspection**: File has been verified not to contain embedded text metadata containing cleartext secrets.

Reviewer Sign-off:
- Reviewer: _______________________
- Date:     _______________________
