% simple.m

% symbols with their frequency
freqs = {'T' 'B' 'R' 'O' 'N' 'E'; 5/24 1/8 1/8 1/3 1/12 1/8};

% generate tree using frequency
huffmanTree = genTree(freqs, "huffman");

% shannon tree
shannoFanoTree = genTree(freqs, "shannon");

% encode string using tree defined
huffmanCode = encode('TOBEORNOTTOBEORTOBEORNOT', huffmanTree);
shannoCode = encode('TOBEORNOTTOBEORTOBEORNOT', shannoFanoTree);


% Decode the encoded string using the generated tree

huffmanString = decode(huffmanCode, huffmanTree);
shannonString = decode(shannoCode, shannoFanoTree);

disp("Huffman Encoding");
disp(huffmanCode);
disp("Huffman Decoding")
disp(huffmanString);

disp(" ");

disp("Shannon-Fano Encoding");
disp(shannoCode);
disp("Shannon-Fano Decoding")
disp(shannonString);