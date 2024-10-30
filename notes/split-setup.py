from pathlib import Path

with open("fedora-setup.md", "r") as f:
    setup = f.read()

for idx, section in enumerate(setup.split("```bash")[1:]):
    block = section.split("```")[0].strip()
    title = block.split("\n")[0].lstrip("# ").strip()
    file_name = str(idx).zfill(2) + "-" + title.strip() + ".sh"
    with open(Path("setup-scripts") / file_name, "w") as f:
        f.write(block)
