---
name: explain
description: Give a detailed explanation of something (how a fix was found, how a tool or system works, why a bug happened) and save it as a markdown reference file in ~/.config/.cfg/refs/useful_convos/. Use when the user types /explain, or asks for a detailed explanation, walkthrough, or "explain how/why" write-up they'd want to keep for later.
argument-hint: "[what to explain]"
---

# Explain and save

The user keeps detailed explanations as markdown reference files so they can come back
to them later. Every explanation this skill produces is both given in chat and saved
to a file.

## Steps

1. **Work out the subject.** Use the arguments if given; otherwise it's whatever the
   user just asked to have explained, usually something from this conversation.

2. **Write the explanation.** Make it stand on its own, since it will be read later
   without this conversation:
   - Open with a short summary of the context: the problem or question, and the
     answer or fix in brief.
   - Then the detailed explanation. For debugging, walk through what was checked, in
     order, with the actual commands and what each one revealed.
   - End with reusable takeaways, such as habits or general principles, when there
     are any.
   - Use exact file paths, commands, config keys and error text. Leave out anything
     that only mattered in the moment (tool-call chatter, "as I said above").

3. **Choose the filename:** `<program>__<category>__<description>.md`
   - `<program>`: the main process, tool or program the explanation centers on
     (`nvim`, `podman`, `wezterm`, `sway`, `git`, ...).
   - `<category>`: a short high-level category. **Reuse an existing one when it fits.**
     First list the directory and collect the middle segments already in use:
     ```
     ls ~/.config/.cfg/refs/useful_convos/
     ```
     Only make up a new category when none of the existing ones fit.
   - `<description>`: a few words identifying the specific subject.
   - All lowercase, words within a segment joined with `_`, segments separated by `__`.
   - Examples: `nvim__insert_debug__paste_w_ctrl_shift_v.md`,
     `podman__cli_debug__images.md`.
   - If the filename already exists, don't overwrite it. Use a more specific
     description, unless the user asked to update that file.

4. **Save it** to `~/.config/.cfg/refs/useful_convos/<filename>` as plain GitHub-flavored
   markdown (headings, fenced code blocks, lists).

5. **Reply** with the explanation itself, followed by one line naming the saved file.
   Don't commit the file unless asked.
