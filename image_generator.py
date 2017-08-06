# coding:utf-8

from PIL import Image
from PIL import ImageFont
from PIL import Image
from PIL import ImageDraw
import numpy


import sys


template = """
if(row >= %s && row < %s && col >= %s && col < %s) begin
    {red, green, blue} <= 3'b000;
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


def translate(filename, definition=default_rect, rate=4):
    # imageを開き、definitionにあったサイズに変換
    # さらに二値になるように変換
    im = Image.open(filename)
    im = im.convert("L")
    im = im.resize((definition.width, definition.height), Image.LANCZOS)
    imgArray = numpy.asarray(im).T
    # im.show()

    x = definition.x
    y = definition.y
    result = ""
    for px in range(definition.width):
        for py in range(definition.height):
            if imgArray[px, py] < 100:
                col = int2verilogInt(x + rate * px, 10)
                row = int2verilogInt(y + rate * py, 10)
                col2 = int2verilogInt(x + rate * px + rate , 10)
                row2 = int2verilogInt(y + rate * py + rate, 10)
                result += template % (row, row2, col, col2)
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
        ret = translate(sys.argv[1])
        with open("result", "w") as f:
            f.write(ret)
    else:
        filename = sys.argv[1]
        definition = parse_def(sys.argv[2])
        with open("result", "w") as f:
            f.write(translate(filename, definition))
