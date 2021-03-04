#!/usr/bin/env python3

import os
import sys
import socket
import platform
import subprocess

HERE = os.path.dirname(__file__)
VCP_CODE_INPUT_SELECT = 60
MONITORS = {
    "4k": {
        "Monitor Device Name": r"\\.\DISPLAY2\Monitor0",
        "Monitor Name": r"DELL U2718Q",
        "Serial Number": r"FN84K89510GL",
        "Adapter Name": r"NVIDIA GeForce RTX 2070 SUPER",
        "Monitor ID": r"MONITOR\DELA0EC\{4d36e96e-e325-11ce-bfc1-08002be10318}\0003",
        "Input Value": {
            "DP": 15,
            "mDP": 16,
            "HDMI": 17,
        },
    },
    "2k": {
        "Monitor Device Name": r"\\.\DISPLAY1\Monitor0",
        "Monitor Name": r"S2719DGF",
        "Serial Number": r"1XTP7P2",
        "Adapter Name": r"NVIDIA GeForce RTX 2070 SUPER",
        "Monitor ID": r"MONITOR\DELD0E6\{4d36e96e-e325-11ce-bfc1-08002be10318}\0001",
        "Input Value": {
            "DP": 15,
            "HDMI 1.0": 17,
            "HDMI 2.0": 18,
        },
    },
}
HOST_INPUT = {
    "freebie": {
        "4k": "mDP",
        "2k": "HDMI 1.0",
    },
    "nigel": {
        "4k": "HDMI",
        "2k": "HDMI 2.0",
    },
    "muttson": {
        "4k": "DP",
        "2k": "DP",
    },
}

try:
    hostname = sys.argv[1]
except IndexError:
    hostname = socket.gethostname()

if platform.system() == "Windows":
    binary = os.path.join(HERE, "ControlMyMonitor.exe")

    for display, input_ in HOST_INPUT[hostname].items():
        serial = MONITORS[display]["Serial Number"]
        value = MONITORS[display]["Input Value"][input_]
        cmd = [binary, "/SetValue", serial, VCP_CODE_INPUT_SELECT, value]
        cmd = [str(arg) for arg in cmd]
        subprocess.check_call(cmd)

elif platform.system() == "Darwin":
    binary = os.path.join(HERE, "ddcctl")

    for display, input_ in HOST_INPUT[hostname].items():
        serial = MONITORS[display]["Serial Number"]
        value = MONITORS[display]["Input Value"][input_]

        for n in range(1, 3):
            # determin if right display number
            output = subprocess.run(
                ["configs/display/ddcctl", "-d", str(n)],
                check=True,
                stdout=subprocess.PIPE,
            )

            if serial in output.stdout.decode("utf8"):
                cmd = [binary, "-d", n, "-i", value]
                cmd = [str(arg) for arg in cmd]
                subprocess.check_call(cmd)
                break

else:
    raise NotImplementedError("Unsupported platform", platform.system())
