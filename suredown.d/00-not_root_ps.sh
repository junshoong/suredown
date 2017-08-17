#!/bin/sh
ps -eo %U%p%c%a | grep -v '^root'
