% simple.m

freqs = {'T' 'B' 'R' 'O' 'N' 'E'; 5/24 1/8 1/8 1/3 1/12 1/8};
tree = genTree(freqs);

code = encode('TOBEORNOTTOBEORTOBEORNOT', tree)

stringOut = decode(code, tree)
