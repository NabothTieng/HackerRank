def swap_case(s):
    changed = []
    for char in s:
        if char.islower():
            changed.append(char.upper())
        elif char.isupper():
            changed.append(char.lower())
        else:
            changed.append(char)
            
        
    result = "".join(changed)
            
    return result

if __name__ == '__main__':
