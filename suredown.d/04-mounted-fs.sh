#!/bin/sh
df -a | grep -vE '^(sysfs|proc|tmpfs|devpts)'
