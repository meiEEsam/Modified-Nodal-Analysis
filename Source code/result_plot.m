function  result_plot(values,result,n_nodes,n_CCVS,n_VCVS,n_W,n_VS)

syms t
[row,~]=size(values);
for i=1:row

  if(strcmpi(values(i,2),"voltage")&&strcmpi(values(i,3),"of")&&strcmpi(values(i,4),"node"))
    
    temp=split(values(i,5),'_');
    node_number=temp(2);
    interval=temp(3);
    temp=split(interval,':');
    min=temp(1);
    resolution=temp(2);
    max=temp(3);
    func=result(double(node_number));
    t=linspace(double(min),double(max),double(resolution));
    y=subs(func);
    figure;
    plot(t,y);
    title("voltage of node V_"+node_number);
    xlabel("time(sec)");
    ylabel("voltage(volt)");
    

  end
  
 if(strcmpi(values(i,2),"current")&&strcmpi(values(i,3),"of")&&strcmpi(values(i,4),"VS"))
    temp=split(values(i,5),'_');
    number=temp(2);
    interval=temp(3);
    temp=split(interval,':');
    min=temp(1);
    resolution=temp(2);
    max=temp(3);
    func=result(double(number)+n_nodes);
    t=linspace(double(min),double(max),double(resolution));
    y=subs(func);
    figure;
    plot(t,y);
    title("current of VS_"+number);
    xlabel("time(sec)");
    ylabel("current(amp)");
    

 end

 if(strcmpi(values(i,2),"current")&&strcmpi(values(i,3),"of")&&strcmpi(values(i,4),"L"))
    temp=split(values(i,5),'_');
    number=temp(2);
    interval=temp(3);
    temp=split(interval,':');
    min=temp(1);
    resolution=temp(2);
    max=temp(3);
    func=result(double(number)+n_nodes+n_CCVS+n_VCVS+n_W+n_VS);
   
    t=linspace(double(min),double(max),double(resolution));
    y=subs(func);
    figure;
    plot(t,y);
    title("current of L_"+number);
    xlabel("time(sec)");
    ylabel("current(amp)");
    

 end
 
 
 
end



end

