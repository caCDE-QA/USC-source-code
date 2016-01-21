from HQMFIntervalUtil import HQMFIntervalUtil

def strip_quotes(s):
    if (isinstance(s, str) and
        len(s) > 0 and
        s[0] == '"' and
        s[-1]) == '"':
        return s[1:-1]
    else:
        return s

def strip_all_quotes(s):
    if not isinstance(s, str):
        return s
    while len(s) > 0 and s[0] in ('"', "'") and s[-1] == s[0]:
        s = s[1:-1]
    return s
        

def string_to_boolean(sval):
    sval = strip_quotes(sval)
    if sval == 'true':
        return True
    if sval == 'false':
        return False
    elif sval == 'null':
        return  None
    else:
        raise ValueError("bad value for cname : " + str(sval))

def sql_to_string(sql):
    return str(sql.compile(compile_kwargs={"literal_binds": True}, dialect=HQMFIntervalUtil.get_dialect()))
