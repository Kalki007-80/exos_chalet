# N-01 — Network Inventory Collection

| Field | Value |
|---|---|
| Severity | Info |
| CVSS v3.1 | 0.0 — `None` |
| CWE | N/A |
| CVE | None assigned |
| Status | **Pending** |
| Affected component | Core Switch Network State |
| Evidence | [show-fdb.txt](../../evidence/cli/show-fdb.txt), [show-iparp.txt](../../evidence/cli/show-iparp.txt), [show-iproute.txt](../../evidence/cli/show-iproute.txt), [show-vlan.txt](../../evidence/cli/show-vlan.txt), [show-ports-information.txt](../../evidence/cli/show-ports-information.txt) |

## Summary

Comprehensive network state and topology documentation (Forwarding Database, ARP table, IP routing table, VLAN assignments, and detailed port telemetry) is tracked under this finding and remains pending collection.

## Technical detail

Due to scope constraints during the initial time-boxed assessment, read-only network inventory commands were deferred to prevent potential terminal lockups on heavily loaded forwarding tables.

Required collection commands for complete inventory:
```text
show fdb
show iparp
show iproute
show vlan
show ports information detail
```

## Evidence

Pending collection during follow-up authorized window:
- [show-fdb.txt](../../evidence/cli/show-fdb.txt)
- [show-iparp.txt](../../evidence/cli/show-iparp.txt)
- [show-iproute.txt](../../evidence/cli/show-iproute.txt)
- [show-vlan.txt](../../evidence/cli/show-vlan.txt)
- [show-ports-information.txt](../../evidence/cli/show-ports-information.txt)

## Impact

Operational documentation and network visibility limitation; does not represent a vulnerability.

## Remediation

Execute read-only inventory collection commands during an approved administrative window.

## Verification

Verify all five evidence files contain active table output.

## References

- ExtremeXOS 22.7 Command Reference Guide
