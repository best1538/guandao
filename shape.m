function [Data]= shape(Data_put)  
%%
%������ƴ�ӳ�һ��
Data_put=Data_put'
[m,n]=size(Data_put);
Data=reshape(Data_put,1,m*n);
end