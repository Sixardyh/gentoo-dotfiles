#!/usr/bin/env python3.5

import re
import subprocess
from sys import argv


def hc(args):
    return subprocess.check_output("herbstclient {}".format(args), shell=True)


def getMonitors() -> tuple:
    monitors = str(hc('list_monitors')).split('\\n')
    del monitors[-1]
    tag_names = []
    print(monitors)
    for i, m in enumerate(monitors):
        if 'FOCUS' in m:
            focused_monitor_index = i
        tag_names.append(re.findall('"(.*?)"', m)[0])
    print(tag_names)
    return tag_names, focused_monitor_index


def main(tags: list, focused_monitor: int):
    monitors_amount = len(tags)
    if argv[1] == "plus":
        monitor2focus = focused_monitor + 1
        if monitor2focus <= monitors_amount:
            monitor2focus = focused_monitor - monitors_amount + 1
    elif argv[1] == "minus":
        monitor2focus = focused_monitor - 1
        if monitor2focus <= 0 - monitors_amount:
            monitor2focus = focused_monitor + monitors_amount - 1
    else:
        print("argument must be 'plus' or 'minus'")
        quit()

    print(monitor2focus)
    hc('use {}'.format(tags[monitor2focus]))
    if monitor2focus < 0:
        hc('focus_monitor {}'.format(monitors_amount + monitor2focus))
    else:
        hc('focus_monitor {}'.format(monitor2focus))


if __name__ == '__main__':
    tags, focused_monitor = getMonitors()
    main(tags, focused_monitor)
#    hc('cycle_monitor')

