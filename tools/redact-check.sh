#!/usr/bin/env bash
# Usage: ./tools/redact-check.sh   (run before git push)
set -u
fail=0
patterns=(
  'eyJ[A-Za-z0-9_-]+\.'                 # JWT body
  'session_id=[0-9a-f]{20,}'            # session cookie
  'x-auth-token=[A-Za-z0-9._-]+'        # auth token
  'PYXTERM_AUTH=[A-Za-z0-9]+'           # terminal token
  'BEGIN .*PRIVATE KEY'                 # keys
  'password[[:space:]]*='               # inline creds
)
for p in "${patterns[@]}"; do
  if grep -RInE "$p" --exclude-dir=.git --exclude="redact-check.sh" . ; then
    echo "!! match for: $p"
    fail=1
  fi
done
[[ $fail -eq 0 ]] && echo "OK: no obvious secrets found" || echo "FAIL: fix before push"
exit $fail
