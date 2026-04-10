if __name__ == '__main__':
    scoresheet = {}
    for _ in range(int(input())):
        name = input()
        score = float(input())
        scoresheet[name]=score
    sortedscore = sorted(set(scoresheet.values()))
    listofnames = []
    for value, item in scoresheet.items():
        if item == sortedscore[1]:
            listofnames.append(value)
    listofnames.sort()
    for name in listofnames:
        print(name)
