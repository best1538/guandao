clear
clc
load('I:\data\20170802124139.mat');
[m,~]=size(data_c1);
 state=[];
for i=1:m
    data=data_c1(i,:);
    state_temp=ayuzhi2(data,1.12);
    state(i,:)=state_temp
end
save('state.mat','state')



