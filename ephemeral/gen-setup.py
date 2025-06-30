#!/usr/bin/env python
from pathlib import Path
import re
import sys
import os

base = Path(os.path.expandvars("$HOME")) / ".config" / ".cfg" / "notes"
p = base / "fedora-setup.md"
if len(sys.argv) > 1:
    p = base / sys.argv[1]

with open(p, "r") as f:
    setup = f.read()

s = re.findall(r'[\w\-]+\s*\n```bash', setup) # .strip().replace('```', '')
for m in s:
    setup = setup.replace(m, "## " + m.split("\n")[0])
setup = setup.replace("```", "")

with open(base / "setup-scripts" / "setup.sh", "w") as f:
    f.write(setup)
