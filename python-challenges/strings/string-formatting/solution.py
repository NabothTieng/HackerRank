def print_formatted(number):
    # your code goes here
    width = len(bin(number))-2
    
    for n in range(number+1):
        if n > 0:
            decimal = n
            octal = oct(n)[2:].upper()
            hexadecimale = hex(n)[2:].upper()
            binary = bin(n)[2:]
            
            print(
                f"{decimal:>{width}} "
                f"{octal:>{width}} "
                f"{hexadecimale:>{width}} "
                f"{binary:>{width}} ")
           

if __name__ == '__main__':
    n = int(input())
    print_formatted(n)
