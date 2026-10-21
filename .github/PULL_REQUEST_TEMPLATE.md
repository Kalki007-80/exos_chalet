## Pull Request Checklist

Before submitting this PR, confirm all items below:

- [ ] `./tools/redact-check.sh` passes with exit code 0 (CI will enforce this)
- [ ] No live credentials, JWT tokens, session IDs, passwords, or SNMP community strings are present in any file
- [ ] All evidence file links in finding docs resolve to existing files in the `evidence/` directory
- [ ] Any new or updated finding includes a valid CVSS v3.1 vector string (e.g., `AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H`)
- [ ] Disclosure rules in [docs/06-disclosure-and-legal.md](docs/06-disclosure-and-legal.md) are respected — no public disclosure of unpatched details beyond the agreed timeline
- [ ] Finding status is one of: `Confirmed`, `Inconclusive`, `Not verified`, or `Pending`
- [ ] F-14 status remains `INCONCLUSIVE` until lab retest is complete

## Summary of changes

<!-- Brief description of what was added or changed -->

## Related finding(s)

<!-- e.g., F-14, N-01 -->
