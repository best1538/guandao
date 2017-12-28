function [state]=ayuzhi2(Data,number,threshold_pt1,threshold_pt4)
Data=double(Data);
num=4096;
state=zeros(1,num);
address=[];
% pt2=rms(Data);%均方差
% pt3=max(Data);%峰值
% pt4=pt3./pt2;%峰值指标
Data_diff=abs(Data(number/2+1:end,:)-Data(1:number/2,:));
Data_diff=sqrt(sum(power(Data_diff,2))/number/2);
% Data_diff=multimifilter(Data_diff,2);
% Data_diff=abs(Data(number/2+1:end,:)-Data(1:number/2,:));
% Data_diff=sum(Data_diff)/number/2;
for j=1:num
    if (Data_diff(j)>threshold_pt1)%&&(pt4(j)<7.1);
        address=[address,j];
    end
end
[~,n]=size(address);
if n==0
    return
end
recombination=zeros(number,n);
for i=1:n
    recombination(:,i)=Data(:,address(i));
end
%%
pt2=rms(recombination);%均方差
pt3=max(recombination);%峰值
pt4=pt3./pt2;%峰值指标
pt4_th=find(pt4-threshold_pt4>0);
[~,number_dvar]=size(pt4_th);
rejuzhen=zeros(number,number_dvar);
for i=1:number_dvar
%     c=Dvar_th(i)
    rejuzhen(:,i)=recombination(:,pt4_th(i));
end

%%
temp_state=bp_test(rejuzhen);
for i=1:number_dvar
 state(address(pt4_th(i)))=temp_state(i);   
end


