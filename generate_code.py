# coding:utf-8
import re
import image_generator as ig
import time
import sys

from math import cos, sin

def data2str(data):
    if isinstance(data, int):
        if data < 0:
            return "0 - %d'd%d" % (len(bin(data)) - 2, -data)
        return "%d'd%d" % (len(bin(data)) - 2, data)
    if isinstance(data, bool):
        return "%d'd%d" % (1, 1 if data else 0)
    if isinstance(data, str):
        return data
    raise Exception("Unsupported type")


def deal_for(snipet, variables):
    snipet = snipet.lstrip(" ").lstrip("\n")
    if snipet[:3] != "for":
        raise Exception("parse error! Illegal for expression")

    snipet = snipet[3:]

    v_idx = snipet.find("in")
    vs = snipet[:v_idx].replace(" ", "").split(",")
    snipet = snipet[v_idx + 2:]

    start_idx = snipet.find("{")
    #cs_str = snipet[:start_idx].replace(" ", "").replace("\n", "")
    cs_str = snipet[:start_idx].replace("\n", "")
    snipet = snipet[start_idx + 1:]
    pos = list(re.finditer(r"}[^}]+$", snipet))[0].start()
    snipet = snipet[:pos]

    if "eval" in cs_str:
        try:
            cs = eval(cs_str)
        except:
            print(cs_str)
            raise
    elif len(vs) == 1:
        cs = cs_str.replace(" ","").split(",")
        if len(cs) == 0:
            raise Exception("parse error! Illegal for expression")
        try:
            cs = map(int, cs)
        except:
            print(cs)
            raise Exception("parse error! Illegal for expression")
    else:
        l = [x[1:-1] for x in re.findall(r"\(.+?\)", cs_str)]
        cs = []
        for m in l:
            tmp = m.split(",")
            if len(tmp) == 0:
                raise Exception("parse error! Illegal for expression")
            if re.match(r"[0-9]+", tmp[0]):
                tmp = map(int, tmp)
            elif re.match(r"True|False", tmp[0]):
                tmp = map(bool, tmp)
            else:
                raise Exception("parse error! Illegal for expression")

            cs.append(tmp)
    snipet_origin = snipet
    ret = ""
    for local in cs:
        snipet = snipet_origin
        try:
            if isinstance(local, int):
                local_variables = dict({vs[0]: local})
            else:
                local_variables = dict(zip(vs, list(local)))
        except:
            print(snipet)
            print(local)
            raise
        for closure in re.findall(r"{{.+?}}", snipet):
            m = re.match(r"{{ *([A-Za-z][A-Za-z0-9]*) *}}", closure)
            if m:
                name = m.group(1)
                if name in local_variables:
                    snipet = snipet.replace(closure,
                            data2str(local_variables[name]))
                elif name in variables:
                    snipet = snipet.replace(closure,
                            data2str(variables[name]))
                else:
                    print(snipet)
                    raise Exception("NO such variable %s" % name)
                continue
            m = re.match(r"{{ *([A-Za-z][A-Za-z0-9]*) *\+ *([A-Za-z][A-Za-z0-9]*) *}}", closure)
            if m:
                val1 = m.group(1)
                val2 = m.group(2)
                if val1 in local_variables:
                    val1 = local_variables[val1]
                elif val1 in variables:
                    val1 = variables[val1]
                else:
                    raise Exception("NO such variable %s" % val1)
                if val2 in local_variables:
                    val2 = local_variables[val2]
                elif val2 in variables:
                    val2 = variables[val2]
                else:
                    print(snipet)
                    raise Exception("NO such variable %s" % val2)
                snipet = snipet.replace(closure, data2str(val1 + val2))
                continue
            m = re.match(r"{{ *([A-Za-z][A-Za-z0-9]*) *\+ *([A-Za-z][A-Za-z0-9]*) *\+ *([A-Za-z][A-Za-z0-9]*) *}}", closure)
            if m:
                val1 = m.group(1)
                val2 = m.group(2)
                val3 = m.group(3)
                if val1 in local_variables:
                    val1 = local_variables[val1]
                elif val1 in variables:
                    val1 = variables[val1]
                else:
                    raise Exception("NO such variable %s" % val1)
                if val2 in local_variables:
                    val2 = local_variables[val2]
                elif val2 in variables:
                    val2 = variables[val2]
                else:
                    raise Exception("NO such variable %s" % val2)
                if val3 in local_variables:
                    val3 = local_variables[val3]
                elif val3 in variables:
                    val3 = variables[val3]
                else:
                    raise Exception("NO such variable %s" % val3)
                snipet = snipet.replace(closure, data2str(val1 + val2 + val3))
                continue
            raise Exception("Illegal Semantic")
        ret += snipet

    return ret


def deal_snipet(snipet, variables):
    snipet = snipet.replace("[[", "").replace("]]", "")
    if "for" in snipet:
        return deal_for(snipet, variables)


def deal_line_code(code, variables):
    m = re.match(r"^ *([A-Za-z][A-Za-z0-9]*) *= *([0-9]+) *$", code)
    if m:
        variables[m.group(1)] = int(m.group(2))
        return
    m = re.match(r"^ *([A-Za-z][A-Za-z0-9]*) *= *(True|False) *$", code)
    if m:
        variables[m.group(1)] = bool(m.group(2))
        return

    m = re.match(r"^!! *([A-Za-z0-9._]+) *: *(.+?) *(: *([0-9]+) *)? *$", code)
    if m:
        r = ig.Rect(*list(map(int, m.group(2).split(","))))
        try:
            rate = int(m.group(4))
        except:
            rate = 4
        return ig.translate(m.group(1), r, rate)

    m = re.match(r"^import *([A-Za-z0-9_.]+) *$", code)
    if m:
        with open(m.group(1)) as f:
            s = f.read()
            return parse(s)

def parse(s):
    tmp = ""
    result = ""
    variables = {}
    for line in s.split("\n"):
        if len(tmp) == 0:
            m = re.match(r"^ *\[\[(.+)\]\] *$", line)
            if m:
                line_code = m.group(1)
                s = deal_line_code(line_code, variables)
                if s is not None:
                    result += s
            elif "[[" in line:
                tmp += line + "\n"
            else:
                result += line + "\n"
        else:
            tmp += line + "\n"
            if "]]" in line:
                result += deal_snipet(tmp, variables)
                tmp = ""
    return result


if __name__ == '__main__':

    if len(sys.argv) == 2:
        s = open(sys.argv[1], "r").read()
    else:
        s = open("note.v", "r").read()
    result = parse(s)
    t = "\n// [Compile] " + str(time.time())
    result += t
    sys.stderr.write(t+ "\n")
    print(result)
