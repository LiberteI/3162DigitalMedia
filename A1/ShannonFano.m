% function [return type] = Name (arg)
function tree = ShannonFano(symbols, freqs)

    % base case
    % when number of symbols == 1
    if numel(symbols) == 1

        % construct node { symbol, left_subtree, right_subtree } 
        tree = {symbols{1}, [], []};
        return;
    end
    
    % sort frequency descending
    [freqs, idx] = sort(freqs, 'descend');
    symbols = symbols(idx);
    
    % total frequency
    totalFreq = sum(freqs);
    % left collection sum of frequency
    leftSum = 0;

    % initialise split index to 1
    splitIdx = 1;

    % 1 based index
    % add frequency from the first element to total number of elements
    for i = 1: numel(freqs)
        leftSum = leftSum + freqs(i);
        if leftSum >= totalFreq / 2
            splitIdx = i;
            break;
        end
    end

    % guard tree so that tree wont be empty
    if splitIdx == numel(freqs)
        splitIdx = splitIdx - 1;
    end

    % create left sub trees 1 to split idx
    leftSymbols = symbols(1:splitIdx);
    leftFreqs = freqs(1:splitIdx);

    % create right sub trees splitIdx + 1 to end
    rightSymbols = symbols(splitIdx+1:end);
    rightFreqs = freqs(splitIdx+1:end);
    
    % recursively generate more nodes
    leftTree = ShannonFano(leftSymbols, leftFreqs);
    rightTree = ShannonFano(rightSymbols, rightFreqs);
    
    % construct the tree with subtrees
    tree = {[leftTree{1}, rightTree{1}], leftTree, rightTree};
end