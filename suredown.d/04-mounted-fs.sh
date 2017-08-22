#!/bin/sh
df -a | grep -v '^[(sysfs)(proc)(tmpfs)(devpts)]'
