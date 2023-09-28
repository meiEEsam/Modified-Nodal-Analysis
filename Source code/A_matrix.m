function A= A_matrix(n_nodes,n_col,VS,RC,VCVS,CCVS,VCCS,CCCS,W,L,ML,G,T,OP)

syms s %laplace operator 

% preallocate the  A matrix

A=sym(zeros(n_nodes,n_col));

      %sizes of groups of elements
      
      [n_W,~]=size(W);
      [n_L,~]=size(L);
      [n_G,~]=size(G);
      [n_T,~]=size(T);
      [n_RC,~]=size(RC);
      [n_VS,~]=size(VS);
      [n_ML,~]=size(ML);
      [n_OP,~]=size(OP);
      [n_CCVS,~]=size(CCVS);
      [n_VCVS,~]=size(VCVS);
      [n_VCCS,~]=size(VCCS);
      [n_CCCS,~]=size(CCCS);
      
      
      
      %add conductance of resistors and capacitors to the matrix
      
      for i=1:n_RC
          
          if(RC(i,1)=="R")
                      
                          A(double(RC(i,3)),double(RC(i,3)))= A(double(RC(i,3)),double(RC(i,3)))+1/double(RC(i,5));
                      
                      if(double(RC(i,4))~=0)
                          A(double(RC(i,4)),double(RC(i,4)))= A(double(RC(i,4)),double(RC(i,4)))+1/double(RC(i,5));
                      end
                      if((double(RC(i,3))~=0)&&(double(RC(i,4))~=0))
                          A(double(RC(i,3)),double(RC(i,4)))= A(double(RC(i,3)),double(RC(i,4)))-1/double(RC(i,5));
                          A(double(RC(i,4)),double(RC(i,3)))= A(double(RC(i,4)),double(RC(i,3)))-1/double(RC(i,5));
                      end
          end
           
           if(RC(i,1)=="C")
                values=split(RC(i,5),',');
                
             
                          A(double(RC(i,3)),double(RC(i,3)))= A(double(RC(i,3)),double(RC(i,3)))+double(values(1))*s;
                      
                      if(double(RC(i,4))~=0)
                          A(double(RC(i,4)),double(RC(i,4)))= A(double(RC(i,4)),double(RC(i,4)))+double(values(1))*s;
                      end
                      if((double(RC(i,3))~=0)&&(double(RC(i,4))~=0))
                          A(double(RC(i,3)),double(RC(i,4)))= A(double(RC(i,3)),double(RC(i,4)))-double(values(1))*s;
                          A(double(RC(i,4)),double(RC(i,3)))= A(double(RC(i,4)),double(RC(i,3)))-double(values(1))*s;
                      end   
           end
      
       
      end
     
     
      %add currents of voltage sources 
         
      for i=1:n_VS
            A(double(VS(i,3)),n_nodes+i)=1;
          
          if(double(VS(i,4))~=0)
            A(double(VS(i,4)),n_nodes+i)=-1;
          end
          
      end
      
       %add currents of wires
      
      for i=1:n_W
          A(double(W(i,3)),n_nodes+n_VS+i)=1;
          A(double(W(i,4)),n_nodes+n_VS+i)=-1; 
      end
      
      
      %add currents of CCVS
      
      for i=1:n_CCVS
             
            A(double(CCVS(i,3)),n_nodes+n_VS+n_W+i)=1;
         
         if(double(CCVS(i,4))~=0)  
            A(double(CCVS(i,4)),n_nodes+n_VS+n_W+i)=-1;
         end
      end 
      
      %add currents of VCVS
      
      for i=1:n_VCVS
             
          if(double(VCVS(i,3))~=0)
            A(double(VCVS(i,3)),n_nodes+n_VS+n_CCVS+n_W+i)=1;
          end
          if(double(VCVS(i,4))~=0)
            A(double(VCVS(i,4)),n_nodes+n_VS+n_CCVS+n_W+i)=-1;
          end
      end     
     
      %add currents of inductor
      
      for i=1:n_L
          if(double(L(i,3))~=0)
            A(double(L(i,3)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+i)=1;
          end
          if(double(L(i,4))~=0)
            A(double(L(i,4)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+i)=-1; 
          end
      end
      
      %add currents of mutual inductors
      
      for i=1:n_ML
          nodes_positive1=split(ML(i,3),',');
          nodes_negative1=split(ML(i,4),',');
        
          if(double(nodes_positive1(1))~=0)
            A(double(nodes_positive1(1)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+i)=1;
          end
          if(double(nodes_positive1(2))~=0)
            A(double(nodes_positive1(2)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+i+1)=1; 
          end
          if(double(nodes_negative1(1))~=0)
            A(double(nodes_negative1(1)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+i)=-1;
          end
          if(double(nodes_negative1(2))~=0)
            A(double(nodes_negative1(2)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+i+1)=-1; 
          end
      end
          
       %add currents of  gyrator
       
       for i=1:n_G
          nodes_positive2=split(G(i,3),',');
          nodes_negative2=split(G(i,4),',');
          if(double(nodes_positive2(1))~=0)
            A(double(nodes_positive2(1)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*n_ML+i)=1;
          end
          if(double(nodes_positive2(2))~=0)
            A(double(nodes_positive2(2)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*n_ML+i+1)=1; 
          end
          if(double(nodes_negative2(1))~=0)
            A(double(nodes_negative2(1)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*n_ML+i)=-1;
          end
          if(double(nodes_negative2(2))~=0)
            A(double(nodes_negative2(2)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*n_ML+i+1)=-1;
          end
      end
       
       %add currents of  transformer
       
       for i=1:n_T
          nodes_positive3=split(T(i,3),',');
          nodes_negative3=split(T(i,4),',');
          if(double(nodes_positive3(1))~=0)
          A(double(nodes_positive3(1)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*n_ML+2*n_G+i)=1;
          end
          if(double(nodes_positive3(2))~=0)
          A(double(nodes_positive3(2)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*n_ML+2*n_G+i+1)=1;
          end
          if(double(nodes_negative3(1))~=0)
          A(double(nodes_negative3(1)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*n_ML+2*n_G+i)=-1;
          end
          if(double(nodes_negative3(2))~=0)
          A(double(nodes_negative3(2)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*n_ML+2*n_G+i+1)=-1;
          end
       end
      
       %add currents of  Op Amp
       
       for i=1:n_OP
          nodes_positive4=split(OP(i,3),',');
          nodes_negative4=split(OP(i,4),',');
          if(double(nodes_positive4)~=0)
            A(double(nodes_positive4(2)),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*n_ML+2*n_G+2*n_T+i)=1;
          end
          if(double(nodes_negative4(2))~=0)
            A(double(nodes_negative4),n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*n_ML+2*n_G+i+2*n_T)=-1; 
          end
        end
      
       %add currents of  VCCS
       
       for i=1:n_VCCS
           dependence1=split(VCCS(i,5),',');
          if((double(VCCS(i,3))~=0)&&(double(dependence1(1))~=0)) 
           A(double(VCCS(i,3)),double(dependence1(1)))=A(double(VCCS(i,3)),double(dependence1(1)))+double(dependence1(3));
          end
          
          if((double(VCCS(i,3))~=0)&&(double(dependence1(2))~=0)) 
           A(double(VCCS(i,3)),double(dependence1(2)))=A(double(VCCS(i,3)),double(dependence1(2)))-double(dependence1(3));
          end
          
          if((double(VCCS(i,4))~=0)&&(double(dependence1(1))~=0)) 
           A(double(VCCS(i,4)),double(dependence1(1)))=A(double(VCCS(i,4)),double(dependence1(1)))-double(dependence1(3));
          end
          
          if((double(VCCS(i,4))~=0)&&(double(dependence1(2))~=0)) 
           A(double(VCCS(i,4)),double(dependence1(2)))=A(double(VCCS(i,4)),double(dependence1(2)))+double(dependence1(3));
          end 
          
       
       
       end
       
       %add currents of  CCCS
       
       for i=1:n_CCCS
          dependence2=split(CCCS(i,5),',');
          
          for j=1:n_W
             
              if((W(j,3)==dependence2(1))&&(W(j,4)==dependence2(2)))
                  
                  if(double(CCCS(i,3))~=0)
                    A(double(CCCS(i,3)),n_nodes+n_VS+j)= A(double(CCCS(i,3)),n_nodes+n_VS+j)+double(dependence2(3));
                  end
                  if(double(CCCS(i,4))~=0)
                    A(double(CCCS(i,4)),n_nodes+n_VS+j)= A(double(CCCS(i,4)),n_nodes+n_VS+j)-double(dependence2(3));
                  end
                  
              
              
              end
              
          
          end
          
  
       end
       
       
end