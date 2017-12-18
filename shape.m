function [Data]= shape(Data_put)  
%%
%将多行拼接成一行
Data_put=Data_put'%%目的reshape是把列从上到下排的。
[m,n]=size(Data_put);
Data=reshape(Data_put,1,m*n);
end