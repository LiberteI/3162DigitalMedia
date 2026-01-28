% simple.m

% symbols with their frequency
freqs = {'T' 'B' 'R' 'O' 'N' 'E'; 5/24 1/8 1/8 1/3 1/12 1/8};

% generate tree using frequency
tree = genTree(freqs);

% encode string using tree defined
code = encode('TOBEORNOTTOBEORTOBEORNOT', tree)

% Decode the encoded string using the generated tree
stringOut = decode(code, tree)
