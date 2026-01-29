% larger.m

% read Readme file
text = fileread('README');

% prevent error in decoding unprintable characters in ASCII
%                           NOT ASCII 32 - 126
% regexprep(origin, substitute, replacement)
text = regexprep(text, '[^\x20-\x7E]', ' ');

% generate the Huffman tree from the string
huffmanTree = genTree(text, "huffman");

% generate ShannonFano tree from the string
shannonFanoTree = genTree(text, "shannon");

% encode the string using the generated Huffman tree
huffmanCode = encode(text, huffmanTree);

% encode the string using the generated Shannon-Fano tree
shannonFanoCode = encode(text, shannonFanoTree);

% decode the string
huffmanString = decode(huffmanCode, huffmanTree);
shannonFanoString = decode(shannonFanoCode, shannonFanoTree);

% print encoding and recovered decoding
disp("Huffman Encoding");
disp(huffmanCode);

disp("Huffman Decoding");
disp(huffmanString);

disp(" ");

disp("Shannon Encoding");
disp(shannonFanoCode);

disp("Shannon Decoding");
disp(shannonFanoString);

% assume every char in string is stored 8 bits
originalBitCount = numel(text) * 8;

% calculate the bit count for Huffman and Shannon-Fano codes
huffmanBitCount = numel(huffmanCode);
shannonFanoBitCount = numel(shannonFanoCode);

% calculate compression rate
huffmanCompressionRate = huffmanBitCount / originalBitCount;

shannonFanoCompressionRate = shannonFanoBitCount / originalBitCount;

disp(" ");

% display compression rates
fprintf('Huffman Compression Rate: %.4f\n', huffmanCompressionRate);
fprintf('Shannon-Fano Compression Rate: %.4f\n', shannonFanoCompressionRate);