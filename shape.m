function [Data]= shape(Data_put)  
%%
%将多行拼接成一行
Data_put=Data_put'
[m,n]=size(Data_put);
Data=reshape(Data_put,1,m*n);
end