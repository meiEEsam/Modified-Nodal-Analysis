function outputArg = node_number(nodes)
%count the number of the nodes
i=1;
number_of_nodes=0;
while(i>=1)
    if(nnz(nodes==string(i-1))>0)
        number_of_nodes=number_of_nodes+1;
    else
       break
    end
    i=i+1;
end
outputArg=number_of_nodes;
end

