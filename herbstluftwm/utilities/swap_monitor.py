#!/usr/bin/env python3

import re
import subprocess
from sys import argv


def hc(args):
    return subprocess.check_output("herbstclient {}".format(args), shell=True)


def getMonitors() -> tuple:
    monitors = str(subprocess.check_output('herbstclient list_monitors | grep -v LOCKED', shell=True)).split('\\n')
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
    print(monitors_amount)
    monitor2focus = focused_monitor + 1
    if monitor2focus <= monitors_amount:
        monitor2focus = focused_monitor - monitors_amount + 1
    monitor2focus = focused_monitor - 1
    if monitor2focus <= 0 - monitors_amount:
        monitor2focus = focused_monitor + monitors_amount - 1

    print(monitor2focus)
    hc('use {}'.format(tags[monitor2focus]))
    if monitor2focus < 0:
        hc('focus_monitor {}'.format(monitors_amount + monitor2focus))
        hc('focus_monitor {}'.format(monitor2focus))


if __name__ == '__main__':
    cycle_target = int(str(subprocess.check_output('herbstclient list_monitors | grep FOCUS', shell=True))[2])
    tags, focused_monitor = getMonitors()
    main(tags, focused_monitor)
    hc('focus_monitor {}'.format(1 - cycle_target))

