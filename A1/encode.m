function code = encode(string, tree)

    function code = encSym(sym, tree)
        if length(tree{1})==1
            code = [];
        else
            left = tree{2};
            if sum(ismember(left{1}, sym))
                code = [0 encSym(sym, left)];
            else
                code = [1 encSym(sym, tree{3})];
            end
        end
    end

    encodeSymbol = @(c) encSym(c, tree);

    code = arrayfun(encodeSymbol, string, 'UniformOutput', false);
    code = char(48+uint8([code{:}]));

end

