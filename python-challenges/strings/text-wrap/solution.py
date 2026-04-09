import textwrap

def wrap(string, max_width):
    statement = ""
    i = 1
    for char in string:
        if i <max_width:
            statement = statement+char
            i+=1
        else:
            statement=statement+char+"\n"
            i=1
    return statement

if __name__ == '__main__':
    string, max_width = input(), int(input())
    result = wrap(string, max_width)
    print(result)
