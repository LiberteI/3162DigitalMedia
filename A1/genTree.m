function tree = genTree(stringOrFreqs)
    % GENTREE Generate a Huffman tree either from a given list of
    %   frequencies or from string used to compute frequencies.
    
    if iscell(stringOrFreqs)        % frequencies given
        syms = stringOrFreqs(1, :)';
        freqs = [stringOrFreqs{2, :}]';
    else                            % frequencies not given
        syms = cellstr(char(32:126)');
        syms{1} = ' ';
        count = @(c) sum(ismember(stringOrFreqs, c));
        freqs = cellfun(count, syms);
    end
    
    makeNode = @(c) {c, {}, {}};    % single symbol with empty subtrees
    nodes = cellfun(makeNode, syms(freqs>0), 'UniformOutput', false)';
    freqs = freqs(freqs>0)'/sum(freqs);

    [freqs, idx] = sort(freqs);     % sort by frequency of occurrence
    nodes = nodes(idx);

    tree = Huffman(nodes, freqs);
    tree = tree{1};

end
