# coding:utf-8


board = [0 for i in range(9)]
"""
board[0] = 2
board[1] = 2
board[2] = 1
board[3] = 2
board[5] = 1
board[7] = 1
"""
player = 2

def print_field():
    p = ""
    for i in range(3):
        for j in range(3):
            x = board[3 * i + j]
            p += "○" if x == 1 else "×" if x == 2 else str(3 * i + j + 1)
            p += " "
        p += "\n"
    print(p)

def print_board(b):
    p = ""
    b = [x - 2 if x > 2 else x for x in b]
    for i in range(3):
        for j in range(3):
            x = b[3 * i + j]
            p += "1" if x == 1 else "2" if x == 2 else "0"
            p += " "
        p += "\n"
    print(p)


def put(l, x, p):
    l[x] = p
    p ^= 0b11
    return p


def validate(l, s):
    try:
        x = int(s)
        if x >= 1 and x <= 9 and board[x - 1] == 0:
            return x - 1
        return -1
    except:
        return -2

def check(l):
    l = [x - 2 if x > 2 else x for x in l]
    for i in range(3):
        if l[3*i] == l[3*i + 1]  == l[3 * i + 2] != 0:
            return l[3 * i]
    for i in range(3):
        if l[i] == l[3 + i] == l[6 + i]  != 0:
            return l[i]
    if l[0] == l[4] == l[8] != 0:
        return l[4]
    if l[2] == l[4] == l[6] != 0:
        return l[4]
    return 0 if 0 in l else 3

class VerilogSimulator:
    def __init__(self, board):
        self.board = board[:]
        self.my_turn = 2
        self.see = 0
        self.next_put = 9
        self.put = [9 for i in range(9)]
        self.draw_put = [9 for i in range(9)]
        self.cnt = 0
        self.current_winner = 8

    def debug(self):
        print("cnt:",self.cnt)
        print("current_winner:", self.current_winner)
        print("my turn:", self.my_turn)
        print("see :", self.see)
        print("put :",self.put)
        print("draw_put:",self.draw_put)
        print_board(self.board)
        input()

    def search(self):
        while self.next_put == 9:
            self.loop()
        # self.initialize()
        return self.next_put

    def initialize(self):
        for i in range(9):
            if self.board[i] == 3:
                self.board[i] = 0
            elif self.board[i] == 4:
                self.board[i] = 0
        self.put = [9 for i in range(9)]
        self.draw_put = [9 for i in range(9)]
        self.cnt = 0
        self.see = 0
        self.my_turn = 2
        self.current_winner = 8

    def loop(self):
        # self.debug()
        w = check(self.board)
        if self.current_winner == 8 and w != 0:
            self.current_winner = w
            self.cnt -= 1
            self.my_turn ^= 0b11
        elif self.current_winner == self.my_turn and self.cnt == 0:
            self.next_put = self.put[0]
        elif self.see > 8:
            if self.draw_put[self.cnt] != 9:
                self.current_winner = 3
            else:
                self.current_winner = self.my_turn ^ 0b11
            self.put[self.cnt] = self.draw_put[self.cnt]
            self.draw_put[self.cnt] = 9

            if self.cnt == 0:
                if self.put[0] == 9:
                    for i in range(9):
                        if self.board[i] == 0:
                            self.next_put = i
                            break
                else:
                    self.next_put = self.put[0]
            else:
                self.see = self.put[self.cnt - 1]
                self.cnt -= 1
                self.my_turn ^= 0b11
        else:
            if self.current_winner == 8:
                #print(self.board, self.cnt)
                flag = False
                for i in range(9):
                    if self.see == i and self.board[i] == 0:
                        self.board[i] = self.my_turn + 2
                        self.put[self.cnt] = i
                        self.my_turn ^= 0b11
                        self.cnt += 1
                        self.see = 0
                        flag = True
                if not flag:
                    self.see += 1
            # backward
            else:
                if self.current_winner == self.my_turn:
                    self.board[self.put[self.cnt]] = 0
                    self.put[self.cnt] = 9
                    self.see = self.put[self.cnt - 1]
                    self.cnt -= 1
                    self.my_turn ^= 0b11
                elif self.current_winner == 3:
                    self.current_winner = 8
                    self.draw_put[self.cnt] = self.put[self.cnt]
                    self.see = self.put[self.cnt] + 1
                    self.board[self.put[self.cnt]] = 0
                    self.put[self.cnt] = 9
                else:
                    self.board[self.put[self.cnt]] = 0
                    self.see += 1
                    self.current_winner = 8


def dfs(l, turn):
    flag = True
    for x in l:
        if x != 0:
            flag = False
    if flag:
        return (4, -1)

    w = check(l)
    if w != 0:
        return (-1, w)
    draw = -1
    for i in range(9):
        if l[i] == 0:
            t = put(l, i, turn)
            ret, w = dfs(l, t)
            l[i] = 0
            if w == turn:
                return (i, w)
            elif w == 3:
                draw = i
    return (draw, turn ^ 0b11 if draw == -1 else 3)

while True:
    print_field()
    if player == 1:
        s = input()
        v = validate(board, s)
        if v >= 0:
            player = put(board, v, player)
        else:
            print("Retry")
    else:
        #v, _ = dfs(board[:], player)
        vs = VerilogSimulator(board[:])
        v = vs.search()
        #print(v)
        player = put(board, v, player)
    w = check(board)
    if w != 0:
        print_field()
        if w == 3:
            print("draw")
        else:
            print("Winner player %d" % w)
        break

