% larger.m

% read Readme file
string = fileread('README');

% prevent error in decoding unprintable characters in ASCII
%                           NOT ASCII 32 - 126
% regexprep(origin, substitute, replacement)
string = regexprep(string, '[^\x20-\x7E]', ' ');

% generate the Huffman tree from the string
huffmanTree = genTree(string, "huffman");

% generate ShannonFano tree from the string
shannonFanoTree = genTree(string, "shannon");

% encode the string using the generated Huffman tree
huffmanCode = encode(string, huffmanTree);

% encode the string using the generated Shannon-Fano tree
shannonFanoCode = encode(string, shannonFanoTree);

% decode the string
huffmanString = decode(huffmanCode, huffmanTree);
shannonFanoString = decode(shannonFanoCode, shannonFanoTree);

disp("Huffman Encoding");
disp(huffmanCode);

disp("Huffman Decoding");
disp(huffmanString);

disp(" ");

disp("Shannon Encoding");
disp(shannonFanoCode);

disp("Shannon Decoding");
disp(shannonFanoString);