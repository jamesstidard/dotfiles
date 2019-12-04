#!/usr/bin/env python3

import re
import os
import sys
import json
import tempfile
import subprocess

try:
    input = raw_input
except NameError:
    pass


MACOS = sys.platform.startswith("darwin")
LINUX = sys.platform.startswith("linux")
SSH_PATH = os.path.expanduser("~/.ssh/id_rsa")
SSH_PATH_PUB = os.path.expanduser("~/.ssh/id_rsa.pub")
SSH_PRESENT = os.path.exists(SSH_PATH)
GIT_PRESENT = subprocess.call("which git", shell=True) == 0
XCLIP_PRESSENT = subprocess.call("which xclip", shell=True) == 0

NO_COLOR = '\033[0m' # No Color


def green(msg):
    return '\033[0;32m' + msg + NO_COLOR


def confirm(msg):
    rsp = input(green(msg + " [Y/n]: "))
    while True:
        if rsp.lower() in {"", "y", "ye", "yes"}:
            return True
        elif rsp.lower() in {"n", "no"}:
            return False
        else:
            rsp = input(green("Unknown response, try again. Expecting (yes or no): "))


def grab_github_email():
    rsp = input(green("GitHub email: "))
    while True:
        if re.search(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$", rsp):
            return rsp
        else:
            rsp = input(green("Doesn't quite look like a email. Try again: "))


if not SSH_PRESENT:
    make_ssh = confirm(
        green(
            "Looks like there's no ssh key for your machine (fresh install). Make one?"
        )
    )
    if not make_ssh:
        exit(0)

    email = grab_github_email()

    subprocess.check_call(
        ["ssh-keygen", "-t", "rsa", "-f", SSH_PATH, "-b", "4096", "-C", email, "-N", "\"\""],
        shell=True,
    )
    subprocess.check_call(["eval", "\"$(ssh-agent -s)\""], shell=True)

    if MACOS:
        subprocess.check_call(["ssh-add", "-K", SSH_PATH], shell=True)
    else:
        subprocess.check_call(["ssh-add", SSH_PATH], shell=True)

    print(green("ssh key made."))


if LINUX:
    install = []

    if not GIT_PRESENT:
        install.append("git")
    if not XCLIP_PRESSENT:
        install.append("xclip")
    if install:
        subprocess.call(["sudo apt update && sudo apt install -y"] + install, shell=True)


GITHUB_AUTH = subprocess.call(["ssh -T git@github.com"], shell=True) == 1

if not GITHUB_AUTH:
    with open(SSH_PATH_PUB, "r") as fp:
        pub = fp.read()

    print(
        green(
            "Looks like your ssh key isn't present on GitHub. "
            "Take this to  Github.com > settings > ssh & gpg keys > add ssh key > "
            "paste key and save."
        ) + "\n" + pub + "\n"
    )

    if MACOS:
        on_clipboard = subprocess.call(["pbcopy <" + SSH_PATH_PUB], shell=True) == 0
    elif LINUX:
        on_clipboard = subprocess.call(["xclip -sel clip < " + SSH_PATH_PUB], shell=True) == 0
    else:
        on_clipboard = False

    if on_clipboard:
        print(green("The above key has been copied to your OS clipboard. Thank me later."))

    while True:
        input("press enter when complete: ")

        if subprocess.call(["ssh -T git@github.com"], shell=True) == 1:
            break
        else:
            print("it doesn't look like you've done it to me...")

    # Requires OAuth permissions
    # user = os.environ.get('USER')
    # machine = os.uname()[1]

    # with tempfile.NamedTemporaryFile("w+") as tf:
    #     with open(tf.name, "w+") as fp:
    #         json.dump({
    #             "title": user + "@" + machine + " [dotfiles]",
    #             "key": pub
    #         }, fp)

    #     subprocess.check_call(
    #         ["hub", "api", "--method", "POST", "/user/keys", "--input", tf.name],
    #         shell=True,
    #     )

exit(0)
