function [newNodes, newFreqs] = Huffman(nodes, freqs)

    % HUFFMAN Take a list of nodes and associated freqencies.  Recursively
    %   merge two of the lowest-frequency nodes until there is a single
    %   node left.

  if size(nodes, 2)==1
       newNodes = nodes;
       newFreqs = freqs;
  else
      node1 = nodes{1};
      node2 = nodes{2};
      newNode = {[node1{1}, node2{1}], node1, node2};
      newFreq = freqs(1)+freqs(2);
      
      newFreqs = freqs(3:end);
      newNodes = [nodes(3:2+sum(newFreqs<=newFreq)), ...
                       {newNode}, ...
                       nodes((3+sum(newFreqs<=newFreq)):end)]; 
      newFreqs = [newFreqs(newFreqs<=newFreq), ...
                    newFreq, ...
                    newFreqs(newFreqs>newFreq)];
      
      [newNodes, newFreqs] = Huffman(newNodes, newFreqs);
  end

end