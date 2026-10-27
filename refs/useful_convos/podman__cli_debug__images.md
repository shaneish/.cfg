┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ I'll explain why podman images fails while podman system connection list shows a valid connection. I'll describe the debug steps you should run next.                    │
│                                                                                                                                                                          │
│ On macOS, Podman runs inside a Linux VM called a "machine." The podman system connection list command shows configured SSH endpoints, but these remain in the            │
│ configuration even when the VM is stopped. The "connection refused" error means the VM is not currently running, so nothing is listening on port 57595. You need to      │
│ start                                                                                                                                                                    │
│ the machine with podman machine start.                                                                                                                                   │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

Why this happens

On macOS, Podman does not run containers directly on macOS. It runs a small Linux VM (a Podman machine). The CLI talks to Podman inside that VM over SSH.

Two separate things are involved:

┌───────────────────┬────────────────────────────────────────────────────────────────────────┐
│ Concept           │ What it is                                                             │
├───────────────────┼────────────────────────────────────────────────────────────────────────┤
│ System connection │ Saved config: “when I run podman, connect to this SSH URL and socket.” │
├───────────────────┼────────────────────────────────────────────────────────────────────────┤
│ Podman machine    │ The actual Linux VM that must be running for that connection to work.  │
└───────────────────┴────────────────────────────────────────────────────────────────────────┘

podman system connection list only shows configured endpoints. It does not mean the VM is up or that port 57595 is listening.

Your error:

dial tcp 127.0.0.1:57595: connect: connection refused

means nothing is accepting connections on 127.0.0.1:57595. Typical causes:

1. The Podman machine is stopped (most common).
2. The machine crashed or was removed, but old connection config still points at the old port.
3. Another process conflict or a stale SSH forward.

So: connections exist in config, but the VM/SSH bridge is not running.

────────────────────────────────────────

Debug steps (run these yourself)

Work through them in order. Each step tells you what to look for.

1. Is the machine running?

podman machine list

What it does: Lists Podman VMs and their state (Running, Stopped, etc.).

What to look for:
• Stopped → start it (step 2).
• No machines → you need podman machine init then podman machine start.
• Running but podman images still fails → go to step 3.

────────────────────────────────────────

2. Start the machine

podman machine start

What it does: Boots the Linux VM and sets up SSH so the CLI can reach the Podman socket.

What to look for: Success message and a new SSH port (may differ from 57595). Then:

podman images

If that works, the issue was simply a stopped machine.

────────────────────────────────────────

3. Check whether the port is actually open

nc -zv 127.0.0.1 57595

(or lsof -i :57595 on macOS)

What it does: Tests whether anything is listening on the port your connection config uses.

What to look for:
• Connection refused → nothing listening (VM stopped or wrong port).
• succeeded → port is open; problem may be SSH/auth or the socket inside the VM.

────────────────────────────────────────

4. Inspect the machine (port and state)

podman machine inspect

What it does: Shows VM details: state, SSH port, resources, etc.

What to look for:
• State should be running.
• Compare the SSH port in inspect output with 57595 in podman system connection list. If they differ, your connection config is stale.

────────────────────────────────────────

5. Compare connection config vs reality

podman system connection list

You already ran this. After podman machine start, run it again.

What to look for:
• Default connection (true in the Default column) should match a running machine.
• URI port should match what podman machine inspect reports.

If the machine was recreated, old connections can point at an old port. Fix with:

podman machine start

(often refreshes connections), or manually:

podman system connection default podman-machine-default-root

────────────────────────────────────────

6. Test SSH to the machine

podman machine ssh

What it does: Opens an SSH shell inside the Linux VM.

What to look for:
• If this fails, the VM or SSH bridge is broken.
• If it works, from inside the VM try:

podman images

If that works inside the VM but not from macOS, the issue is the connection/SSH bridge, not Podman itself.

────────────────────────────────────────

7. If the machine is broken or missing

Only if podman machine list shows problems or start keeps failing:

podman machine stop
podman machine start

If still broken:

podman machine rm
podman machine init
podman machine start

Warning: podman machine rm removes the VM (images/containers in that VM can be lost unless you use volumes/backups). Use only when init/start doesn’t fix things.

────────────────────────────────────────

Mental model

Your Mac (podman CLI)
    │
    │  SSH to 127.0.0.1:57595
    ▼
Podman machine (Linux VM)
    │
    │  podman.sock
    ▼
Containers / images

connection list = “here’s where we would connect.”
connection refused = “nothing is listening at that address right now.”

Usually: start the machine with podman machine start.

────────────────────────────────────────

What to send back

If it still fails after podman machine start, paste output of:

1. podman machine list
2. podman machine inspect (or the State and SSH port sections)
3. podman system connection list
4. nc -zv 127.0.0.1 57595

That’s enough to narrow it down without guessing.
