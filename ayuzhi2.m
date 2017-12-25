function [state,seg]=ayuzhi2(data,threshold_pt4)
number=500;
inc=500;
Data=(enframe(data,number,inc))';
[~,seg]=size(Data);
state=zeros(1,seg);
address=[];
pt2=rms(Data);%均方差
pt3=max(Data);%峰值
pt4=pt3./pt2;%峰值指标
% Data_diff=abs(Data(number/2+1:end,:)-Data(1:number/2,:));
% Data_diff=sum(Data_diff)/number/2;
for j=1:seg
    if (pt4(j)>threshold_pt4)%&&(cross_zero(j+1)<threshold_cross_zero)&&(shang(j+1)<threshold_shang)
        address=[address,j];
    end
end
[m,n]=size(address);
if m==0
    return
end
recombination=[];
for i=1:n
    recombination=[recombination,Data(:,address(i))];
end
temp_state=bp_test(recombination);
for i=1:n
 state(address(i))=temp_state(i);   
end


