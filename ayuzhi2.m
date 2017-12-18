function [state]=ayuzhi2(data,threshold_Data_diff)
number=1000;
inc=500;
Data=(enframe(data,number,inc))';
[~,seg]=size(Data);
state=zeros(1,seg);
address=[];
Data_diff=abs(Data(number/2+1:end,:)-Data(1:number/2,:));
Data_diff=sum(Data_diff)/number/2;
for j=1:seg
    if (Data_diff(j)>threshold_Data_diff)%&&(cross_zero(j+1)<threshold_cross_zero)&&(shang(j+1)<threshold_shang)
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


