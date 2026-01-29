% function [return type] = Name (arg)
function tree = ShannoFano(symbols, freqs)

    % base case
    % when number of symbols == 1
    if numel(symbols) == 1

        % construct node { value, left_subtree, right_subtree } 
        tree = {symbols{1}, [], []};
        return;
    end
