#!/usr/bin/python3

"""
I use tmux, sometimes printing in tmux comes with tailing spaces, and it's damn anonying when
I copy the output to somewhere else. So I wrote this to remove tailing spaces.
"""


import os
import sys


def get_filename() -> str:
    # check argument
    if len(sys.argv) != 2:
        print("./tmuxoutput.py filename")
        sys.exit(-1)

    # check if file exists
    if not os.path.isfile(sys.argv[1]):
        print("file does not exists")
        sys.exit(-1)

    return sys.argv[1]


def load(filename: str) -> [str]:
    with open(filename, 'r') as f:
        return [x.rstrip() for x in f.readlines()]


def write(filename: str, lines: [str]):
    with open(filename, 'w') as f:
        N = len(lines)
        for i in range(N):
            if i == N - 1:
                f.write(lines[i])
            else:
                f.write(lines[i] + '\n')


if __name__ == "__main__":
    filename = get_filename()
    lines = load(filename)
    write(filename, lines)
