prompt="Enter the directory of  the input File :";
name_of_file=input(prompt);
tic;
element_information=read(name_of_file);%matrix containing the information of elements
%%
[VS,CS,VCVS,VCCS,CCVS,CCCS,RC,L,ML,W,G,T,OP,plots]=divide_elements(element_information);
%%
[n1,~]=size(VS);[n3,~]=size(VCVS);[n5,~]=size(CCVS);[n7,~]=size(RC);[n8,~]=size(L);[n9,~]=size(ML);[n10,~]=size(W);[n11,~]=size(G);[n12,~]=size(T);[n13,~]=size(OP);
n=node_number(element_information(:,[3 4]));
n=n-1;%subtract ground node
%%
X=determine_unknown(n,n1,n5,n3,n10,n8,n9,n11,n12,n13);
%%
A=A_matrix(n,numel(X),VS,RC,VCVS,CCVS,VCCS,CCCS,W,L,ML,G,T,OP);
%%
B=B_matrix(n,numel(X),VS,CCVS,VCVS,W,L,ML,G,T,OP);
%%
C=C_matrix(numel(X),n,n1,n8,n7,CS,RC,VS,L);
%%
result=[A;B]\C;
result=ilaplace(result);
result=simplify(result);
%%
[a1,a2,a3,a4]=result_display(X,result,n,n1,n5,n3);
ID=fopen('ETC_output.txt','w');
fprintf(ID,'%s\n\n',"--------------voltage of nodes---------------");
for i=1:numel(a1)/2
fprintf(ID,'%s : %s\n',a1(i,1),a1(i,2));
end
if(numel(a2)~=0)
fprintf(ID,'\n\n%s\n\n',"----------current of voltage source----------");
end
for i=1:numel(a2)/2
fprintf(ID,'%s : %s\n',a2(i,1),a2(i,2));
end
if(numel(a3)~=0)
fprintf(ID,'\n\n%s\n\n',"----------------current of CCVS----------------");
end
for i=1:numel(a3)/2
fprintf(ID,'%s  : %s\n',a3(i,1),a3(i,2));
end
if(numel(a4)~=0)
fprintf(ID,'\n\n%s\n\n',"----------------current of VCVS-----------------");
end
for i=1:numel(a4)/2
fprintf(ID,'%s : %s\n',a4(i,1),a4(i,2));
end
fprintf(ID,'\n\n%s\n\n',"----------------------------------------------------------");
time_elapsed=toc;
fprintf(ID,'%s  : %s\n',"simulation time",string(time_elapsed)+" secs");
fclose(ID);
 %%
 result_plot(plots,result,n,n5,n3,n10,n1);

