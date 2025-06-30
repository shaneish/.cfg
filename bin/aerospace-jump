#! /usr/bin/env pypy3

from sys import argv
from subprocess import run
from argparse import ArgumentParser


def main():
    parser = ArgumentParser(description="Navigate between aerospace workspaces.")
    parser.add_argument(
        "direction",
        type=str,
        help="Whether to go to `next`/`n`/`forward`/`f` or `previous`/`p`/`backward`/`b` non-empty workspace."
    )
    parser.add_argument(
        "--workspace",
        "-w",
        type=str,
        default=None,
        help="Workspace to start from.  If not used, defaults to current workspace."
    )
    parser.add_argument(
        "--output",
        "-o",
        type=str,
        default="workspace",
        help="What to do with the parsed workspace ID to jump to.  Options are `workspace`/'w' to return the workspace ID, `command`/`cmd`/`c` to return the aerospace CLI command to for the jump, and `execute`/`exec`/`e`/`x` to simply execute the command and jump to the parsed workspace."
    )
    parser.add_argument(
        "--cmd",
        "-c",
        default="workspace {}",
        help="Command to use if output is set to run or return a command."
    )
    parser.add_argument(
        "--num-of-workspaces",
        "-n",
        type=int,
        default=1,
        help="Number of non-empty workspaces to skip to."
    )
    parser.add_argument(
        "--debug",
        "-d",
        action="store_true"
    )
    args = parser.parse_args()

    avail_ws = run("aerospace list-workspaces --monitor all --empty no", shell=True, capture_output=True).stdout.decode("utf-8").split()
    curr_ws = run("aerospace list-workspaces --focused", shell=True, capture_output=True).stdout.decode("utf-8").strip()
    parsed_cmd = args.cmd.strip()
    check_ws = args.workspace or curr_ws
    output = curr_ws
    n_active_ws = len(avail_ws) or 1
    idx = None

    if check_ws in avail_ws:
        idx = avail_ws.index(check_ws)
        if args.direction.lower() in ["next", "n", "forward", "f"]:
            output = avail_ws[(idx + args.num_of_workspaces) % n_active_ws]
        elif args.direction.lower() in ["previous", "prev", "p", "backward", "b"]:
            output = avail_ws[(idx - args.num_of_workspaces) % n_active_ws]

    cmd = args.cmd.format(output) if ("{}" in args.cmd) else f"{parsed_cmd} {output}"
    if args.debug:
        print(f"{avail_ws = }")
        print(f"{curr_ws = }")
        print(f"{args = }")
        print(f"{check_ws = }")
        print(f"{n_active_ws = }")
        print(f"{idx = }")
        print(f"{output = }")
        print(f"{cmd = }\n")
    if str(args.output).lower() in ["execute", "exec", "x", "e"]:
        cmd = "aerospace " + cmd.lstrip("aerospace ")
        run(cmd, shell=True)
    elif str(args.output).lower() in ["command", "cmd", "c"]:
        print(cmd)
    else:
        print(output)


if __name__ == "__main__":
    main()
