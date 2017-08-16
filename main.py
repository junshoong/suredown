YES = ['yes', 'y', 'Y']
NO = ['no', 'n', 'N']
def yes_or_no():
    answer = raw_input("Are you sure shutdown? [Y/N]: ")
    if answer in YES:
        return True
    return False
    
if __name__ == '__main__':
    if yes_or_no():
        print('Shutdown!!')
    
