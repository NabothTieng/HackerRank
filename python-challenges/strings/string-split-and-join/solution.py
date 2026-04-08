def split_and_join(line):
    # write your code here
    splited = line.split(" ")
    return "-".join(splited)
if __name__ == '__main__':
    line = input()
    result = split_and_join(line)
    print(result)
