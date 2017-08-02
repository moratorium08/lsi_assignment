# coding:utf-8

import re


def deal_for(snipet, variables):
    snipet = snipet.lstrip(" ").lstrip("\n")
    if snipet[:3] != "for":
        raise Exception("parse error! Illegal for expression")

    snipet = snipet[3:]

    v_idx = snipet.find("in")
    vs = snipet[:v_idx].replace(" ", "").split(",")
    snipet = snipet[v_idx + 2:]

    start_idx = snipet.find("{")
    cs_str = snipet[:start_idx].replace(" ", "").replace("\n", "")
    snipet = snipet[start_idx + 1:].replace("}", "")

    if len(vs) == 1:
        cs = cs_str.split(",")
        if len(cs) == 0:
            raise Exception("parse error! Illegal for expression")

        if isinstance(cs[0], int):
            cs = map(int, cs)
        elif isinstance(cs[0], bool):
            cs = map(int, cs)
        else:
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
    for local in cs:
        assert len(local) == len(vs)
        local_variables = dict(zip(vs, local))
        for closure in re.findall(r"{{.+?}}", snipet):
            pass



    print(vs, cs)
    return "TEST"


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


s = open("note", "r").read()

tmp = ""
result = ""
variables = {}
for line in s.split("\n"):
    if len(tmp) == 0:
        m = re.match(r"^ *\[\[(.+)\]\] *$", line)
        if m:
            line_code = m.group(1)
            deal_line_code(line_code, variables)
            print(variables)
        elif "[[" in line:
            tmp += line
        else:
            result += line
    else:
        tmp += line
        if "]]" in line:
            result += deal_snipet(tmp, variables)
            tmp = ""


if __name__ == '__main__':
    pass

