function B= B_matrix(n_nodes,n_col,VS,CCVS,VCVS,W,L,ML,G,T,OP)
      
syms s %laplace operator


      [n_G,~]=size(G);
      [n_T,~]=size(T);
      [n_W,~]=size(W);
      [n_L,~]=size(L);
      [n_VS,~]=size(VS);
      [n_ML,~]=size(ML);
      [n_OP,~]=size(OP);
      [n_CCVS,~]=size(CCVS);
      [n_VCVS,~]=size(VCVS);
      
   
      n_row=n_L+n_W+2*n_ML+2*n_G+n_OP+n_CCVS+n_VCVS+2*n_T+n_VS;
      B=sym(zeros(n_row,n_col));

      %KVL of inductor
      
      for i=1:n_L
          values=split(L(i,5),',');
          if(double(L(i,3))~=0)
             B(i,double(L(i,3)))=1;
          end
          if(double(L(i,4))~=0)
             B(i,double(L(i,4)))=-1; 
          end
          B(i,n_nodes+n_VS+n_CCVS+n_VCVS+n_W+i)=-1*s*double(values(1));
      end
      
      %KVL of voltage source
      
      for i=1:n_VS
          if(double(VS(i,3))~=0)
            B(i+n_L,double(VS(i,3)))=1;
          end
          if(double(VS(i,4))~=0)
            B(i+n_L,double(VS(i,4)))=-1;
          end
      end 
     
       %KVL of VCVS
       
        for i=1:n_VCVS
            temp=split(VCVS(i,5),',');
          if(double(VCVS(i,3))~=0)  
            B(i+n_L+n_VS,double(VCVS(i,3)))=1;
          end
          if(double(VCVS(i,4))~=0) 
            B(i+n_L+n_VS,double(VCVS(i,4)))=-1;
          end
          if(double(temp(1))~=0)  
            B(i+n_L+n_VS,double(temp(1)))=-1*double(temp(3));
          end
          if(double(temp(2))~=0)
            B(i+n_L+n_VS,double(temp(2)))=double(temp(3));
          end
          
        end 
      
       %KVL of wires
       
        for i=1:n_W
           
          B(i+n_L+n_VS+n_VCVS,double(W(i,3)))=1;
          B(i+n_L+n_VS+n_VCVS,double(W(i,4)))=-1;
          
          
        end 
      
         %KVL of CCVS
        
        
         for i=1:n_CCVS
         if(double(CCVS(i,3))~=0)  
            B(i+n_L+n_VS+n_VCVS+n_W,double(CCVS(i,3)))=1;
         end
         if(double(CCVS(i,4))~=0)
            B(i+n_L+n_VS+n_VCVS+n_W,double(CCVS(i,4)))=-1;
         end  
          for j=1:n_W
              
             temp=split(CCVS(i,5),',');
               if((W(j,3)==temp(1))&&(W(j,4)==temp(2)))
                  
                   B(i+n_L+n_VS+n_VCVS+n_W,n_nodes+n_VS+n_VCVS+n_CCVS+j)=-1*double(temp(3));
                
              end
          
          
          end
            
          
        end 
      
        
        %KVL of mutual inductance
        
        for i=1:n_ML
            nodes_positive1=split(ML(i,3),',');
            nodes_negative1=split(ML(i,4),',');
            values=split(ML(i,5),',');
        if(double(nodes_positive1(1))~=0)    
          B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W,double(nodes_positive1(1)))=1;
        end
        if(double(nodes_positive1(2))~=0)  
          B(i+1+n_L+n_VS+n_VCVS+n_CCVS+n_W,double(nodes_positive1(2)))=1;
        end  
        if(double(nodes_negative1(1))~=0)    
          B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W,double(nodes_negative1(1)))=-1;
        end
        if(double(nodes_negative1(2))~=0) 
          B(i+1+n_L+n_VS+n_VCVS+n_CCVS+n_W,double(nodes_negative1(2)))=-1;
        end  
          
          B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W,n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*i-1)=-1*s*double(values(1));
          
          B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W,n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*i)=-1*s*double(values(3));
          
          B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W,n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*i)=-1*s*double(values(2));
          
          B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W,n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+2*i-1)=-1*s*double(values(3));
          
        end 
        
         %KVL of Op Amp
         
          for i=1:n_OP
              nodes_positive2=split(OP(i,3),',');
              nodes_negative2=split(OP(i,4),',');
          
               if(double(nodes_positive2(2))~=0) 
                B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML,double(nodes_positive2(2)))=1;
               end
               if(double(nodes_positive2(1))~=0) 
                B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML,double(nodes_positive2(1)))=-1*double(OP(i,5));
               end
               if(double(nodes_negative2(2))~=0) 
                B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML,double(nodes_negative2(2)))=-1;
               end
               if(double(nodes_negative2(1))~=0) 
                B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML,double(nodes_negative2(1)))=1*double(OP(i,5));
               end
          
          end
          
         %KVL of gyrator
         
          for i=1:n_G
          
               nodes_positive3=split(G(i,3),',');
               nodes_negative3=split(G(i,4),',');
          if(double(nodes_positive3(2))~=0)
              B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML+n_OP,double(nodes_positive3(2)))=double(G(i,5));
          end
          if(double(nodes_negative3(2))~=0)
              B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML+n_OP,double(nodes_negative3(2)))=-1*double(G(i,5));
          
          end    
              B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML+n_OP,n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+n_ML*2+2*i-1)=1;
              
              
          if(double(nodes_positive3(1))~=0)    
              B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML+n_OP+1,double(nodes_positive3(1)))=-1*double(G(i,5));
          end
           if(double(nodes_negative3(1))~=0)
              B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML+n_OP+1,double(nodes_negative3(1)))=double(G(i,5));
           end  
             B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML+n_OP+1,n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+n_ML*2+2*i)=1;
              
              
          end
        
        %KVL of transformer
        
          for i=1:n_T
              nodes_positive4=split(T(i,3),',');
              nodes_negative4=split(T(i,4),',');
               if(double(nodes_positive4(2))~=0)
                 B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML+2*n_G,double(nodes_positive4(2)))=1;
               end
               if(double(nodes_negative4(2))~=0)
                 B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML+2*n_G,double(nodes_negative4(2)))=-1;
               end
               if(double(nodes_positive4(1))~=0)
                 B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML+2*n_G,double(nodes_positive4(1)))=-1*double(T(i,5));
               end
               if(double(nodes_negative4(1))~=0)
                 B(i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML+2*n_G,double(nodes_negative4(1)))=double(T(i,5));
               end
                B(1+i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML+n_OP+2*n_G,n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+n_ML*2+2*n_G+2*i-1)=1;
                B(1+i+n_L+n_VS+n_VCVS+n_CCVS+n_W+2*n_ML+n_OP+2*n_G,n_nodes+n_VS+n_CCVS+n_VCVS+n_W+n_L+n_ML*2+2*n_G+2*i)=double(T(i,5));
                
          
          end
          
          
        
end