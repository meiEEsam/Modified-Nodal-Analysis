function [nodes,VS,CCVS,VCVS]= result_display(names,values,n_nodes,n_VS,n_CCVS,n_VCVS)
%voltage of nodes

nodes=strings(n_nodes,2);

for i=1:n_nodes
   nodes(i,1)="voltage of node "+names(i,1);
   nodes(i,2)=string(values(i,1));  
end    
disp(nodes);
%currents of voltage sources
VS=strings(n_VS,2);

for i=1:n_VS
    
   VS(i,1)="current of voltage source "+names(i+n_nodes,1);
   VS(i,2)=string(values(i+n_nodes,1));  
end    
disp(VS);

%currents of CCVS
CCVS=strings(n_CCVS,2);
for i=1:n_CCVS

    CCVS(i,1)="current of CCVS "+names(n_nodes+n_VS+i);
    CCVS(i,2)=string(values(i+n_nodes+n_VS));


end
disp(CCVS);
%currents of VCVS
VCVS=strings(n_VCVS,2);
for i=1:n_VCVS

    VCVS(i,1)="current of VCVS "+names(n_nodes+n_VS+i+n_CCVS);
    VCVS(i,2)=string(values(i+n_nodes+n_VS+n_CCVS));
end
disp(VCVS);




end

