function [VS,CS,VCVS,VCCS,CCVS,CCCS,RC,L,ML,W,G,T,OP,plots] =divide_elements(element_info)
%V=voltage source
%CS=current_source
%VCVS=voltage controlled voltage source  
%VCCS=voltage controlled current source
%CCVS=current controlled voltage source
%CCCS=current controlled current source
%RC=resistors and capacitors
%L=inductance
%ML=mutual inductance
%W=wire
%G=gyrator
%T=transformer
%OP=OP AMP
[row,~]=size(element_info);
for i=1:row
element_info(i,1)=upper(element_info(i,1));
end


VS=strings(nnz(element_info(:,1)=="V"),5);       
CS=strings(nnz(element_info(:,1)=="I"),5);
VCVS=strings(nnz(element_info(:,1)=="VCVS"),5);  
VCCS=strings(nnz(element_info(:,1)=="VCCS"),5);
CCVS=strings(nnz(element_info(:,1)=="CCVS"),5);
CCCS=strings(nnz(element_info(:,1)=="CCCS"),5);
RC=strings(nnz(element_info(:,1)=="C")+nnz(element_info(:,1)=="R"),5);
L=strings(nnz(element_info(:,1)=="L"),5);
ML=strings(nnz(element_info(:,1)=="ML"),5);
W=strings(nnz(element_info(:,1)=="W"),5);
G=strings(nnz(element_info(:,1)=="G"),5);
T=strings(nnz(element_info(:,1)=="T"),5);
OP=strings(nnz(element_info(:,1)=="OP"),5);
plots=strings(nnz(element_info(:,1)=="PLOT"),5);
n1=0;n2=0;n3=0;n4=0;n5=0;n6=0;n7=0;n8=0;n9=0;n10=0;n11=0;n12=0;n13=0;n14=0;
        for i=1:row
          row=i;
            if(element_info(row,1)=="V")
                    n1=n1+1;
                    VS(n1,:)=element_info(row,:);
                   
            elseif(element_info(row,1)=="I")
                    n2=n2+1;
                    CS(n2,:)=element_info(row,:);
            elseif(element_info(row,1)=="VCVS")
                    n3=n3+1;
                    VCVS(n3,:)=element_info(row,:);
            elseif(element_info(row,1)=="VCCS")
                    n4=n4+1;
                    VCCS(n4,:)=element_info(row,:);
            elseif(element_info(row,1)=="CCCS")
                    n5=n5+1;
                    CCCS(n5,:)=element_info(row,:);
            elseif(element_info(row,1)=="CCVS")
                    n6=n6+1;
                    CCVS(n6,:)=element_info(row,:);
            elseif((element_info(row,1)=="C")||((element_info(row,1)=="R")))
                    n7=n7+1;
                    RC(n7,:)=element_info(row,:);
            elseif(element_info(row,1)=="L")
                    n8=n8+1;
                    L(n8,:)=element_info(row,:);
            elseif(element_info(row,1)=="ML")
                    n9=n9+1;
                    ML(n9,:)=element_info(row,:);
            elseif(element_info(row,1)=="W")
                    n10=n10+1;
                    W(n10,:)=element_info(row,:);
            elseif(element_info(row,1)=="G")
                    n11=n11+1;
                    G(n11,:)=element_info(row,:);    
            elseif(element_info(row,1)=="T")
                    n12=n12+1;
                    T(n12,:)=element_info(row,:);
            elseif(element_info(row,1)=="OP")
                    n13=n13+1;
                    OP(n13,:)=element_info(row,:);
           
            elseif(element_info(row,1)=="PLOT")
                    n14=n14+1;
                    plots(n14,:)=element_info(row,:);
                    plots(n14,4)=upper(plots(n14,4));
            end
            
            
            

        end









end

