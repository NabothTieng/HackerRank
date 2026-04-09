# Enter your code here. Read input from STDIN. Print output to STDOUT
height,width = map(int,input().split())
splitheight = int((height-1)/2)
text=".|."
collection = text
for i in range(splitheight):
    print (collection.center(width,"-"))
    if i < splitheight-1:
        collection = text + collection +text
    
print("WELCOME".center(width,"-"))

for _ in range(splitheight):
    print(collection.center(width,"-"))
    collection = collection[6:]
