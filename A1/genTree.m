function tree = genTree(stringOrFreqs, method)
    % GENTREE Generate a Huffman tree either from a given list of
    %   frequencies or from string used to compute frequencies.
    
    if iscell(stringOrFreqs)        % frequencies given
        % get first row, and all columns
        syms = stringOrFreqs(1, :)';
        
        % get cell row
        freqRow = stringOrFreqs(2, :);

        % covert to column vector
        freqs = cell2mat(freqRow)';

    else                            % frequencies not given
        % ASCII 32 - 126 ie white space, char, num, punctuation
        syms = cellstr(char(32:126)');
        syms{1} = ' ';
        count = @(c) sum(ismember(stringOrFreqs, c));
        freqs = cellfun(count, syms);
    end
    
    % filter syms where syms(freq > 0)
    syms = syms(freqs > 0);

    freqs = freqs(freqs>0)'/sum(freqs);

    [freqs, idx] = sort(freqs);     % sort by frequency of occurrence
   
    syms = syms(idx);
    
    makeNode = @(c) {c, {}, {}};    % single symbol with empty subtrees
    nodes = cellfun(makeNode, syms, 'UniformOutput', false)';

    % choose tree to generate based on method
    if strcmp(method, "huffman")
        tree = Huffman(nodes, freqs);
        tree = tree{1};
    elseif strcmp(method, "shannon")

        % filter out symbols with a frequency of 0
        tree = ShannonFano(syms, freqs);
    end

end