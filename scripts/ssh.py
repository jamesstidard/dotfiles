import re
import os
import json
import tempfile
import subprocess

try:
    input = raw_input
except NameError:
    pass

SSH_PATH = os.path.expanduser("~/.ssh/id_rsa")
SSH_PATH_PUB = os.path.expanduser("~/.ssh/id_rsa.pub")
SSH_PRESENT = os.path.exists(SSH_PATH)


def confirm(msg):
    rsp = input(msg + " [Y/n]: ")
    while True:
        if rsp.lower() in {"", "y", "ye", "yes"}:
            return True
        elif rsp.lower() in {"n", "no"}:
            return False
        else:
            rsp = input("Unknown response, try again. Expecting (yes or no): ")


def grab_github_email():
    rsp = input("GitHub email: ")
    while True:
        if re.search(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$", rsp):
            return rsp
        else:
            rsp = input("Doesn't quite look like a email. Try again: ")


if not SSH_PRESENT:
    make_ssh = confirm(
        "Looks like there's no ssh key for your machine (fresh install). Make one?"
    )
    if not make_ssh:
        exit(0)

    email = grab_github_email()

    subprocess.check_call(["ssh-keygen", "-t", "rsa", "-b", "4096", "-C", email], shell=True)
    subprocess.check_call(["eval", "\"$(ssh-agent -s)\""], shell=True)
    subprocess.check_call(["ssh-add", SSH_PATH], shell=True)


GITHUB_AUTH = subprocess.call(["ssh", "-T", "git@github.com"], shell=True) == 1

if not GITHUB_AUTH:
    user = os.environ.get('USER')
    machine = os.uname()[1]

    with open(SSH_PATH_PUB, "r") as fp:
        pub = fp.read()

    with tempfile.NamedTemporaryFile("w+") as tf:
        with open(tf.name, "w+") as fp:
            json.dump({
                "title": user + "@" + machine + " [dotfiles]",
                "key": pub
            }, fp)

        subprocess.check_call(
            ["hub", "api", "--method", "POST", "/user/keys", "--input", tf.name],
            shell=True,
        )
