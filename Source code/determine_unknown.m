function outputArg=determine_unknown(n_nodes,n_VS,n_CCVS,n_VCVS,n_wire,n_L,n_ML,n_gyrator,n_transformer,n_OP)
temp=n_nodes+n_VS+n_L+n_CCVS+n_VCVS+n_wire+2*n_gyrator+2*n_transformer+n_OP+2*n_ML;
unknowns=strings(temp,1);
    for i=1:n_nodes
    unknowns(i,1)="V_"+string(i);
    end
    for i=1:n_VS
    unknowns(i+n_nodes,1)="I(VS)_"+string(i);
    end
    for i=1:n_wire
    unknowns(i+n_nodes+n_VS,1)="I(W)_"+string(i);
    end
    for i=1:n_CCVS
    unknowns(i+n_nodes+n_VS+n_wire,1)="I(CCVS)_"+string(i);
    end
    for i=1:n_VCVS
    unknowns(i+n_nodes+n_VS+n_CCVS+n_wire,1)="I(VCVS)_"+string(i);
    end
    for i=1:n_L
    unknowns(i+n_nodes+n_VS+n_CCVS+n_VCVS+n_wire,1)="I(L)_"+string(i);
    end 
    for i=1:n_ML
    unknowns(i+n_nodes+n_VS+n_CCVS+n_VCVS+n_wire+n_L,1)="I(ML)1_"+string(i);
    unknowns(1+i+n_nodes+n_VS+n_CCVS+n_VCVS+n_wire+n_L,1)="I(ML)2_"+string(i)+1;
    end 
    for i=1:n_gyrator
    unknowns(i+n_nodes+n_VS+n_CCVS+n_VCVS+n_wire+n_L+2*n_ML,1)="I(G)1_"+string(i);
    unknowns(1+i+n_nodes+n_VS+n_CCVS+n_VCVS+n_wire+n_L+2*n_ML,1)="I(G)2_"+string(i)+1;
    end  
    for i=1:n_transformer
    unknowns(i+n_nodes+n_VS+n_CCVS+n_VCVS+n_wire+n_L+2*n_ML+2*n_gyrator,1)="I(T)1_"+string(i);
    unknowns(1+i+n_nodes+n_VS+n_CCVS+n_VCVS+n_wire+n_L+2*n_ML+2*n_gyrator,1)="I(T)2_"+string(i)+1;
    end  
    for i=1:n_OP
    unknowns(i+n_nodes+n_VS+n_CCVS+n_VCVS+n_wire+n_L+2*n_ML+2*n_gyrator+2*n_transformer,1)="I(OP)_"+string(i);
    end 
    
    outputArg=unknowns;
end

