#!/usr/bin/python
import sys
import argparse

from subprocess import check_output as run

YES = ['yes', 'y', 'Y']
NO = ['no', 'n', 'N']


# deprecated
def get_command():
    print(sys.argv)
    parser = argparse.ArgumentParser()
    print(parser.prog)
    """
    l = []
    l.append(parser.prog)
    return parser.prog
    """
    return sys.argv

def yes_or_no(cmd):
    answer = raw_input("Are you sure "+cmd+"? [Y/N]: ")
    if answer in YES:
        return True
    return False

def do_command(cmd):
    run([cmd])

    
if __name__ == '__main__':
    cmd = get_command()
    
    if yes_or_no(cmd[0]):
        print(cmd)
    
