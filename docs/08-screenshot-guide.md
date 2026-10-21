# Screenshot Capture and Redaction Guide

This guide details the procedures for capturing and redacting visual evidence before adding images to `evidence/screenshots/`.

## Required Screenshots

| ID | Filename | Source / Interface | Required Content | Mandatory Redactions |
|---|---|---|---|---|
| S-01 | `01-cookie-flags.png` | Browser DevTools → Application → Cookies | Table showing `x-auth-token`, `session`, `session_id` | **Blur the entire Value column** |
| S-02 | `02-ng-show-dom.png` | Browser DevTools → Elements | DOM inspection of admin navigation link with `ng-show` attribute | None |
| S-03 | `03-terminal-plugin-public.png` | Browser window | Address bar at `http://10.1.58.1/plugins/terminal/index.html` rendering terminal UI | Blur any session token if present |
| S-04 | `04-dashboard-user.png` | Browser window | Chalet dashboard rendering port utilization for authenticated `user` | Blur top-right hostname and user session ID |
| S-05 | `05-cli-show-version.png` | Terminal window | `show version` output showing build date `Tue Feb 25 2020` | Mask source IP address if visible |
| S-06 | `06-cli-show-session.png` | Terminal window | `show session` output showing `user` in the User column | Mask Auth Location column (`10.1.58.XXX`) |

## Recommended Tooling

- **Linux**: Flameshot (`sudo apt install flameshot && flameshot gui`). Use the blur brush tool (shortcut `B`) over sensitive values.
- **Cross-platform**: GIMP or native screenshot tools with gaussian blur applied to credentials.

## Redaction Checklist

Before committing any screenshot to git:

1. [ ] No JWT strings (`eyJ...`) or hex session tokens visible anywhere in the image.
2. [ ] No internal password or SNMP string visible.
3. [ ] Auth Location source IP addresses have the final octet blurred or masked.
4. [ ] Hostname in top navigation is obscured if required by confidentiality scope.
5. [ ] The image file is saved in PNG format under `evidence/screenshots/` matching the naming convention.
