# coding:utf-8

from PIL import Image
import sys

template = """
if(row == %s && col == %s) begin
    red <= 1'b0;
    green <= 1'b0;
    blue <= 1'b0;
end
"""

class Rect:
    def __init__(self, x, y, w, h):
        self.x = x
        self.y = y
        self.width = w
        self.height = h
    def __repr__(self):
        return "(%d, %d, %d, %d)" % (self.x, self.y, self.width, self.height)

default_rect = Rect(40, 40, 20, 20)


def int2verilogInt(x, bit=32):
    return "%d'd%d" % (bit, x)

assert int2verilogInt(10, 10) == "10'd10"


def translate(filename, definition=default_rect):
    # imageを開き、definitionにあったサイズに変換
    # さらに二値になるように変換
    data = Image(filename) # koko

    x = definition.x
    y = definition.y
    result = ""
    for px in range(definition.width):
        for py in range(definition.height):
            col = int2verilogInt(x + px, 10)
            row = int2verilogInt(y + py, 10)
            result += template % (row, col)
    return result


def parse_def(filename):
    with open(filename, "r") as f:
        s = f.read().split("\n")[0]
        l = s.split(",")
        if len(l) != 4:
            raise Exception("Invalid parse file.")
        x, y, w, h = map(int, l)
        return Rect(x, y, w, h)

assert parse_def("def").__repr__() == "(10, 20, 30, 40)"


if __name__ == '__main__':
    if len(sys.argv) == 1:
        print("python %s [filename]" % sys.argv[0])
    elif len(sys.argv) == 2:
        translate(sys.argv[1])
    else:
        filename = sys.argv[1]
        definition = parse_def(sys.argv[2])
        translate(filename, definition)
