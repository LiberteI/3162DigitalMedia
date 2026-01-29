% larger.m

% read Readme file
string = fileread('README');

% Generate the Huffman tree from the string
tree = genTree(string);

% Encode the string using the generated Huffman tree
code = encode(string, tree);

% Decode the string
stringOut = decode(code, tree)