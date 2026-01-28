function string = decode(code, tree)

    function [sym, remainingCode] = dec(code, tree)
        if length(tree{1})==1
            sym = tree{1};
            remainingCode = code;
        elseif code(1)=='0'
            [sym, remainingCode] = dec(code(2:end), tree{2});
        else
            [sym, remainingCode] = dec(code(2:end), tree{3});
        end
    end

    string = [];
    while ~isempty(code)
        [sym, code] = dec(code, tree);
        string = [string sym];
    end

end