# Screenshots

All screenshots were taken from an authorized session on `10.1.58.1` on 2026-10-20 and redacted before commit. Redaction method: Flameshot blur brush; each image was reviewed against [templates/screenshot-redaction-checklist.md](../../templates/screenshot-redaction-checklist.md) before commit.

| File | Shows | Finding | Redacted |
|---|---|---|---|
| `01-cookie-flags.png` | DevTools cookie view: no HttpOnly/Secure/SameSite | F-04 | Cookie values blurred |
| `02-ng-show-dom.png` | `ng-show="accessRight==='readWrite'"` in DOM | F-06 | None |
| `03-terminal-plugin-public.png` | `/plugins/terminal/index.html` renders unauthenticated | F-07 | None |
| `04-dashboard-user.png` | Dashboard renders for `user` role | F-13 | Hostname blurred |
| `05-cli-show-version.png` | `show version` — 22.7.1.2, Feb 2020 | F-01 | Source IP masked |
| `06-cli-show-session.png` | `show session` — `user` role | F-13 | Source IP masked |
