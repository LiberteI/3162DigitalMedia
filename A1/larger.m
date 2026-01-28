% larger.m

string = fileread('README');
tree = genTree(string);

code = encode(string, tree)

stringOut = decode(code, tree)