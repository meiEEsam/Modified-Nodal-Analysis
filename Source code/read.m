function  output= read(inputArg1)
inputs=importdata(char(inputArg1),'%s');
row=numel(inputs);
string_inputs=string(inputs);
%create an array of strings and save splitted data in it
element_info=strings(row,5);
for i=1:row
     temp_cell=split(string_inputs(i));
     element_info(i,1)=string(temp_cell(1));%type
     element_info(i,2)=string(temp_cell(2));%name
     element_info(i,3)=string(char(temp_cell(3)));%node1
     element_info(i,4)=string(char(temp_cell(4)));%node2
     element_info(i,5)=string(char(temp_cell(5)));%value and dependence
end 

output=element_info;
end

