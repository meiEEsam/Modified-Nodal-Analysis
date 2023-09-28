function C = C_matrix(column,n_nodes,n_VS,n_L,n_RC,CS,RC,VS,L)

syms s t %laplace operator

C=sym(zeros(column,1));


%currnets of current sources

[n_CS,~]=size(CS);
for i=1:n_CS
    values=split(CS(i,5),',');
    
    if(numel(values)==5)
        if(values(1)=="sin")
           amp=double(values(2));
           phase=double(values(3));
           freq=double(values(4));
           offset=double(values(5));
            
           syms t
           sig_t=amp*sin(freq*t*2*pi+phase)+offset;%time domain
           sig_s=laplace(sig_t);%laplace domain
           if(double(CS(i,3))~=0)
               C(double(CS(i,3)),1)= C(double(CS(i,3)),1)-1*sig_s;
           end
           if(double(CS(i,4))~=0)
               C(double(CS(i,4)),1)= C(double(CS(i,4)),1)+sig_s;
           end
        elseif(values(1)=="cos")
           amp=double(values(2));
           phase=double(values(3));
           freq=double(values(4));
           offset=double(values(5)); 
           syms t
           sig_t=amp*cos(freq*t*2*pi+phase)+offset;%time domain
           sig_s=laplace(sig_t);%laplace domain
           if(double(CS(i,3))~=0)
               C(double(CS(i,3)),1)= C(double(CS(i,3)),1)-1*sig_s;
           end
           if(double(CS(i,4))~=0)
               C(double(CS(i,4)),1)= C(double(CS(i,4)),1)+sig_s;
           end
        end
        
        
    elseif(numel(values)==2)
        
        if(values(1)=="DC")
            sig_t=double(values(2));%time domain
            sig_s=laplace(sym(sig_t));%laplace domain
           if(double(CS(i,3))~=0) 
            C(double(CS(i,3)))= C(double(CS(i,3)))-1*sig_s;
           end
           if(double(CS(i,4))~=0)
            C(double(CS(i,4)))= C(double(CS(i,4)))+sig_s;
           end
         end
        
    end
end


%currents of capacitors' initial voltage

for i=1:n_RC
    if(RC(i,1)=="C")
    
     values=split(RC(i,5),',');
     if(double(RC(i,3))~=0)
        C(double(RC(i,3)),1)=C(double(RC(i,3)),1)+double(values(2))*double(values(1));
     end
     if(double(RC(i,4))~=0)
        C(double(RC(i,4)),1)=C(double(RC(i,4)),1)-1*double(values(2))*double(values(1));
     end
    end 

end

%currents of inductors' initial currents  

for i=1:n_L

    values=split(L(i,5),',');
    C(n_nodes+i,1)= C(n_nodes+i,1)-double(values(1))*double(values(2));
end
  
% vlotage of independent voltage sources

  for i=1:n_VS
    values=split(VS(i,5),',');
    if(numel(values)==5)
        if(values(1)=="sin")
           amp=double(values(2));
           phase=double(values(3));
           freq=double(values(4));
           offset=double(values(5));
            
           syms t
           sig_t=amp*sin(freq*t*2*pi+phase)+offset;%time domain
           sig_s=laplace(sig_t);%laplace domain
           C(n_nodes+n_L+i,1)= C(n_nodes+n_L+i,1)+1*sig_s;
          
           
        elseif(values(1)=="cos")
           amp=double(values(2));
           phase=double(values(3));
           freq=double(values(4));
           offset=double(values(5)); 
           syms t
           sig_t=amp*cos(freq*t*2*pi+phase)+offset;%time domain
           sig_s=laplace(sig_t);%laplace domain
           C(n_nodes+n_L+i,1)= C(n_nodes+n_L+i,1)+1*sig_s;
        end
        
        
    elseif(numel(values)==2)
        
        if(values(1)=="DC")
            sig_t=double(values(2));%time domain
            sig_s=laplace(sym(sig_t));%laplace domain
            C(n_nodes+n_L+i,1)= C(n_nodes+n_L+i,1)+1*sig_s;
        end
        
    end
  end

 
  
    
   









end

